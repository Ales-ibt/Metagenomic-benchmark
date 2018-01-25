#!/usr/bin/env Rscript
#  0.get_table_parallel_gg.R
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
########################################################################
#### get reads_ranking.txt from parallel-meta results with gg databases ####
########################################################################
args = commandArgs(trailingOnly=TRUE)
directory_table=args[1]
directory_table2=args[2]

system("sed -e 's/^[a-zA-Z0-9]*|//g;s/rev|//g' classification.txt | sed 's/; Unclassified*.*//g;s/; otu*.*//g' | cut -f 1,4,5 > classification_mod.txt")
system("sed -i '1d' classification_mod.txt")

##Sacar el nombre de la ultima clasificacion taxonomica
tabla<- read.delim("classification_mod.txt", header=F)
colnames(tabla)<- c("reads_id","score","classification")
tabla$last_class<- sapply(as.character(tabla$classification), function(x){strsplit(x, "; ")[[1]][length(strsplit(x, "; ")[[1]])]})
write.table(tabla,"otus_unicos.txt", quote=F, col.names=T, row.names=F, sep="\t")

### bash
system("cut -f4 otus_unicos.txt | sed 's/ Group//g' > last.class_mod.txt")
system("sed 's/Escherichia Shigella/Escherichia/g' last.class_mod.txt > last.class_mod2.txt")

tabla <- read.delim("otus_unicos.txt", header=T)
last<- read.delim("last.class_mod2.txt", header=T)
tabla_new<- data.frame(reads_id= tabla$reads_id, classification=tabla$classification, last.class=last$last_class, score=tabla$score)

tabla_new$last.class<- as.character(tabla_new$last.class)
tabla$last.class<- as.character(tabla$last_class)

