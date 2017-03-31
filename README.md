**Metagenomic-benchmark**

The code deposited in this site contains the necessary scripts to integrate, standardise and generate taxonomic annotation matrices at the eight basic levels of taxonomic lineage: domain, phylum, class, order, family, genus, species and subspecies. These tools provide the possibility of comparing taxonomic annotation results obtained by different methods and databases. Currently, the available scripts are designed to correct results from the following taxonomic annotation tools:

- Kraken v0.10.5-beta
- Metaphlan2 v2.2.0 
- MOCAT v1.3
- Qiime v1.9.1
- Metaxa2 v2.1.1
- Parallel-meta v2.4.1 and v3.3.2

**Requirements:**

Download and install the ete2 python library from:
http://etetoolkit.org/download/

Perl v5.x or higher


**Patching Parallel-meta v2.4.1 and v3.3.2**

To modify the parallel-meta v2.4.1 in order to accept the Metaxa2 database do the following:

-Before compiling the software, copy the patch_parallel241.txt file to the parallel-meta v2.4.1 root directory and run the command:

*patch -p0 < patch_parallel241.txt*

To prevent parallel-meta v3.3.2 from deleting intermediate read mapping files, do the following:

-Before compiling the software, copy the patch_parallel332.txt file to the parallel-meta v3.3.2 root directory and run the command:

*patch -p0 < patch_parallel332.txt*

**This project includes the following scripts:**

kraken_corrector.pl	    - Converts the kraken table into a matrix with the appropriate format, requires lineage_ete_id.py in the current directory
metaxa_corrector.pl	    - Cleans the metaxa matrix
qiime_corrector.pl	    - Cleans the qiime matrix
metaphlan_corrector.pl  - Cleans the metaphlan matrix, requires lineage_ete.py in the current directory 
mocat_corrector.pl      - Cleans the metaphlan matrix, requires lineage_ete.py in the current directory 
taxonomy2lineage.sh     - Converts taxonomy.txt to abundance matrix for parallel v2.4.1
classif2lineage.sh      - Converts classification.txt to abundance matrix for parallel 3
matrix_integrator.pl    - Integrates all matrices that are in the same format
rmv_inter_levels.pl     - Standardize taxonomic levels, requires lineage_ete.py and translator_ete.py in current directory
taxa_levels.pl          - Separates the integrated clean matrix in taxa_levels
count2percent.pl        - Converts raw counts matrix to relative total abundance as a percentage
patch_parallel241.txt   - Patch for Parallel-meta v2.4.1
patch_parallel332.txt   - Patch for Parallel-meta v3.3.2

