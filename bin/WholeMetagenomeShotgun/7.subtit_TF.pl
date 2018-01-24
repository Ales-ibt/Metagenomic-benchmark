#!/usr/bin/perl
use strict;
use warnings;

######## PROGRAMA QUE SUSTITUYE LOS NIVELES TAXONOMICOS INDEFINIDOS #######
######## Para tablas de taxid de Tina del proyecto de benchmark
######## Alejandra Escobar Zepeda, USMB, IBt, UNAM
######## 27/Febrero/2017

scalar@ARGV == 1 || die "usage: $0 <table.tab> 
" ;

my $file=$ARGV[0];
open (FILE, $file) or die ("No puedo abrir el archivo $file\n");
#my$header=<FILE>;
while (<FILE>) {
	chomp;
	my@line=split(/\t/, $_);
	my$id_line=shift@line;
	my$score=pop@line;

	if ($line[0] =~ /FALSE/) {
		my@new_array;
		push @new_array, 'FALSE' foreach (1..8);
		my$to_print=join("\t", @new_array);
		print "$id_line\t$to_print\t$score\n";

	}else{
		my$to_print=join("\t", @line);
		print "$id_line\t$to_print\t$score\n";
	}
}



