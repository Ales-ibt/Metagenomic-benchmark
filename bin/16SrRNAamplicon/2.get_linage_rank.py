#!/usr/bin/env python
# -*- coding: utf-8 -*-
#  2.get_linage_rank.py
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
#

from ete3 import NCBITaxa
ncbi = NCBITaxa()
import sys
import pandas as pd

file=pd.read_table('reads_ranking.txt', header=None)
f=open("taxid_ranking_linage.txt", "w")

for x in file.index:
  taxid=file[1][x]
  linaje=ncbi.get_lineage(taxid)
  rank=ncbi.get_rank(linaje)
  rank2=[rank[taxid] for taxid in linaje]
  print >> f, file[0][x],'\t',file[1][x],'\t',linaje,'\t',rank2,'\t', file[2][x]

f.close()
