#!/usr/bin/perl
use strict;
use warnings;

######## PROGRAM THAT CALCULATES THE LCA OF THE AMBIGUOUS ASSIGNMENTS FOR SPINGO-SILVA #######
######## Alejandra Escobar-Zepeda, USMB, IBt, UNAM
######## 09/July/2017
#  spingo_cleaner_SIL.pl
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

scalar@ARGV == 1 || die "usage: $0 <spingo_silva_result.txt>
This program calculates the LCA of the ambiguous assignments for SPINGO-SILVA
";

my $result=$ARGV[0];

## Reformateando la tabla original
open OUT, ">lca_spingo_$result" || die ("I canno create the output file lca_spingo_$result\n");
open (SPINGO, $result) or die ("I cannot open the input file $result\n");
my%lca=();
my%final;
my$cont=0;
my@tmp=();
my@compare=();
my@actual=();
my$flag=0;
my($junto,$tope);
while(<SPINGO>){
	chomp;
	my@line=split(/\t/, $_);
	if ($line[2] =~ /AMBIGUOUS/) {
		print OUT "$line[0]\t$line[1]\t";
		my$sucia=$line[4];
		$sucia=~s/root;cellular_organisms;//g;
		$sucia=~s/_<[a-z]+>//g;
		my(@bichos)=split(/,/, $sucia);
		$flag=0;
		foreach my $elemento (@bichos){
			if ($flag==0){
				@tmp=split(/;/, $elemento);
				$flag=1;
			}else{
				@actual=split(/;/, $elemento);
				if(scalar@tmp<scalar@actual){
					$tope=scalar@tmp;
				}else{
					$tope=scalar@actual;
				}
				foreach (my $i = 0; $i < $tope; $i++) {
					if ($tmp[$i] eq $actual[$i]){
						push(@compare, $actual[$i]);
					}
				}
				$junto=join(";", @compare);
				@tmp=split(/;/, $junto);
				@compare=();
			}
		}
		if ($junto eq ""){
			print OUT "Unclassified\tAMBIGUOUS\n";
		}else{
			print OUT "$junto\tAMBIGUOUS\n";
		}

	}else{
		my$dirty=$line[2];
		$dirty=~s/root;cellular_organisms;//g;
                $dirty=~s/_<[a-z]+>//g;
		print OUT  "$line[0]\t$line[1]\t$dirty\tUNAMBIGUOUS\n";
	}
}
close(SPINGO);
close(OUT);

