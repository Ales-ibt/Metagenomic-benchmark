#!/usr/bin/perl
use strict;
use warnings;

######## PROGRAM THAT CALCULATES THE LCA OF THE AMBIGUOUS ASSIGNMENTS FOR SPINGO-RDP #######
######## Alejandra Escobar, USMB, IBt, UNAM
######## 05/October/2017


scalar@ARGV == 1 || die "usage: $0 <spingo_result_rdp.txt>
This program calculates the LCA of the ambiguous assignments for SPINGO-RDP
Requires the script names2taxid_spingo.py in a visible path
";

my $result=$ARGV[0];

## Reformateando la tabla original
open OUT, ">lca_spingo_$result" || die ("I cannot create the output file lca_spingo_$result\n");
open (SPINGO, $result) or die ("I cannot open the input file $result\n");
my%lca=();
my@new;
my$to_print;
while(<SPINGO>){
	chomp;
	my@line=split(/\t/, $_);
	if ($line[4] =~ /AMBIGUOUS/ && $line[6] =~ /AMBIGUOUS/) {
		if ($line[8]=~/Riemerella_anatipestifer,Rosa_chinensis/) {
			$to_print="Riemerella_anatipestifer";
			print OUT "$line[0]\t$line[1]\t$to_print\tAMBIGUOUS\n";

		}elsif ($line[8]=~/Devosia_glacialis,Vasilyevaea_enhydra/){
			$to_print="Devosia";
                        print OUT "$line[0]\t$line[1]\t$to_print\tAMBIGUOUS\n";

		}else{
			my@mix=split(/,/, $line[8]);
			foreach my $bicho (@mix){
				$bicho=~s/Escherichia\///;
                	        $bicho=~s/Shigella_coli/Escherichia_coli/;
                                $bicho=~s/Yersinia/Yersiniaceae/;
				$bicho=~s/Bacillus/Bacillaceae/;
				my($genero, undef)=split(/_/, $bicho);
				$lca{$genero}="";
			}

			open TMP, ">temp_names" || die ("No puedo crear el archivo temp_names\n");
			foreach my $llave (sort keys %lca) {
				print TMP "$llave\n";
			}
			close(TMP);

			system("names2taxid_spingo.py temp_names");

			if (!-s "tmp_py.out"){
				print OUT "$line[0]\t$line[1]\tUnclassified\tAMBIGUOUS\n";
			}else{
				open (RES, "tmp_py.out") or die ("No puedo abrir el archivo taxid_list\n");
				my $lca_out=<RES>;
				chomp($lca_out);
				close(RES);

				if ($lca_out=~/Unclassified/){
					print OUT "$line[0]\t$line[1]\t$lca_out\tAMBIGUOUS\n";
				}else{
					$lca_out=~s/\[u'//;
					$lca_out=~s/'\]//;
					print OUT "$line[0]\t$line[1]\t$lca_out\tAMBIGUOUS\n";
					unlink "temp_names", "tmp_py.out";
				}
			}
			%lca=();
		}
	}elsif($line[4] !~ /AMBIGUOUS/ && $line[6] =~ /AMBIGUOUS/){
		my$bicho_gen=$line[4];
		$bicho_gen=~s/Escherichia\/Shigella/Escherichia/;
		print OUT "$line[0]\t$line[1]\t$bicho_gen\tAMBIGUOUS\n";

	}else{
		print OUT "$line[0]\t$line[1]\t$line[6]\tUNAMBIGUOUS\n";
	}
}
close(SPINGO);
close(OUT);

