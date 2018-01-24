#!/usr/bin/env python
# -*- coding: utf-8 -*-
### Before running the program, check ~/.ete exists
#  taxid2level.py
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


from ete3 import NCBITaxa
ncbi = NCBITaxa()
import sys

ref_levels=['subspecies', 'species', 'genus', 'family', 'order', 'class', 'phylum', 'superkingdom']

orig_stdout = sys.stdout
f = open('level_taxid.out', 'w')
sys.stdout = f

file_in=sys.argv[1]
file_name=open(file_in)
line = [x.strip('\n') for x in file_name.readlines()]

for linea in line:
        read_id, taxid, none = linea.split('\t')
	linaje = ncbi.get_lineage(taxid)
	levels=ncbi.get_rank(linaje)


	if len(levels)==1 and levels[1]==u'no rank':
		print read_id, "\t", "no_level", "\t", taxid
	else:
		flag=0	
		for each_ref in ref_levels:
			if each_ref in levels.values() and flag==0:
				print read_id, "\t", each_ref, "\t", taxid
				flag=1

sys.stdout = orig_stdout
f.close()
