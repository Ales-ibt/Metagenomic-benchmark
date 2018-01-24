#!/usr/bin/perl
use strict;
use warnings;

#  7.subtit.TF.pl
#  Copyright 2017- Alejandra Escobar Zepeda, USMB, IBt, UNAM (ales2688@gmail.com)
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

######## PROGRAMA QUE SUSTITUYE LOS NIVELES TAXONOMICOS INDEFINIDOS #######

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



