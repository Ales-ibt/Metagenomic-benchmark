#!/usr/bin/env Rscript
#  5.tabla_new.R
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
args = commandArgs(trailingOnly=TRUE)
hora1<-system("date", intern = T)
directory_table=args[1]
print(paste("Estoy comenzando a las: ", hora1, sep=""))
print("Estoy leyendo la tabla, no te desesperes")

tabla <- read.delim("tabla_conGenomas_para_CVE.tab", header=T)
print("ya lei la tabla grandota")
ncbi <- read.delim(directory_table, header=T)

tabla_new <- matrix(nrow=dim(tabla)[1], ncol=8)
colnames(tabla_new) <- c("superkingdom","phylum","class","order","family","genus","species","genome")
row.names(tabla_new) <- tabla$id_seq
print("Voy a llenar la tabla_new")
for (i in 1:dim(tabla_new)[1]){
	num_ncbi <-which(as.character(ncbi$id_Genome)==as.character(tabla$genome_id[i]))
	tabla_new[i,1] <- as.character(ncbi$superkingdom[num_ncbi])==as.character(tabla$superkingdom[i])
	tabla_new[i,2] <- as.character(ncbi$phylum[num_ncbi])==as.character(tabla$phylum[i])
	tabla_new[i,3] <- as.character(ncbi$class[num_ncbi])==as.character(tabla$class[i])
	tabla_new[i,4] <- as.character(ncbi$order[num_ncbi])==as.character(tabla$order[i])
	tabla_new[i,5] <- as.character(ncbi$family[num_ncbi])==as.character(tabla$family[i])
	tabla_new[i,6] <- as.character(ncbi$genus[num_ncbi])==as.character(tabla$genus[i])
	tabla_new[i,7] <- as.character(ncbi$species[num_ncbi])==as.character(tabla$species[i])
	tabla_new[i,8] <-as.character(ncbi$genome[num_ncbi])==as.character(tabla$genome[i])
	print(paste("estoy en la linea ",i, " del llenado de la tabla_new para sacar los VP y FP", sep=""))
}

tabla_new <- as.data.frame(tabla_new)
tabla_new$score <- tabla$ranking
write.table(tabla_new, "tabla_new.tab",quote=F, col.names=T, row.names=T, sep="\t" )

print(paste("Listo, ya termine! Busca tu tabla en: ", getwd()," tabla_new.tab", sep=""))
