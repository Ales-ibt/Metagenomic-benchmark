#!/usr/bin/env Rscript
#  4.tabla_ordenada_conGenoma_amplicon.R
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

hora1<-system("date", intern = T)
print(paste("Estoy comenzando a las: ", hora1, sep=""))
tabla_ordenada<-"lineaje_ordenada.tab"
output_path<-getwd()
nombre_tabla="tabla_conGenomas_para_CVE.tab"

tabla<- read.delim(tabla_ordenada, header=T)
print("Ya lei la tabla y estoy por cambiar los nombres")
	tabla$genome_id<- sapply(as.character(tabla$id_seq), function(x){strsplit(strsplit(x, "[;]")[[1]][2], "[_]")[[1]][1]})	
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep1")] <- "CP001097"
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep10")] <- "CP001097"
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep11")] <- "CP001097"
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep12")] <- "CP001097"
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep13")] <- "CP001097"
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep14")] <- "CP001097"
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep15")] <- "CP001097"
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep16")] <- "CP001097"
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep17")] <- "CP001097"
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep18")] <- "CP001097"
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep19")] <- "CP001097"
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep2")] <- "CP001097"
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep20")] <- "CP001097"
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep3")] <- "CP001097"
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep4")] <- "CP001097"
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep5")] <- "CP001097"
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep6")] <- "CP001097"
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep7")] <- "CP001097"
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep8")] <- "CP001097"
	tabla$genome_id[which(tabla$genome_id=="CP001097_rep9")] <- "CP001097"
print("Ya estoy por cambiar los de Rose!!")
	tabla$genome_id[which(tabla$genome_id=="Rose_little_divergence_sequence_a")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_little_divergence_sequence_b")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_little_divergence_sequence_c")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_little_divergence_sequence_d")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_little_divergence_sequence_e")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_little_divergence_sequence_f")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_little_divergence_sequence_g")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_little_divergence_sequence_i")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_medium_divergence_sequence_a")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_medium_divergence_sequence_c")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_medium_divergence_sequence_d")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_medium_divergence_sequence_e")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_medium_divergence_sequence_f")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_medium_divergence_sequence_g")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_medium_divergence_sequence_h")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_medium_divergence_sequence_i")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_mixed_divergence_sequence_a")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_mixed_divergence_sequence_b")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_mixed_divergence_sequence_c")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_mixed_divergence_sequence_e")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_mixed_divergence_sequence_f")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_mixed_divergence_sequence_g")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_mixed_divergence_sequence_h")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_mixed_divergence_sequence_i")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_most_divergence_sequence_a")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_most_divergence_sequence_b")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_most_divergence_sequence_c")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_most_divergence_sequence_d")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_most_divergence_sequence_e")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_most_divergence_sequence_f")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_most_divergence_sequence_g")] <- "AE016823"
	tabla$genome_id[which(tabla$genome_id=="Rose_most_divergence_sequence_h")] <- "AE016823"

print("Voy a cambiar los SHUFFLED")
num<- grep("SHUFFLED", tabla$id_seq)

if (length(num)>0){
	tabla$genome_id[num] <- "SHUFFLED"
}

print("ya acabe de cambiar los nombres, estoy por escribir la tabla")
write.table(tabla, paste(output_path, nombre_tabla, sep="/"), quote=F, col.names=T, row.names=F, sep="\t")
print(paste("ya esta tu tabla en: ", output_path, "/", nombre_tabla, sep=""))
hora2<- system("date", intern = T)
print(paste("finalice a las: ", hora2, sep=""))
