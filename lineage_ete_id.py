#!/usr/bin/env python
# -*- coding: utf-8 -*-
### Before running the program, check that ~/.etetoolkit exists
from ete2 import NCBITaxa
ncbi = NCBITaxa()
import sys

file_in=sys.argv[1]
file_name=open(file_in)
list_name = [x.strip('\n') for x in file_name.readlines()]
for linea in list_name:
	bicho_id, abund=linea.split("\t")
	lineage = ncbi.get_lineage(bicho_id)
	names = ncbi.get_taxid_translator(lineage)
	print [names[taxid] for taxid in lineage], "\t", abund
