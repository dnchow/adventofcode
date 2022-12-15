#!/usr/bin/perl
use warnings;
use strict;

die("Usage: $0 <input_file>") unless(@ARGV);

my $pkt_index = 0;
my $msg_index = 0;

my $regex = "(.)(?!\\1)";
my $pkt_regex = $regex;
my $msg_regex = $regex;
$pkt_regex =~ s/(\(\?[^)]*)\)$/$1)(.)$1|\\$_)/ for (2..4);
$msg_regex =~ s/(\(\?[^)]*)\)$/$1)(.)$1|\\$_)/ for (2..14);

# Initial crate setup
while (<>) {
	chomp($_);
	$_ =~ /$pkt_regex/;
	$pkt_index = $+[0];

	$_ =~ /$msg_regex/;
	$msg_index = $+[0];
}

print("part1: $pkt_index\n");
print("part2: $msg_index\n");
