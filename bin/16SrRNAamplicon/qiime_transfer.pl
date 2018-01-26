#!/usr/bin/perl
use strict;
use warnings;

######## PROGRAM THAT TRANSFERS THE INFORMATION FROM THE REPRESENTATIVE SEQUENCE TO ALL SEQUENCES IN THE OTU #######
######## Alejandra Escobar-Zepeda, USMB, IBt, UNAM
######## 08/Agosto/2017
#  qiime_transfer.pl
#  Copyright 2017- Alejandra Escobar-Zepeda (ales2688@gmail.com)
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#

scalar @ARGV == 2 || die "usage: $0 <otus_list.txt> <otu_ranking.txt>
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
