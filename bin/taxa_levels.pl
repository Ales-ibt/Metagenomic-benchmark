#!/usr/bin/perl
use strict;
use warnings;

######## PROGRAM THAT SPLITS A MATRIX OF ABUNDANCES IN TAXONOMIC LEVELS FROM DOMAIN TO SUBESPECIES #######
######## Alejandra Escobar-Zepeda, UUSMB, IBT, UNAM
######## 27/Junio/2016

scalar@ARGV == 2 || die "usage: $0 <matrix.txt> <counts|abun>

      This program splits a matrix of abundances in taxonomuc levels from domain to subespecies
      matrix.txt      Matrix of abundances where the first column is the taxonomic annotation
                      and the rest are the abundances for each sample

      counts|abun     Specify whether the matrix is of raw counts or percentage relative abundances.
                      In the second case, it reports the proportion of abundance assigned to higher
                      taxonomic levels of the given cut.

";

my $file=$ARGV[0];
my $tipo_mat=$ARGV[1];

unless ($tipo_mat =~ "counts"  or $tipo_mat =~ "abun") {
        die "The type of matrix can only be counts or abun in lowercase\n";
}

## Armando el hash de la matriz de abundancia original
my %matrix;
open (FILE, $file) or die ("I can not open the file $file\n");
my $header=<FILE>;
while (<FILE>) {
	chomp;
	my@line=split('\t', $_);
	my$tax_name=shift@line;
	$matrix{$tax_name}=[@line];
}
close(FILE);

my @samples=split("\t", $header);
my $samples_number=scalar@samples -1;

## Creating the output matrices for each taxonomic level
my %domain=SEPARA(\%matrix, 1, $samples_number, $tipo_mat);
open DOM, ">dom_tmp.txt";
print DOM "$header";
foreach my $dom (keys %domain){
	print DOM "$dom\t" ;
	foreach my $count (@{ $domain{$dom} }) {
		print DOM "$count\t";
	} 
		print DOM "\n";
}
close(DOM);
system("sed 's/\t\$//' dom_tmp.txt > domain_matrix.txt");
system("rm dom_tmp.txt");

my %phylum=SEPARA(\%matrix, 2, $samples_number, $tipo_mat);
open PHY, ">phy_tmp.txt";
print PHY "$header";
foreach my $phy (keys %phylum){
	print PHY "$phy\t" ;
	foreach my $count (@{ $phylum{$phy} }) {
		print PHY "$count\t";
	} 
		print PHY "\n";
}
close(PHY);
system("sed 's/\t\$//' phy_tmp.txt > phylum_matrix.txt");
system("rm phy_tmp.txt");

my %class=SEPARA(\%matrix, 3, $samples_number, $tipo_mat);
open CLASS, ">class_tmp.txt";
print CLASS "$header";
foreach my $cla (sort keys %class){
	print CLASS "$cla\t" ;
	foreach my $count (@{ $class{$cla} }) {
		print CLASS "$count\t";
	} 
		print CLASS "\n";
}
close(CLASS);
system("sed 's/\t\$//' class_tmp.txt > class_matrix.txt");
system("rm class_tmp.txt");

my %order=SEPARA(\%matrix, 4, $samples_number, $tipo_mat);
open ORD, ">order_tmp.txt";
print ORD "$header";
foreach my $ord (sort keys %order){
	print ORD "$ord\t" ;
	foreach my $count (@{ $order{$ord} }) {
		print ORD "$count\t";
	} 
		print ORD "\n";
}
close(ORD);
system("sed 's/\t\$//' order_tmp.txt > order_matrix.txt");
system("rm order_tmp.txt");

my %family=SEPARA(\%matrix, 5, $samples_number, $tipo_mat);
open FAM, ">family_tmp.txt";
print FAM "$header";
foreach my $fam (sort keys %family){
	print FAM "$fam\t" ;
	foreach my $count (@{ $family{$fam} }) {
		print FAM "$count\t";
	} 
		print FAM "\n";
}
close(FAM);
system("sed 's/\t\$//' family_tmp.txt > family_matrix.txt");
system("rm family_tmp.txt");

my %genus=SEPARA(\%matrix, 6, $samples_number, $tipo_mat);
open GEN, ">genus_tmp.txt";
print GEN "$header";
foreach my $gen (sort keys %genus){
	print GEN "$gen\t" ;
	foreach my $count (@{ $genus{$gen} }) {
		print GEN "$count\t";
	} 
		print GEN "\n";
}
close(GEN);
system("sed 's/\t\$//' genus_tmp.txt > genus_matrix.txt");
system("rm genus_tmp.txt");

my %species=SEPARA(\%matrix, 7, $samples_number, $tipo_mat);
open SPC, ">species_tmp.txt";
print SPC "$header";
foreach my $spc (sort keys %species){
	print SPC "$spc\t" ;
	foreach my $count (@{ $species{$spc} }) {
		print SPC "$count\t";
	} 
		print SPC "\n";
}
close(SPC);
system("sed 's/\t\$//' species_tmp.txt > species_matrix.txt");
system("rm species_tmp.txt");

my %subspecies=SEPARA(\%matrix, 8, $samples_number, $tipo_mat);
open SSPC, ">subspecies_tmp.txt";
print SSPC "$header";
foreach my $subspc (sort keys %subspecies){
	print SSPC "$subspc\t" ;
	foreach my $count (@{ $subspecies{$subspc} }) {
		print SSPC "$count\t";
	} 
		print SSPC "\n";
}
close(SPC);
system("sed 's/\t\$//' subspecies_tmp.txt > subspecies_matrix.txt");
system("rm subspecies_tmp.txt");

## Subrutin that reads the original matrix to separate it to the given taxonomic level
sub SEPARA {
	my %matriz_sub=%{$_[0]};
	my $level=$_[1];
	my $muestras=$_[2];
	my $type_matrix=$_[3];
	my %regresa=();
	my(@sumas, @taxa_levels, @diferencia);
	my($level_key, $pos, $diff, $taxa2print);
	my$suma_val=0;

	foreach my $llaves (sort keys %matriz_sub) {
		@taxa_levels=split(';', $llaves);
		my $tamano=scalar@taxa_levels;
		if ($tamano >= $level) {
			$pos=$level-1;
			$taxa2print=join(';', @taxa_levels[0..$pos]);	### variable nueva para imprimir

			if (!exists($regresa{$taxa2print})) {
				$regresa{$taxa2print}=$matriz_sub{$llaves};
			}else{ 
			
				for (my $i=0; $i<$muestras; $i++) { 
					$suma_val=$regresa{$taxa2print}[$i]+$matriz_sub{$llaves}[$i];
	            push(@sumas, $suma_val);
				}
			$regresa{$taxa2print}=[@sumas];
			@sumas=();
			}
		}
	}

	if ($type_matrix =~ 'abun'){
		my @suma_per_sample=();
		my $suma_val=0;

		for (my $i=0; $i<$muestras; $i++) { 
			foreach my $key (sort keys %regresa){
				$suma_val=$regresa{$key}[$i]+$suma_val;
			}
			push(@suma_per_sample, $suma_val);
			$suma_val=0;
		}
	
		foreach my $cada_suma (@suma_per_sample){
			my $resta=100-$cada_suma;
			if ($resta > 0) {
				my $higher_level= sprintf "%.6f", $resta;
				push(@diferencia, $higher_level);
			}else{
				push(@diferencia, "0");
			}
		}
		$regresa{"Classified_at_a_higher_level"}=[@diferencia];
		return %regresa;
	}else{
		return %regresa;	
	}
}
