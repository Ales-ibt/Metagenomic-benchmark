#!/usr/bin/perl
use strict;
use warnings;

######## PROGRAM THAT CONVERTS RAW COUNT MATRICES IN RELATIVE ABUNDANCE #######
######## Alejandra Escobar-Zepeda, UUSMB, IBt, UNAM
######## 05/Abril/2016


scalar@ARGV == 1 || die "usage: $0 <matrix_count.txt>
";

my $file=$ARGV[0];

## Creating the hash from the original matrix
my %matrix;
open (FILE, $file) or die ("I can not open the file $file\n");
my $header=<FILE>;
while (<FILE>) {
	chomp;
	my@line=split('\t', $_);
	my$tax_name=shift@line;
	my$element=join(',', @line);
	$matrix{$tax_name}=$element;
}
close(FILE);

my @samples=split("\t", $header);
my $samples_number=scalar@samples -1 ;

## Calculating relative abundances
my $suma_val=0;
my @suma_per_sample;
for (my $i=0; $i<$samples_number; $i++) { 
	foreach my $key (sort keys %matrix){
		my@key_values=split(',', $matrix{$key});
		$suma_val=$key_values[$i]+$suma_val;
	}
	push(@suma_per_sample, $suma_val);
	$suma_val=0;
}

## Printing abundance matrix
my @new_vals;
open MATRIX, ">percent_$file";
print MATRIX "$header";
foreach my $key (sort keys %matrix){
	for (my $i=0; $i<$samples_number; $i++) { 
		my@key_values=split(',', $matrix{$key});
		if ($key_values[$i] >0 ) {
			my$new_abundance= sprintf "%.6f", ($key_values[$i]*100)/$suma_per_sample[$i];
			push(@new_vals, $new_abundance);
		}else{
			push(@new_vals, "0");
		}
	}
	my$abundances=join("\t", @new_vals);
	@new_vals=();
	print MATRIX "$key\t$abundances\n";
}
close(MATRIX);
