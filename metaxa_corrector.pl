#!/usr/bin/perl
use strict;
use warnings;

######## PROGRAM THAT CORRECTS THE OUTPUT MATRIX OF metaxa2_ttt #######
######## Alejandra Escobar-Zepeda, UUSMB, IBt, UNAM
######## 27/Junio/2016

scalar@ARGV == 1 || die "usage: $0 <matrix_out.txt>
This program corrects the output of metaxa2_ttt
";

my $file=$ARGV[0];

## Creating the hash from original table
my %matrix=();
my @new_name;
my @new_vals;
open OUT, ">tmp.file" || die ("I can not create the temporal file, Check write permissions on current directory\n");
open (FILE, $file) or die ("I can not open the $file\n");
while (<FILE>) {
	chomp;
	my@line=split('\t', $_);
	my$tax_name=shift@line;
	my $tamano=scalar@line;
	my$counts=join("\t", @line);
	$tax_name =~ s/ /_/g;
	$tax_name =~ s/;+$//;
	$tax_name =~ s/;+/;/;
	$tax_name =~ s/'//g;
	my @name_levels=split(';', $tax_name);
	foreach my $name (@name_levels){
		if ($name !~ 'Unclassified') {
			push(@new_name, $name);
		}			
	}
	my$element=join(';', @new_name);
	@new_name=();

	if ($matrix{$element}){
		for (my $i=0; $i<$tamano; $i++){
			my$new_val=$line[$i]+$matrix{$element}[$i];
			push(@new_vals, $new_val);
		}
			$matrix{$element}=[@new_vals];
			@new_vals=();
	}else{
		$matrix{$element}=[@line];
	}		
}
close(FILE);

foreach my $taxa (sort keys %matrix ) { 
	print OUT "$taxa\t";
	foreach my $count (@{ $matrix{$taxa} }) {
		print OUT "$count\t";   
	} 
print OUT "\n";
}

system("sed 's/\t\$//' tmp.file > clean_$file");
system("rm tmp.file");
