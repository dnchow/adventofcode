#!/usr/bin/perl
use warnings;
use strict;

die("Usage: $0 <input_file>") unless(@ARGV);

my $contains = 0;
my $overlaps = 0;

while (<>) {
	chomp($_);
	my ($min1, $max1, $min2, $max2) = split(/[-,]/, $_);

	if (($min1 <= $min2 && $max1 >= $max2) ||
	    ($min2 <= $min1 && $max2 >= $max1)) {
		$contains++;
	}

	if ($min1 <= $max2 && $max1 >= $min2) {
		$overlaps++;
	}
}

print("part1: $contains\n");
print("part2: $overlaps\n");
