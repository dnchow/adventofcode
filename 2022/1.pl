#!/usr/bin/perl
use warnings;
use strict;

die("Usage: $0 <input_file>") unless(@ARGV);

my $sum = 0;
my $total = 0;
my @calories = ();

# reverse sorted sums
while (<>) {
	$sum += $_ if ($_ ne "\n");

	if ($_ eq "\n" || eof) {
		push(@calories, $sum);
		$sum = 0;
	}
}
@calories = sort {$b <=> $a} @calories;

$total += $calories[$_] for (0..2);
print("part1: $calories[0]\n");
print("part2: $total\n");
