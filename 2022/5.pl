#!/usr/bin/perl
use warnings;
use strict;

die("Usage: $0 <input_file>") unless(@ARGV);

my @stacks = ();
my @stacks9001 = ();

# Initial crate setup
while (<>) {
	chomp($_);
	if ($_ eq "") {
		last;
	}

	my @tmp = $_ =~ /[\s\[]([A-Z\s])[\s\]]\s?/g;
	for (0..$#tmp) {
		unshift(@{$stacks[$_]}, $tmp[$_]) if ($tmp[$_] ne " ");
	}
}
@stacks9001 = map([@$_], @stacks);

# Execute steps
while (<>) {
	chomp($_);
	my ($amt, $from, $to) = /move (\d+) from (\d+) to (\d+)/;
	push(@{$stacks[$to - 1]}, pop(@{$stacks[$from - 1]})) for (1..$amt);
	push(@{$stacks9001[$to - 1]}, splice(@{$stacks9001[$from - 1]}, -$amt));
}

print("part1: "); print("@$_[-1]") for (@stacks); print("\n");
print("part2: "); print("@$_[-1]") for (@stacks9001); print("\n");
