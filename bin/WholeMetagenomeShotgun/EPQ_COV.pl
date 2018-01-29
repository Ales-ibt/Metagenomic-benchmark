#!/usr/bin/perl -w
use strict;
my $file = $ARGV[0];
print $file; <STDIN>;
my $lines = `test=$file; wc -l $file`; 
chomp $lines;
print $lines; <STDIN>; 
my $q = (split /\s/, $lines)[0]; 
my $vp = 0;
my $fp = 0;
my $cov = 0;
my $epq = 0;
while (<>) { 
	chomp;
	my $TF = (split /\t/)[1];
	if ($TF eq "TRUE") {
		$vp++;
		$cov = ($vp/$q)*100;
	} else {
		$fp++;
		$epq = ($fp/$q)*100; 
	} 
	print "$_\t$cov\t$epq\n";
}
