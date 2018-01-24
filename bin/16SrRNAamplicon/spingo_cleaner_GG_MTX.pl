#!/usr/bin/perl
use strict;
use warnings;

######## PROGRAM THAT CALCULATES THE LCA OF THE AMBIGUOUS ASSIGNMENTS FOR SPINGO-MTX AND SPINGO-GG #######
######## Alejandra Escobar-Zepeda, USMB, IBt, UNAM
######## 09/July/2017
#  spingo_cleaner_GG_MTX.pl
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

scalar@ARGV == 1 || die "usage: $0 <spingo_result.txt>
This program calculates the LCA of the ambiguous assignments for SPINGO-MTX and SPINGO-GG
";

my $result=$ARGV[0];

## Reformateando la tabla original
open OUT, ">lca.tmp" || die ("I cannoit create the output file lca_spingo_$result\n");
open (SPINGO, $result) or die ("I cannot open the input file $result\n");
my%lca=();
my@new;
my$to_print;
while(<SPINGO>){
	chomp;
	my@line=split(/\t/, $_);
	if ($line[2] =~ /AMBIGUOUS/) {
		print OUT "$line[0]\t$line[1]\t";
		my($bicho1, $bicho2)=split(/,/, $line[4]);
		my@linaje1=split(/;/, $bicho1);
		my@linaje2=split(/;/, $bicho2);
		my$tamanio1=scalar@linaje1;
		my$tamanio2=scalar@linaje2;

		my$corto;
		if ($tamanio1 > $tamanio2){
			$corto=$tamanio2;
		}else{
			$corto=$tamanio1;
		}

		for (my$i=0; $i<$corto; $i++){
			if ($linaje1[$i] eq $linaje2[$i]){
				print OUT "$linaje1[$i];";
			}
		}

		print OUT "\tAMBIGUOUS\n";

	}else{
		print OUT "$line[0]\t$line[1]\t$line[2]\tUNAMBIGUOUS\n";
	}
}
close(SPINGO);
close(OUT);
system("sed 's/;\t/\t/' lca.tmp > lca_spingo_$result && rm lca.tmp");

