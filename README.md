**Metagenomic-benchmark**

The code found in this site contains the necessary scripts to integrate, standardise and generate count tables used for taxonomic classification and abundance estimation, at eight lineage ranks: domain, phylum, class, order, family, genus, species and subspecies. These tools provide the tools for comparing taxonomic annotation results obtained from different methods and databases by CVE plots. Metrics such as specificity, sensitivity, accuracy and Matthews correlation coefficient can be calculated as well. A detailed description of this process is included here in the recipes directory. 

Currently, the available scripts were designed to manage the results obtained from the following taxonomic annotation tools:

- Kraken v0.10.5-beta
- CLARK v1.2.3.1
- MetaPhlAn2 v2.2.0 
- MOCAT v1.3
- QIIME v1.9.1
- SPINGO v1.3
- Metaxa2 v2.1.1
- Parallel-meta v2.4.1 and v3.3.2

However, users are free to modify the scripts to include new methods as long as their results have the right format. Please, check this format in the "examples" directory.

Taxonomic databases for 16S rRNA ampicon annotation:

- SILVA v128
- GreenGenes v13.5
- RDP v11.5
- Metaxa2 database


**Requirements:**

Download and install the ete3 python library from:
http://etetoolkit.org/download/

Perl v5.x or higher
Python v2.7.x
samtools v0.1.19-96b5f2294a or higher

**Patching Parallel-meta v2.4.1 **

We formatted the Metaxa2 database to be used by Parallel-meta software. The database version used in our analysis is available from the following link: https://drive.google.com/open?id=1c2s1C9j9Hqoq13CirphJR3tMd4mbP8K7. Before compiling the Parallel-meta v2.4.1 program, download the Metaxa_db.tar.gz file and placed it into the parallel-meta/databases/ directory. Untar the file using:

$ tar -xvf Metaxa_db.tar.gz

This action will create the Metaxa directory with the database properly formatted inside the Parallel-meta databases path. To modify the parallel-meta v2.4.1 in order to accept the Metaxa2 database follow these instructions:

-Download Parallel-meta 2.4 from here:https://github.com/Comp-Bio-Group/Parallel-META
-Before compiling the software, copy the patch_parallel241.txt file to the parallel-meta v2.4.1 root directory and run the command:

*patch -p0 < patch_parallel241.txt*

**Scripts included in the bin directory of Metagenomic-benchmark:**
- patch_parallel241.txt   - Patch for Parallel-meta v2.4.1

  16SrRNAamplicon/
      	names2taxid_spingo.py
      	qiime_transfer.pl
	      shuffled_fasta.pl
	      spingo_cleaner_GG_MTX.pl
	      spingo_cleaner_RDP.pl
      	spingo_cleaner_SIL.pl
	      taxid2level.py
  
  WholeMetagenomeShotgun/
 	      0.get_table_mtx_rdp_silva.R
	      1.cuentas_kraken_mod.R
	      2.get_linage_rank.py
	      3.order_lineage_method.pl
	      4.tabla_ordenada_conGenoma.R
	      5.tabla_new.R
	      7.subtit_TF.pl
	      get_taxid_from_names.py
	      taxid2level.py


Extra tables:
- ncbi_plus_unicos.txt     - Relational table containing the reference lineage taxids at the eight main taxonomic levels (superkingdom, phylum, class, order, family, genus, species, subespecies) for all the genomes used to generate the in-silico sequences.
- taxid_dobles.txt       - NCBI redundant names list. We keept the bacterial taxids when ambiguity exists in prokariontic domain.
- taxid_metaphlan.txt	- Relational table containing the taxids include in MetaPhlAn2.

**Specifications about the software and parameters used are in the following table:**

**Metaxa2 v2.2.1**

$ metaxa2 -1 file_R1.fq -2 file_R2.fq -o metaxa_out -f fastq \\

--plus T --fasta F --cpu 32 -d /PATH/database.fasta

**Parallel-meta v2.4.1**

$ parallel-meta -b B -r\|m file.fastq -d database -n 32

**SPINGO v1.3**

$ spingo -p 32 -d /PATH/database.fasta-i file.fasta -a > result.txt

**QIIME v1.9.1**

$ pick_otus.py -i file.fasta -o uclust_picked_otus --threads 16
$ pick_rep_set.py -i uclust_picked_otus/file_otus.txt \\

-f file.fasta -l rep_set/file_rep_set.log -o rep_set/file_otus_rep_set.fasta

$ assign_taxonomy.py -i rep_set/file_otus_rep_set.fasta \\

-o uclust_assigned_taxonomy -r db.fasta -t taxonomy.txt

$ make_otu_table.py -i uclust_picked_otus/file_otus.txt \\

-t uclust_assigned_taxonomy/file_otus_rep_set_tax_assignments.txt \\

-o otu_table.biom

$ summarize_taxa.py -i otu_table.biom -o taxa_counts -a \\

--suppress_biom_table_output

**MetaPhlAn2 v2.2.0**

metaphlan2.py file_1.fq,file_2.fq --mpa_pkl mpa_v20_m200.pkl \\

--bowtie2db mpa_v20_m200 --bt2_ps sensitive-local \\

--bowtie2out file.bowtie2.bz2 --samout file.sam --nproc 32 \\

--input_type fastq --min_alignment_len 95 > metaphlan_out.txt

**MOCAT v1.3**

$ MOCAT.pl -sf samples.txt -rtf

$ MOCAT.pl -sf samples.txt -s mOTU.v1.padded \\

-r reads.processed -identity 97
$ MOCAT.pl -sf samples.txt -f mOTU.v1.padded \\

-r reads.processed -identity 97

$ MOCAT.pl -sf samples.txt -p mOTU.v1.padded \\

-r reads.processed -identity 97 -mode mOTU -o Results

$ MOCAT.pl -sf samples.txt -s RefMG.v1.padded \\

-r mOTU.v1.padded -e -identity 97

$ MOCAT.pl -sf samples.txt -f RefMG.v1.padded \\

-r mOTU.v1.padded -e -identity 97

$ MOCAT.pl -sf samples.txt -p RefMG.v1.padded \\

-r mOTU.v1.padded -e -identity 97 -mode RefMG \\

-previous_db_calc_tax_stats_file -o Results

**Kraken v0.10.5-beta**

$ kraken --preload --db /Databases/Kraken/ \\

--threads 16 --output kraken.out file.fastq

$ kraken-report --db /Databases/Kraken/ kraken.out > kraken.report

**CLARK v1.2.3.1**
classify_metagenome.sh -k 21 -P file_R1.fq file_R2.fq \\

-R /PATH/clark.results -n 32 -m 0


All results were reported and analyzed in the submitted paper:

Escobar-Zepeda Alejandra, Godoy-Lozano E. Ernestina, Raggi Luciana, Segovia Lorenzo, Merino Enrique, Gutiérrez-Rios Rosa María, Juarez-Lopez Katy, Licea-Navarro Alexei F., Pardo-Lopez Liliana and Sanchez-Flores Alejandro. **Analysis of sequencing strategies and tools for taxonomic annotation: Defining standards for progressive metagenomics**. *submitted.* 2018.



