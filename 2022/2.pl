#!/usr/bin/perl
use warnings;
use strict;

die("Usage: $0 <input_file>") unless(@ARGV);

# use fixed values for each combination
my %points = (
	'A X' => 4, 'A Y' => 8, 'A Z' => 3,
	'B X' => 1, 'B Y' => 5, 'B Z' => 9,
	'C X' => 7, 'C Y' => 2, 'C Z' => 6
);
my %real_points = (
	'A X' => 3, 'A Y' => 4, 'A Z' => 8,
	'B X' => 1, 'B Y' => 5, 'B Z' => 9,
	'C X' => 2, 'C Y' => 6, 'C Z' => 7
);
my $score = 0;
my $real_score = 0;

while (<>) {
	chomp($_);
	$score += $points{$_};
	$real_score += $real_points{$_};
}
print("part1: $score\n");
print("part2: $real_score\n");
