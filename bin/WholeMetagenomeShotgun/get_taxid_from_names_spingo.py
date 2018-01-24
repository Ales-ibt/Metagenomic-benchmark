#!/usr/bin/env python
# -*- coding: utf-8 -*-

from ete3 import NCBITaxa
ncbi = NCBITaxa()
import sys
import pandas as pd

file=pd.read_table('otus_unicos_mod.txt', header=None)
f=open("otus_unicos_taxid_mod.txt", "w")

for x in file.index:
  nombre=file[2][x]
  name2taxid = ncbi.get_name_translator([nombre])
  print >> f, file[0][x],'\t',name2taxid,'\t',file[2][x],'\t', file[1][x], '\t', file[3][x]

f.close()
