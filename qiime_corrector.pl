#!/usr/bin/perl
use strict;
use warnings;

######## THIS PROGRAM CORRECTS THE QIIME TABLE #######
######## Alejandra Escobar-Zepeda, UUSMB, IBt, UNAM
######## 5/April/2016


scalar@ARGV == 1 || die "usage: $0 <otu_table.txt>
The input is the output of summarize_taxa.py
";

my $file = $ARGV[0];
my @info;
my @names=($file);
open (FILE, $file) or die ("I can not open the file $file\n") ;
<FILE>;
<FILE>;
while (<FILE>) {
	chomp;
	my($taxo, $abundance)=split('\t', $_);
	my$abun=int($abundance);
	$taxo =~ s/ /_/g;
	$taxo =~ s/;Other//g;
	$taxo =~ s/;[a-z]__/;/g;
	$taxo =~ s/^[a-z]__//g;
	$taxo =~ s/[;]{2,9}//g;
	$taxo =~ s/;$//;
	$taxo =~ s/\[//g;
	$taxo =~ s/\]//g;
      	my$junto=join('||', $taxo, $abun);
      	push(@info, $junto);            
}
close(FILE);

my %qii_counts;
my $tamano=scalar@info;
for (my $i=0; $i<$tamano-1; $i++) {
	my($linaje1, $numero1)=split(/\|\|/, $info[$i]);
	my($linaje2, $numero2)=split(/\|\|/, $info[$i+1]);
	if ($linaje1 eq $linaje2 ){
		my $suma=$numero1+$numero2 ;
		$qii_counts{$linaje1}{$file}=$suma;
		$i++;
	} else {
		$qii_counts{$linaje1}{$file}=$numero1;
	}
}

## Imprimiendo la matriz de conteos
open MATCOUNT, ">tmp" or die ("I can not create the temporal file tmp\n"); 
foreach my $tax (sort keys %qii_counts) {
        print MATCOUNT "$tax\t";
        foreach my $file (@names) {
                if ($qii_counts{$tax}{$file}) {
                        print MATCOUNT "$qii_counts{$tax}{$file}\t";
                } else {
                        print MATCOUNT "0\t";
                }
        }
        print MATCOUNT "\n";
}
close(MATCOUNT);
system("sed 's/\t\$//' tmp > clean_$file && rm tmp");