tabla_new$last.class[which(tabla_new$last.class=="Pectobacterium sp. carotovorum")]<- "Pectobacterium carotovorum"
tabla_new$last.class[which(tabla_new$last.class=="Actinobacillus parahaemolyticus")]<- "Actinobacillus"
tabla_new$last.class[which(tabla_new$last.class=="Streptomyces sp. OS3 95")]<- "Streptomyces"
tabla_new$last.class[which(tabla_new$last.class=="Chloroplast")]<- "Cyanobacteria"
tabla_new$last.class[which(tabla_new$last.class=="Koribacteraceae")]<- "Coriobacteriaceae"
tabla_new$last.class[which(tabla_new$last.class=="Vibrio sp. 27")]<- "Vibrio"
tabla_new$last.class[which(tabla_new$last.class=="NS5")] <- "Flavobacteriaceae"
tabla_new$last.class[which(tabla_new$last.class=="Brenneria sp. MK09")] <- "Brenneria"
tabla_new$last.class[which(tabla_new$last.class=="OPB56")] <- "Chlorobi"
tabla_new$last.class[which(tabla_new$last.class=="Ellin515")] <- "Verrucomicrobia"
tabla_new$last.class[which(tabla_new$last.class=="SHA 20")] <- "Anaerolineae"
tabla_new$last.class[which(tabla_new$last.class=="Stigonema sp. UAM 342")] <- "Stigonema"
tabla_new$last.class[which(tabla_new$last.class=="RB25")] <- "Acidobacteria"
tabla_new$last.class[which(tabla_new$last.class=="Pir4")] <- "Planctomycetaceae"
tabla_new$last.class[which(tabla_new$last.class=="OM60")] <- "Halieaceae"
tabla_new$last.class[which(tabla_new$last.class=="YS2")] <- "Cyanobacteria"
tabla_new$last.class[which(tabla_new$last.class=="Sva0725")] <- "Acidobacteria"
tabla_new$last.class[which(tabla_new$last.class=="SC I 84")] <- "Betaproteobacteria"
tabla_new$last.class[which(tabla_new$last.class=="Erwinia dispersa")] <- "Erwinia"
tabla_new$last.class[which(tabla_new$last.class=="Sporichthyaceae hgcI")] <- "Sporichthyaceae"
tabla_new$last.class[which(tabla_new$last.class=="RB41")] <- "Acidobacteria"
tabla_new$last.class[which(tabla_new$last.class=="Thiohalorhabdales")] <- "Gammaproteobacteria"
tabla_new$last.class[which(tabla_new$last.class=="Spirobacillales")] <- "Gammaproteobacteria"
tabla_new$last.class[which(tabla_new$last.class=="Piscirickettsiaceae endosymbionts")] <- "Piscirickettsiaceae"
tabla_new$last.class[which(tabla_new$last.class=="Pseudanabaenales")] <- "Cyanobacteria"
tabla_new$last.class[which(tabla_new$last.class=="HTCC")] <- "Alteromonadales"
tabla_new$last.class[which(tabla_new$last.class=="HTCC2188")] <- "Alteromonadales"
tabla_new$last.class[which(tabla_new$last.class=="EC1113")] <- "Acidobacteria"
tabla_new$last.class[which(tabla_new$last.class=="DS 18")] <- "Acidobacteria"
tabla_new$last.class[which(tabla_new$last.class=="Desulfotomaculum Desulfovirgula")] <- "Desulfotomaculum"
tabla_new$last.class[which(tabla_new$last.class=="TM1")] <- "Acidobacteria"
tabla_new$last.class[which(tabla_new$last.class=="Pseudanabaenales")] <- "Synechococcales"
tabla_new$last.class[which(tabla_new$last.class=="Neisseria flava mucosa pharyngis")] <- "Neisseria pharyngis subsp. flava"
tabla_new$last.class[which(tabla_new$last.class=="Marinilabiaceae")] <- "Marinilabiliaceae"
tabla_new$last.class[which(tabla_new$last.class=="GIF9")] <- "Dehalococcoidia"
tabla_new$last.class[which(tabla_new$last.class=="Dehalobacter Syntrophob")] <- "Dehalobacter"
tabla_new$last.class[which(tabla_new$last.class=="CCU21")] <- "Acidobacteria"
tabla_new$last.class[which(tabla_new$last.class=="0319 7L14")] <- "Actinobacteria"
tabla_new$last.class[which(tabla_new$last.class=="Candidatus Nostocoida")] <- "Planctomycetaceae"
tabla_new$last.class[which(tabla_new$last.class=="BD1 7")] <- "Spongiibacteraceae"
tabla_new$last.class[which(tabla_new$last.class=="VE39G03")] <- "Aeromonas"
tabla_new$last.class[which(tabla_new$last.class=="Acidobacteria iii1 15")] <- "Acidobacteria"
tabla_new$last.class[which(tabla_new$last.class=="S24 7")] <- "Bacteroidales"
tabla_new$last.class[which(tabla_new$last.class=="Lineage I")] <- "Elusimicrobia"
tabla_new$last.class[which(tabla_new$last.class=="Kaistobacter")] <- "Sphingomonas"
tabla_new$last.class[which(tabla_new$last.class=="Ruminococcaceae Group")] <- "Ruminococcaceae"
tabla_new$last.class[which(tabla_new$last.class=="Halobacteriaceae Group")] <- "Halobacteriaceae"
tabla_new$last.class[which(tabla_new$last.class=="Chloracidobacteria")] <- "Acidobacteria"
tabla_new$last.class[which(tabla_new$last.class=="BPC102")] <- "Acidobacteria"
tabla_new$last.class[which(tabla_new$last.class=="Verruco 5")] <- "Verrucomicrobia"
tabla_new$last.class[which(tabla_new$last.class=="Marinilabiaceae")] <- "Marinilabiliaceae"
tabla_new$last.class[which(tabla_new$last.class=="Trabulsiella farmeri")] <- "Trabulsiella"
tabla_new$last.class[which(tabla_new$last.class=="iii1 15")] <- "Acidobacteria"
tabla_new$last.class[which(tabla_new$last.class=="WS3")] <- "Bacteria"
tabla_new$last.class[which(tabla_new$last.class=="Sediment 1")] <- "Bacteria"
tabla_new$last.class[which(tabla_new$last.class=="SBR1031")] <- "Anaerolineae"
tabla_new$last.class[which(tabla_new$last.class=="Thiohalorhabdales")] <- "Gammaproteobacteria"
tabla_new$last.class[which(tabla_new$last.class=="SubsectionI")] <- "Oscillatoriophycideae"
tabla_new$last.class[which(tabla_new$last.class=="Pedosphaerae")] <- "Pedosphaera"
tabla_new$last.class[which(tabla_new$last.class=="Cloacamonae")] <- "Bacteria"
tabla_new$last.class[which(tabla_new$last.class=="koll11")] <- "Bacteria"
tabla_new$last.class[which(tabla_new$last.class=="Pirellulales")] <- "Planctomycetacia"
tabla_new$last.class[which(tabla_new$last.class=="TG3")] <- "Fibrobacteres"
tabla_new$last.class[which(tabla_new$last.class=="AB16")] <- "Bacteria"
tabla_new$last.class[which(tabla_new$last.class=="Escherichia Shigella")] <- "Escherichia"
tabla_new$last.class[which(tabla_new$last.class=="Escherichia-Shigella")] <- "Escherichia"
tabla_new$last.class[which(tabla_new$last.class=="Escherichia-Shigella bacterium ZH-4")] <- "bacterium ZH-4"
tabla_new$last.class[which(tabla_new$last.class=="Acetothermia uncultured bacterium")] <- "uncultured Acetothermia bacterium"
tabla_new$last.class[which(tabla_new$last.class=="AEGEAN-169 marine group")] <- "Rhodospirillaceae"
tabla_new$last.class[which(tabla_new$last.class=="Hahella unidentified")] <- "Hahella"
tabla_new$last.class[which(tabla_new$last.class=="Sulfurimonas uncultured bacterium")] <- "Sulfurimonas"
tabla_new$last.class[which(tabla_new$last.class=="Helicobacter uncultured bacterium")] <- "Helicobacter"
tabla_new$last.class[which(tabla_new$last.class=="Candidatus Methylacidiphilum")] <- "Methylacidiphilum"
tabla_new$last.class[which(tabla_new$last.class=="Thioalkalimicrobium gamma proteobacterium ASL1")] <- "Thioalkalimicrobium"
tabla_new$last.class[which(tabla_new$last.class=="Prevotella 7")] <- "Prevotella"
tabla_new$last.class[which(tabla_new$last.class=="Roseiflexus hot springs metagenome")] <- "Roseiflexus"
tabla_new$last.class[which(tabla_new$last.class=="FamilyI")] <- "Cyanobacteria"
tabla_new$last.class[which(tabla_new$last.class=="Chloroflexus unidentified")] <- "Chloroflexus"
tabla_new$last.class[which(tabla_new$last.class=="Candidatus Atelocyanobacterium (UCYN-A)")] <- "cyanobacterium UCYN-A"
tabla_new$last.class[which(tabla_new$last.class=="Leptospirillum uncultured bacterium")] <- "Leptospirillum"
tabla_new$last.class[which(tabla_new$last.class=="Prevotella 1")] <- "Prevotella"
tabla_new$last.class[which(tabla_new$last.class=="SubsectionIV")] <- "Cyanobacteria"
tabla_new$last.class[which(tabla_new$last.class=="Desulfobacterium delta proteobacterium 8aA2")] <- "Desulfobacterium"
tabla_new$last.class[which(tabla_new$last.class=="Candidatus Liberibacter")] <- "Candidatus Liberobacter"
tabla_new$last.class[which(tabla_new$last.class=="[Cellvibrio] gilvus ATCC 13127")] <- "Cellulomonas gilvus ATCC 13127"
tabla_new$last.class[which(tabla_new$last.class=="Caldicellulosiruptor kristjanssonii 177R1B")] <- "Caldicellulosiruptor kristjanssonii"
tabla_new$last.class[which(tabla_new$last.class=="Ilumatobacter actinobacterium YM22-133")] <- "Ilumatobacter"
tabla_new$last.class[which(tabla_new$last.class=="marine group cyanobacterium UCYN-A")] <- "Cyanobacteria"
tabla_new$last.class[which(tabla_new$last.class=="Incertae Sedis")] <- "Lachnospiraceae"
tabla_new$last.class[which(tabla_new$last.class=="Thioalkalivibrio gamma proteobacterium ASL10")] <- "Thioalkalivibrio"
tabla_new$last.class[which(tabla_new$last.class=="unclassified Iamiaceae")] <- "Iamiaceae"
tabla_new$last.class[which(tabla_new$last.class=="unclassified Bifidobacteriaceae")] <- "Bifidobacteriaceae"
tabla_new$last.class[which(tabla_new$last.class=="Bacteria Outgroup")] <- "Archaea"
tabla_new$last.class[which(tabla_new$last.class=="Akkermansia_muciniphila")] <- "Akkermansia muciniphila"
tabla_new$last.class[which(tabla_new$last.class=="Acinetobacter_rhizosphaerae")] <- "Acinetobacter rhizosphaerae"
tabla_new$last.class[which(tabla_new$last.class=="Psychroflexus_torquis")] <- "Psychroflexus torquis"
tabla_new$last.class[which(tabla_new$last.class=="Prevotella_melaninogenica")] <- "Prevotella melaninogenica"
tabla_new$last.class[which(tabla_new$last.class=="Bacteroides_fragilis")] <- "Bacteroides fragilis"
tabla_new$last.class[which(tabla_new$last.class=="Acinetobacter_lwoffii")] <- "Acinetobacter lwoffii"
tabla_new$last.class[which(tabla_new$last.class=="Neisseria_cinerea")] <- "Neisseria cinerea"
tabla_new$last.class[which(tabla_new$last.class=="Candidatus_Methylacidiphilum_infernorum")] <- "Methylacidiphilum infernorum"
tabla_new$last.class[which(tabla_new$last.class=="Fervidomicrobium")] <- "Bacteria"
tabla_new$last.class[which(tabla_new$last.class=="Paludimonas")] <- "Paludibacterium"
tabla_new$last.class[which(tabla_new$last.class=="Puniceibacter")] <- "Puniceicoccus"
tabla_new$last.class[which(tabla_new$last.class=="Flavobacteria")] <- "Flavobacteriia"
tabla_new$last.class[which(tabla_new$last.class=="Aquasalina")] <- "Aquisalimonas"
tabla_new$last.class[which(tabla_new$last.class=="Methylonatronum")] <- "Methylonatrum"
tabla_new$last.class[which(tabla_new$last.class=="unclassified Ktedobacteria")] <- "unclassified Ktedonobacteria"
tabla_new$last.class[which(tabla_new$last.class=="Chinabacter")] <- "Cytophagaceae"
tabla_new$last.class[which(tabla_new$last.class=="Solibium")] <- "Gammaproteobacteria"
tabla_new$last.class[which(tabla_new$last.class=="Gulbenkianus")] <- "Gulbenkiania"
tabla_new$last.class[which(tabla_new$last.class=="Antarctic")] <- "Bacteria"
tabla_new$last.class[which(tabla_new$last.class=="Desulfitobacter")] <- "Desulfitibacter"
tabla_new$last.class[which(tabla_new$last.class=="Endozoicimonas")] <- "Endozoicomonas"
tabla_new$last.class[which(tabla_new$last.class=="Kaistina")] <- "Kaistia"
write.table(tabla_new,"otus_unicos_mod.txt", quote=F, col.names=T, row.names=F, sep="\t")

system(paste("python ", directory_table2, sep=""))

tabla<- read.delim("otus_unicos_taxid_mod.txt")
colnames(tabla)[2]<-"taxid"
tabla$taxid_limpio<- sapply(as.character(tabla$taxid), function(x){strsplit(strsplit(as.character(x), "[[]")[[1]][2], "[]]")[[1]][1]})

tabla$last_class_clean <- sapply(as.character(tabla$last.class), function(x){strsplit(x, " ")[[1]][1]})
dobles <- read.delim(directory_table, header=T)

for (j in 1:dim(dobles)[1]){
	num <- which(tabla$last_class_clean==dobles$last_class[j])
	tabla$taxid_limpio[num] <-dobles$taxid[j]
}

new<- data.frame(tabla$reads_id, tabla$taxid_limpio, tabla$score)
write.table(new, "reads_ranking.txt", sep="\t", quote=F, col.names=F, row.names=F)
