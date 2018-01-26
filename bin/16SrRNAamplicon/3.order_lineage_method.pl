#!/usr/bin/perl -w
#  3.order_lineage_method.pl
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

## INPUT ##
#CP002798-_Proteobacteria_3655/1 	71030 	[1, 10239, 439488, 35278, 675063, 249184, 12148, 71030] 	[u'no rank', u'superkingdom', u'no rank', u'no rank', u'order', u'family', u'genus', u'species'] 	48
#CP003377-_Euryarchaeota_3771/1 	71030 	[1, 10239, 439488, 35278, 675063, 249184, 12148, 71030] 	[u'no rank', u'superkingdom', u'no rank', u'no rank', u'order', u'family', u'genus', u'species'] 	46
#AP011115-_Actinobacteria_6269/1 	71030 	[1, 10239, 439488, 35278, 675063, 249184, 12148, 71030] 	[u'no rank', u'superkingdom', u'no rank', u'no rank', u'order', u'family', u'genus', u'species'] 	50
#AP011115-_Actinobacteria_69091/2 	71030 	[1, 10239, 439488, 35278, 675063, 249184, 12148, 71030] 	[u'no rank', u'superkingdom', u'no rank', u'no rank', u'order', u'family', u'genus', u'species'] 	50

## OUTPUT ##
#id_seq	superkingdom	phylum	class	order	family	genus	species	genome	ranking
#CP002865-_Proteobacteria_8804/2 	2	1224	28211	356	772	773	46358	46358	3e-49
#CP001819-_Actinobacteria_37433/1 	2	201174	1760	85007	85025	1817	1824	1824	1e-48
#CP002865-_Proteobacteria_6154/1 	2	1224	28211	204457	335929	361177	1148187	1148187	7e-50
#AP012222-_Proteobacteria_8534/1 	2	1224	28211	204457	41297	13687	28214	28214	1e-48
#CP003720-_Actinobacteria_19186/2 	2	201174	1760	85011	2062	1883	44032	44032	7e-50
#kingdom

my @ranks = qw(superkingdom phylum class order family genus species);
my %ranksarray;
my $conta = 0;
foreach my $tax (@ranks) {
	$ranksarray{$tax} = $conta;
	$conta++;
}

print "id_seq\t";
foreach my $taxhead (@ranks) {
	print "$taxhead\t";
}
print "genome\tranking\n"; #<STDIN>;

while (<>) {
	chomp;
	tr/[//d;
	tr/]//d;
	my @line = split (/\t/);
	my $seqid = $line[0];
	my $taxid = $line[1];
	my $taxbrack = $line[2];
	my $rankbrack = $line[3];
	my $score = $line[4];
	print "$seqid\t"; #<STDIN>;
	my $printtax = BRACKSPLIT($taxbrack,$rankbrack);
	print "$printtax\t$taxid\t$score\n"; #<STDIN>;
}	



sub BRACKSPLIT {

my @check = @ranks;
my $bracket1 = shift;
my $bracket2 = shift;
my @tax = split(/\,/,$bracket2);
my @ids = split(/\,/,$bracket1);
foreach my $taxidx (0..$#tax) {
	unless  ($tax[$taxidx] =~ /no rank/ or $tax[$taxidx] =~ /subspecies/ or $tax[$taxidx] =~ /species subgroup/ or $tax[$taxidx] =~ /species group/ or $tax[$taxidx] =~ /subfamily/ or $tax[$taxidx] =~ /suborder/ or $tax[$taxidx] =~ /subclass/ or $tax[$taxidx] =~ /subgenus/ or $tax[$taxidx] =~ /tribe/ or $tax[$taxidx] =~ /subphylum/ or $tax[$taxidx] =~ /u\'kingdom/ or $tax[$taxidx] =~ /varietas/ or $tax[$taxidx] =~ /subkingdom/ or $tax[$taxidx] =~ /superfamily/ or $tax[$taxidx] =~ /superorder/ or $tax[$taxidx] =~ /superclass/ or $tax[$taxidx] =~ /infraorder/ or $tax[$taxidx] =~ /infraclass/ or $tax[$taxidx] =~ /forma/ or $tax[$taxidx] =~ /cohort/) {	
		my $mod = (split /\'/, $tax[$taxidx])[1];
		#print "$mod"; <STDIN>;
		my $newkey = $mod;
		#print "=== $newkey\t$ranksarray{$newkey}"; <STDIN>;
		my $index = $ranksarray{$newkey};
		$check[$index] = $ids[$taxidx];
	}
}
foreach my $elem (@check) {
	$elem = 0 unless $elem =~ /\d+/;
}
#print "termine la linea\n@check"; <STDIN>;
my $result = join("\t", @check);
return $result;
}

