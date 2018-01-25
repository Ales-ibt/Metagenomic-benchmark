#!/usr/bin/perl -w
use strict;

die "USAGE: $0 <metaphlan table>\n" unless @ARGV;

open TAXID, "taxid_metaphlan.txt" or die "taxid_metaphlan.txt not found\n";
my $file = shift;
open IN, "$file";
open NOTAX, ">$file.notax";
open NEW, ">$file.withTAXID";
my %taxes;
&READTAX;

while (<IN>) {
	chomp;
	#print; <STDIN>;
	if (/^seq_id/) {
		print NEW "$_\n";
	} else {
		my @line = split(/\t/, $_);
		#print "---$line[1]"; <STDIN>;
		if ($taxes{$line[1]}) {
			$line[1] = $taxes{$line[1]};
			my $newline = join("\t",@line);
			print NEW "$newline\n";
		} else {
			print STDERR "$line[1] not found in taxid.txt\n";
			print NOTAX "$_\n";
		}
	}	
}

sub READTAX {
#print "entro rutina"; <STDIN>;
while (<TAXID>) {
	next if (/^id/);
	my @line = split;
	$taxes{$line[0]} = $line[1];
}
#print "termino rutina"; <STDIN>;
}

