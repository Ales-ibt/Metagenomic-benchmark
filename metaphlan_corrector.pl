#!/usr/bin/perl
use strict;
use warnings;

######## THIS PROGRAM FIX THE NAMES OF THE OUTPUT TABLE OF Metaphlan2 #######
######## Alejanda Escobar-Zepeda, UUSMB, IBt, UNAM
######## 08/Agosto/2016


scalar@ARGV == 1 || die "usage: $0 <metaphlan_mpl_relabread.out> 
This script works with the output of metaphlan2.py with option -t rel_ab_w_read_stats 
Requires lineage_ete.py script in current directory
Requires ete2 installed
" ;

my $file=$ARGV[0];
my %metaphlan=();
open (MTPHL, $file) or die ("I can not open the file $file\n");
while (<MTPHL>) {
	unless($_ =~ /^#/) {		
		chomp;
		my@line=split('\t', $_);
		my$reads_count=pop@line;
		my$linaje=shift@line;
		if ($linaje =~ /\|s__/){
			my@taxa=split(/\|/, $linaje);
			while ($taxa[-1] =~ /t__/ || $taxa[-1] =~ 'unclassified' || $taxa[-1] =~ "noname") {
				pop@taxa;
			}
			my(undef, $busca)=split(/__/, $taxa[-1]);
			$busca=~ s/_/ /g;
			$busca=~ s/ sp / sp\. /g;
			$busca=~ s/N902 109/N902-109/;
			$busca=~ s/3519 10/3519-10/;
			$busca=~ s/FO BEG1/FO-BEG1/;
			$busca=~ s/RS 1/RS-1/;
			$busca=~ s/JA 3 3Ab/JA-3-3Ab/;
			$busca=~ s/4H 3 7 5/4H-3-7-5/;
			$busca=~ s/4H 3 7 YE 5/4H-3-7+YE-5/;
			$busca=~ s/Y 400 fl/Y-400-fl/;
			$busca=~ s/nigro viridis/nigro-viridis/;
			if ($metaphlan{$busca}){
				my $suma=$metaphlan{$busca}+$reads_count;
				$metaphlan{$busca}=$suma;
			}else{
				$metaphlan{$busca}=$reads_count;
			}
		}
	}
}
close(MTPHL);

ETE(\%metaphlan);

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
	system(q(cat ete_names.out | sed -e "s/\[//g;s/\] //g; s/\, u/;/g; s/^u//g; s/'//g; s/ /_/g ;s/\"//g; s/root;//; s/cellular_organisms;//" > metaphlan_lineage.txt));
	system("rm names.tmp.list ete_names.out");
}
