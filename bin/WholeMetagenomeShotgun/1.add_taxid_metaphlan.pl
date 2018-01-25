#!/usr/bin/perl -w
#  1.add_taxid_metaphlan.pl
#  Copyright 2017- Alejandro Sanchez-Flores (alexsf@ibt.unam.mx)
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

use strict;

die "USAGE: $0 <metaphlan table>\n" unless @ARGV;

open TAXID, "taxid_metaphlan.txt" or die "taxid_metaphlan.txt not found\n";
my $file = shift;
open IN, "$file";
open NOTAX, ">$file.notax";
open NEW, ">$file.withTAXID";
my %taxes;
&READTAX;

while (<IN>) {
	chomp;
	#print; <STDIN>;
	if (/^seq_id/) {
		print NEW "$_\n";
	} else {
		my @line = split(/\t/, $_);
		#print "---$line[1]"; <STDIN>;
		if ($taxes{$line[1]}) {
			$line[1] = $taxes{$line[1]};
			my $newline = join("\t",@line);
			print NEW "$newline\n";
		} else {
			print STDERR "$line[1] not found in taxid.txt\n";
			print NOTAX "$_\n";
		}
	}	
}

sub READTAX {
#print "entro rutina"; <STDIN>;
while (<TAXID>) {
	next if (/^id/);
	my @line = split;
	$taxes{$line[0]} = $line[1];
}
#print "termino rutina"; <STDIN>;
}

