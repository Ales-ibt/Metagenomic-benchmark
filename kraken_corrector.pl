#!/usr/bin/perl
use strict;
use warnings;

######## THIS PROGRAM CONVERTS THE kraken.report TABLE IN THE COUNT MATRIX FORMAT  #######
######## Alejandra Escobar Zepeda, USMB, IBt, UNAM
######## 18/Julio/2016

scalar@ARGV == 1 || die "usage: $0 <kraken.report> 
Requires lineage_ete_id.py in the current directory
Requires ete2 installed
" ;

my $file=$ARGV[0];
my %kraken;
my $total_krak=0;
open (KRAKOUT, $file) or die ("I can not open the file $file\n");
while (<KRAKOUT>) {
	chomp;
	my@line=split('\t', $_);
	if ($line[2] > 0 && $line[3] !~ '-' && $line[4] > 0) {
		$kraken{$line[4]}=$line[2];
	}
}
close(KRAKOUT);

ETE(\%kraken);

## Subroutine calling the python script to obtain the complete NCBI phylogeny
sub ETE {
	my %hash_sub=%{$_[0]};
	my %regresa;
	open TMP, ">names.tmp.list", or die ("I can not create the temporal file\n");
	foreach my $llave (sort keys %hash_sub){
		print TMP "$llave\t$hash_sub{$llave}\n";
	}
	close(TMP);

	open ETE, ">ete_names.out", or die ("I can not open the file ete_names.out\n");
	print ETE "Taxa\tcounts\n";
	close(ETE);

	system("./lineage_ete_id.py names.tmp.list >> ete_names.out");
	system(q(cat ete_names.out | sed -e "s/\[//g;s/\] //g; s/\, u/;/g; s/^u//g; s/'//g; s/ /_/g ;s/\"//g; s/root;//; s/cellular_organisms;//" > kraken_lineage.txt));
	system("rm names.tmp.list ete_names.out");
}
