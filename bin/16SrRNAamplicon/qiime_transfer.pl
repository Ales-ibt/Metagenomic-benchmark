#!/usr/bin/perl
use strict;
use warnings;

######## PROGRAM THAT TRANSFERS THE INFORMATION FROM THE REPRESENTATIVE SEQUENCE TO ALL SEQUENCES IN THE OTU #######
######## Alejandra Escobar Zepeda, USMB, IBt, UNAM
######## 08/Agosto/2017

scalar @ARGV == 2 || die "usage: $0 <otus_list.txt> <reads_ranking.txt>
";

my$otu=$ARGV[0];
my$TF=$ARGV[1];

## Guardando los ids de las lecturas que pertenecen a cada otu
my%otu_ids;
open (OTU, $otu) or die ("No puedo abrir el archivo $otu\n") ;
while (<OTU>) {
	chomp;
	my(@line)=split(/\t/, $_);
	my($denovo)=shift(@line);
	$otu_ids{$denovo}=[ @line ];
}
close(OTU);

## Transfiriendo la informacion de la tabla de anotacion
open OUT, (">trans_$TF") or die ("No puedo abrir el archivo $TF\n") ;
open (TF, $TF) or die ("No puedo abrir el archivo $TF\n") ;
while (<TF>) {
        chomp;
        my(@truefalse)=split(/\t/, $_);
	my$id_tf=shift(@truefalse);
	$id_tf=~s/.$//;
        my$junto=join("\t", @truefalse);
	if ($otu_ids{$id_tf}){
		foreach my $element (@{$otu_ids{$id_tf}}) {
			print OUT "$element\t$junto\n";
		}
	}else{
		print "No hay informacion para el otu $id_tf\n";
	}
}
close(TF);
close(OUT);
