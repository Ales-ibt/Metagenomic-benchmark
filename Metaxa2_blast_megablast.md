
Results comparison of Metaxa2 using blastn and megablast

Metaxa2 v2.1.1 is a bioiformatic tool designed to assign 16S rRNA sequences from a metagenomic dataset to an archaeal, bacterial, nuclear eukaryote, mitochondrial or chloroplast origin (1). Metaxa2, detect the 16S rRNA candidate sequences from the reads universe using hidden Markov models built from the SILVA database. Ribosomal sequences are compared against the Metaxa2 database by blast and the method takes into account the five best hits to assign the taxonomic identity per sequence. In the case of ambiguity (reliability score < 80), the algorithm align the five best hits using MAFFT and recalculates the reliability score for the next taxonomic level in the lineage until the score be > 80. The method use blastn by default, and have the option of running megablast. We tested the method with the V3V4 lib1 dataset available in the datasets_16SrRNA directory of this repo, using both options.

<table>
  <tr>
    <td></td>
    <td colspan="4">Metaxa2-mtx blastn</td>
    <td colspan="4">Metaxa2-mtx megablast</td>
  </tr>
</table>



 |Span <td colspan="4">triple  <td colspan="4">double
 | --------------  | ---- | ---- | --- | --- | ---- | ---- | --- |---- |
 | Taxonomic level | sens | spec | ACC | MCC | sens | spec | ACC | MCC | 
 | Domain | 1.000000 | 0.999840 | 0.999992 | 0.999916 | 1.000000 | 0.999867 | 0.999994 | 0.999930 | 
 | Phylum | 1.000000 | 0.999973 | 0.999999 | 0.999986 | 1.000000 | 0.999973 | 0.999999 | 0.999986 | 
 | Class | 1.000000 | 0.904833 | 0.994992 | 0.948723 | 1.000000 | 0.904833 | 0.994992 | 0.948723 | 
 | Order | 0.969362 | 0.829477 | 0.961332 | 0.699140 | 0.969362 | 0.829477 | 0.961332 | 0.699140 | 
 | Family | 0.967010 | 0.382080 | 0.894109 | 0.433813 | 0.967010 | 0.382070 | 0.894108 | 0.433803 | 
 | Genus | 0.909425 | 0.602545 | 0.885172 | 0.409323 | 0.909425 | 0.602529 | 0.885171 | 0.409312 | 
 | Species | 0.199642 | 0.795149 | 0.235305 | -0.003090 | 0.199642 | 0.795127 | 0.235304 | -0.003103 | 
 | Subspecies | 0.111160 | 0.978576 | 0.153370 | 0.062514 | 0.111160 | 0.978576 | 0.153370 | 0.062514 | 

We observed that performance statistical descriptors was almost identical indicating that blast parameters does not represent a substantial difference in the sensitivity and/or specificity of the Metaxa2 taxonomic assignments.

We runned both programs in the server of Biotechnology Institute (UNAM) splitting the dataset into chunks of 1,000 sequences. The jobs were performed over each chunk using 4 threads with 7G each. In the following table are the stats of time and memory spent in each case.







1. Bengtsson-Palme, J. et al. METAXA2: improved identification and taxonomic classification of small and large subunit rRNA in metagenomic data. Mol. Ecol. Resour. 15, 1403–1414 (2015).
