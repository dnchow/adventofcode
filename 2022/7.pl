#!/usr/bin/perl
use warnings;
use strict;

die("Usage: $0 <input_file>") unless(@ARGV);

# %dir  (name, parent, dirs, files)
# %file (name, size)

my $SIZE_MAX  = 70000000;
my $SIZE_NEED = 30000000;

my $cmd;
my %root = (name => '/');
my @dir_sizes = ();
my $cwd = \%root;

sub add_dir {
	my $path = shift;

	# existing dir
	for (@{$cwd->{dirs}}) {
		return $_ if ($_->{name} eq "$path");
	}

	# new dir
	my %dir = (name => "$path",
		   parent => $cwd);
	push(@{$cwd->{dirs}}, \%dir);
	return \%dir;
}

sub add_file {
	my ($size, $name) = @{$_[0]};

	#existing file
	for (@{$cwd->{files}}) {
		return if ($_->{name} eq "$name");
	}

	# new file
	my %file = (name => "$name",
	            size => "$size");
	push(@{$cwd->{files}}, \%file);
}

sub do_cd {
	my $path = shift;
	if (!$path || $path eq "/") {
		$cwd = \%root;
	} elsif ($path eq "..") {
		$cwd = $cwd->{parent} if ($cwd->{parent});
	} else {
		$cwd = add_dir($path);
	}
}

sub do_ls {
	my @args = split(/\s/, $_);

	if ($args[0] eq 'dir') {
		add_dir($args[1])
	} else {
		add_file(\@args);
	}
}

sub sizeof_dir {
	my $size = 0;

	for (@{$_[0]->{dirs}}) {
		$size += sizeof_dir($_);
	}

	for (@{$_[0]->{files}}) {
		$size += $_->{size};
	}

	push(@dir_sizes, $size);
	return $size;
}

# assumes starting at prompt in root dir
while (<>) {
	chomp($_);
	my $args;

	# parse cmd
	if ($_ =~ s/^\$ (.*$)/$1/) {
		($cmd, $args) = split(/\s/, $_);
	}

	die("Invalid command: $cmd\n") unless($cmd =~ /(cd|ls)/);

	if ($cmd eq 'cd') {
		do_cd($args);
	} else {
		do_ls($_) unless ($_ eq 'ls');
	}
}

my $lt_100000 = 0;
my $need = $SIZE_NEED - ($SIZE_MAX - sizeof_dir(\%root));
my $min = $SIZE_MAX;
for(@dir_sizes) {
	$lt_100000 += $_ if ($_ <= 100000);
	$min = $_ if ($_ >= $need && $_ < $min);
}

print("part1: $lt_100000\n");
print("part2: $min\n");
