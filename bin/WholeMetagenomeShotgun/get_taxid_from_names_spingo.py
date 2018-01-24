#!/usr/bin/env python
# -*- coding: utf-8 -*-
# get_taxid_from_names_spingo.py
#  Copyright 2017- E. Ernestina Godoy Lozano (tinagodoy@gmail.com)
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
