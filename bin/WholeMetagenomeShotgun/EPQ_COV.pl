#!/usr/bin/perl -w
#  EPQ_COV.pl
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

use strict;
my $file = $ARGV[0];
print $file; <STDIN>;
my $lines = `test=$file; wc -l $file`; 
chomp $lines;
print $lines; <STDIN>; 
my $q = (split /\s/, $lines)[0]; 
my $vp = 0;
my $fp = 0;
my $cov = 0;
my $epq = 0;
while (<>) { 
	chomp;
	my $TF = (split /\t/)[1];
	if ($TF eq "TRUE") {
		$vp++;
		$cov = ($vp/$q)*100;
	} else {
		$fp++;
		$epq = ($fp/$q)*100; 
	} 
	print "$_\t$cov\t$epq\n";
}
