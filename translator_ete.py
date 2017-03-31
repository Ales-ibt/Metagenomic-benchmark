#!/usr/bin/env python
# -*- coding: utf-8 -*-
### Before running the program, make sure exists ~/.etetoolkit
from ete2 import NCBITaxa
ncbi = NCBITaxa()
#ncbi.update_taxonomy_database()
import sys

### Program that writes the lineages from the taxid
file_in=sys.argv[1]
file_name=open(file_in)
list_name = [x.strip('\n') for x in file_name.readlines()]

for linea in list_name:
	ids, abund=linea.split("\t")
	lista_ids=ids.split(";")

	for number in lista_ids:
		if number>0:
			name=ncbi.get_taxid_translator([number])
			print name,';', 
		else:
			print "no_rank",
	print abund

