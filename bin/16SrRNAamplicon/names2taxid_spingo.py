#!/usr/bin/env python
# -*- coding: utf-8 -*-
### Before running the program, check that ~/.ete exists
from ete2 import NCBITaxa
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
