#!/usr/bin/env python
# -*- coding: utf-8 -*-
### Before running the program, check that ~/.ete exists
#
#  names2taxid_spingo.py
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

orig_stdout = sys.stdout
f = open('tmp_py.out', 'w')
sys.stdout = f

file_in=sys.argv[1]
file_name=open(file_in)
list_name = [x.strip('\n') for x in file_name.readlines()]

ref_levels=['subspecies', 'species', 'genus', 'family', 'order', 'class', 'phylum', 'superkingdom']
myList=[]

for linea in list_name:
	taxid_dirty_dir=(ncbi.get_name_translator([linea]))

	if len(taxid_dirty_dir)>0:
		nude=str(taxid_dirty_dir.values()[0][0])
		myList.insert(0,nude)

t = ncbi.get_topology(myList, intermediate_nodes=True)
linaje=ncbi.get_lineage(t.get_common_ancestor(myList).name)
pairs=ncbi.get_rank(linaje)

flag=0
for each_ref in ref_levels:
	if each_ref in pairs.values() and flag==0:
		print ncbi.get_taxid_translator([(list(pairs.keys())[list(pairs.values()).index(each_ref)])]).values()
		flag=1

if flag==0:
	print "Unclassified"

sys.stdout = orig_stdout
f.close()
