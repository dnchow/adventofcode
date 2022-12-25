#!/usr/bin/perl
use warnings;
use strict;

die("Usage: $0 <input_file>") unless(@ARGV);

my @rows;
my @columns;

while (<>) {
	chomp($_);
	my @c = split(//,$_);
	
	push(@rows, $_);
	for (0..(@c - 1)) {
		$columns[$_] .= $c[$_];
	}
}

my $visible = 0;
my $max_dist = 0;

for my $i (0..(@rows - 1)) {
	for (0..(@columns - 1)) {
		if ($i == 0 || $i == @rows - 1 ||
		    $_ == 0 || $_ == @columns - 1) {
			$visible++;
			next;
		}

		my $height = substr($rows[$i], $_, 1);
		my @dirs;
		push(@dirs, scalar reverse substr($rows[$i], 0, $_));
		push(@dirs, substr($rows[$i], $_ + 1));
		push(@dirs, scalar reverse substr($columns[$_], 0, $i));
		push(@dirs, substr($columns[$_], $i + 1));
		my $tmp = 0;
		my $dist = 1;

		for (@dirs) {
			if (not $_ =~ /[$height-9]/) {
				$tmp++;
				$dist *= length($_);
			} else {
				$dist *= $-[0] + 1;
			}
		}
		$visible++ if ($tmp > 0);
		$max_dist = $dist if ($dist > $max_dist);
	}
}

print("part1: $visible\n");
print("part2: $max_dist\n");
