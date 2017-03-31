#!/usr/bin/env python
# -*- coding: utf-8 -*-
### Before running the program, check that ~/.ete exists
from ete2 import NCBITaxa
ncbi = NCBITaxa()
import sys

file_in=sys.argv[1]
file_name=open(file_in)
list_name = [x.strip('\n') for x in file_name.readlines()]

for linea in list_name:
	bicho, abund=linea.split("\t")
	taxid_dirty_dir=(ncbi.get_name_translator([bicho]))
	if len(taxid_dirty_dir)==0:
		print linea, "**"
	else:
		taxid_dirty=str(ncbi.get_name_translator([bicho]))
		algo, number=taxid_dirty.split('[')
		taxid_clean, nothing=(number.split(']'))
		list_brake=taxid_clean.split(',')
		if len(list_brake)==1:
			lineage=ncbi.get_lineage(taxid_clean)
			rank=ncbi.get_rank(lineage)
			rank2=[rank[taxid_clean] for taxid_clean in lineage]
			print lineage,'\t',rank2,'\t',abund

		elif len(list_brake)>1:
			print linea, "**"

