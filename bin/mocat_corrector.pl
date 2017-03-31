#!/usr/bin/perl
use strict;
use warnings;

######## THIS PROGRAM FIX THE NAMES OF THE OUTPUT TABLE FROM Mocat: NCBI.species.counts.gz #######
######## Alejandra Escobar-Zepeda, USMB, IBt, UNAM
######## 02/Agosto/2016

scalar@ARGV == 1 || die "usage: $0 <NCBI.species.counts.gz || NCBI.species.counts> 
Requires lineage_ete.py script in the current directory
Requires ete2 installed
" ;

my $file=$ARGV[0];
my %mocat;
my $total_moc=0;

if ($file =~ /.gz$/){
	system("gzip -df $file");
}
open (MOCOUT, "NCBI.species.counts") or die ("I can not open the file NCBI.species.counts\n");
<MOCOUT>;
<MOCOUT>;
<MOCOUT>;
<MOCOUT>;
<MOCOUT>;
<MOCOUT>;
while (<MOCOUT>) {
	chomp;
	my@line=split('\t', $_);
	if ($line[1] > 0) {
		my$round=sprintf "%.0f", $line[1];
		$mocat{$line[0]}=$round;
	}
}
close(MOCOUT);

ETE(\%mocat);

## Subroutine calling the python script to obtain the complete NCBI phylogeny
sub ETE {
	my %hash_sub=%{$_[0]};
	my %regresa;
	open TMP, ">names.tmp.list", or die ("I can not create the temporal file, check write permissions on current directory\n");
	foreach my $llave (sort keys %hash_sub){
		print TMP "$llave\t$hash_sub{$llave}\n";
	}
	close(TMP);

	open ETE, ">ete_names.out", or die ("I can not open the file ete_names.out\n");
	print ETE "Taxa\tcounts\n";
	close(ETE);

	system("./lineage_ete.py names.tmp.list >> ete_names.out");
	system(q(cat ete_names.out | sed -e "s/\[//g;s/\] //g; s/\, u/;/g; s/^u//g; s/'//g; s/ /_/g ;s/\"//g; s/root;//; s/cellular_organisms;//" > mocat_lineage.txt));
	system("rm names.tmp.list ete_names.out");
}
