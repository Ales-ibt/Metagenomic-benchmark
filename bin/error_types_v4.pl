#!/usr/bin/perl
use strict;
use warnings;

######## PROGRAM THAT CALCULATES THE TYPE OF ERROR AT ALL TAXONOMIC LEVELS FROM level_taxid.out AND tabla_sort2.tab TABLES #######
######## Alejandra Escobar-Zepeda, USMB, IBt, UNAM
######## 04/October/2017
#  error_types_v4.pl
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
#** No requiere tablas ordenadas, no llama a python, no funciona en multithread

scalar@ARGV == 3 || die "usage: $0 <level_taxid.out> <tabla_sort2.tab> <total_shuffled>
";

my $reads_taxid=$ARGV[0];
my $reads_TF=$ARGV[1];
my $shuff=$ARGV[2];

## Creating the taxonomic levels hash
my %level_idx = (
        "superkingdom"  => 0,
       	"phylum"  => 1,
        "class"  => 2,
        "order"  => 3,
        "family"  => 4,
        "genus"  => 5,
        "species"  => 6,
	"subspecies"  => 7,
);

## Saving the taxids for each read
open (TAXID, $reads_taxid) or die ("I cannot open the input file $reads_taxid\n");
my%assig=();
while(<TAXID>){
	chomp;
        my$dirty=$_;
        $dirty=~s/[\s\t]+/\t/g;
	my($id, $tax, undef)=split(/\t/, $dirty);
	if ($assig{$id}){
		print "The read $id is duplicated\n";
	}elsif ($tax !~ /Unclassified/){
		my$indice=$level_idx{$tax};
		$assig{$id}=$indice;
	}
}
close(TAXID);

## Initializing the counters hashes
my%contadores;
for(my $j=0; $j< 8; $j++){
	($contadores{$j}{TN}, $contadores{$j}{TP}, $contadores{$j}{FN}, $contadores{$j}{FP})= (0) x 4;
}
my$cont_shuff=0;

## Parsing the tabla_sort2.tab table
open (TRFL, $reads_TF) or die ("I cannot open the input file $reads_TF\n");
while(<TRFL>){
        chomp;
	my$sucia=$_;
	$sucia=~s/[\s\t]+/\t/g;
        my(@line)=split(/\t/, $sucia);
	my$id_tf=shift(@line);
	pop@line;

	if (exists$assig{$id_tf} && $id_tf !~ /Eukaryote/ && $id_tf =~ /SHUFFLED/){
		$cont_shuff++;
		my$actual_pos_sh=-1;
                my$indexTF_sh=$assig{$id_tf};
                foreach my $elemento (@line){
                        $actual_pos_sh++;
                        if ($elemento =~ /FALSE/ && $actual_pos_sh<=$indexTF_sh){
                                $contadores{$actual_pos_sh}{FP}++;
                        }elsif ($elemento =~ /FALSE/ && $actual_pos_sh>$indexTF_sh){
                                $contadores{$actual_pos_sh}{TN}++;
                        }
                }

	}elsif (exists $assig{$id_tf} && $id_tf !~ /Eukaryote/ && $id_tf !~ /SHUFFLED/){
		my$actual_pos=-1;
		my$indexTF=$assig{$id_tf};
		foreach my $elemento (@line){
			$actual_pos++;
			if ($elemento =~ /TRUE/){
				$contadores{$actual_pos}{TP}++;
			}elsif ($elemento =~ /FALSE/ && $actual_pos<=$indexTF){
				$contadores{$actual_pos}{FP}++;
			}elsif ($elemento =~ /FALSE/ && $actual_pos>$indexTF){
				$contadores{$actual_pos}{FN}++;
			}
		}
	}elsif ($id_tf !~ /Eukaryote/){
		print "There is no taxid for $id_tf\n";
	}
}
close(TRFL);

## Counting the true negatives (shuffled reads) without annotation
my$complete_TN=$shuff-$cont_shuff;
for (my$i=0; $i<$complete_TN; $i++){
	for (my$j=0; $j<8; $j++){
		$contadores{$j}{TN}++;
	}
}

## Printing the error type rates for each taxonomic leve
open OUT, ">error_description.txt" || die ("I cannot create the output file error_description.txt\n");
my%idx_level = reverse %level_idx;
my($sens, $spec, $ACC, $denominator, $MCC);
## sens=TP/(TP+FN)
## spec=TN/(TN+FP)
## ACC=(TP+TN)/(TP+FP+FN+TN)
## MCC=(TP*TN)–(FP*FN)/[(TP+FP)*(TP+FN)*(TN+FP)*(TN+FN)]^1/2

print OUT "level\tTN\tTP\tFN\tFP\tsens\tspec\tACC\tMCC\n";
foreach my $llave (sort keys %idx_level){
	$sens=$contadores{$llave}{TP}/($contadores{$llave}{TP}+$contadores{$llave}{FN});
	$spec=$contadores{$llave}{TN}/($contadores{$llave}{TN}+$contadores{$llave}{FP});
	$ACC=($contadores{$llave}{TP}+$contadores{$llave}{TN})/($contadores{$llave}{TP}+$contadores{$llave}{FP}+$contadores{$llave}{FN}+$contadores{$llave}{TN});

	$denominator=($contadores{$llave}{TP}+$contadores{$llave}{FP})*($contadores{$llave}{TP}+$contadores{$llave}{FN})*($contadores{$llave}{TN}+$contadores{$llave}{FP})*($contadores{$llave}{TN}+$contadores{$llave}{FN});
	if ($denominator==0){
		$MCC="NA";
	}else{
		$MCC=($contadores{$llave}{TP}*$contadores{$llave}{TN}-$contadores{$llave}{FP}*$contadores{$llave}{FN})/sqrt($denominator);
	}

        print OUT "$idx_level{$llave}\t$contadores{$llave}{TN}\t$contadores{$llave}{TP}\t$contadores{$llave}{FN}\t$contadores{$llave}{FP}\t$sens\t$spec\t$ACC\t$MCC\n";
}
close(OUT);

