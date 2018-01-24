#!/usr/bin/env Rscript
#  1.cuentas_kraken_mod.R  
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
directory_table=args[1]
num_split <- length(strsplit(directory_table, "/")[[1]])
nombre <- strsplit(directory_table, "/")[[1]][num_split]
kraken_table <- read.delim(directory_table, header=F)
for (i in 1:dim(kraken_table)[1]){
	kamero <- kraken_table$V3[i]
	lista <- strsplit(as.character(kraken_table$V5[i]), " ")[[1]]
	num <- length(lista)
	df_pos <- data.frame(1)
	df_neg <- data.frame(1)
	for (j in 1:num){
		kam <- strsplit(as.character(lista[j]), ":")[[1]][1]
		cuenta <-as.numeric( strsplit(as.character(lista[j]), ":")[[1]][2])
		if (kam==kamero){
				df2_pos <- cuenta
			df_pos <- rbind(df_pos,df2_pos)
			}else{
				df2_neg <- cuenta
				df_neg <- rbind(df_neg,df2_neg)
				}
			}
			kraken_table$pos[i] <- ((sum(df_pos)-1)/70)*100
			kraken_table$neg[i]<- ((sum(df_neg)-1)/70)*100
			print(paste("estoy haciendo el num de la lista ", i ," con ", num, " kameros", sep=""))
			}
write.table(kraken_table, "kraken_conteo_kmer.out", quote=F, sep="\t", col.names=F, row.names=F)
print("DONE kmer counts!!")
