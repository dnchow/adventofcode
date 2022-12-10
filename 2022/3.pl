#!/usr/bin/perl
use warnings;
use strict;

die("Usage: $0 <input_file>") unless(@ARGV);

sub prio {
	my $prio = ord($_[0]) - 96;
	return $prio > 0 ? $prio : $prio + 58;
}

sub get_common {
	my $item = shift;
	$item =~ s/[^$_]|(.)(?=.*\1)//g for (@_);
	return $item;
}

my $item_sum = 0;
my $badge_sum = 0;
my @group = ();

while (<>) {
	chomp($_);
	my $len = length($_) / 2;

	# get total priority of common items in each pouch
	$item_sum += prio(get_common($_ =~ /(.{$len})(.{$len})/));

	# get total priority of the badges in each group of 3
	push(@group, $_);
	if (@group == 3) {
		$badge_sum += prio(get_common(@group));
		@group = ();
	}
}

print("part1: $item_sum\n");
print("part2: $badge_sum\n");
