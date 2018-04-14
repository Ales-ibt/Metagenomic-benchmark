
Results comparison of Metaxa2 using blastn and megablast

Metaxa2 v2.1.1 is a bioiformatic tool designed to assign 16S rRNA sequences from a metagenomic dataset to an archaeal, bacterial, nuclear eukaryote, mitochondrial or chloroplast origin (1). Metaxa2, detect the 16S rRNA candidate sequences from the reads universe using hidden Markov models built from the SILVA database. Ribosomal sequences are compared against the Metaxa2 database by blast and the method takes into account the five best hits to assign the taxonomic identity per sequence. In the case of ambiguity (reliability score < 80), the algorithm align the five best hits using MAFFT and recalculates the reliability score for the next taxonomic level in the lineage until the score be > 80. The method use blastn by default, and have the option of running megablast. We tested the method with the V3V4 lib1 dataset available in the datasets_16SrRNA directory of this repo, using both options.

<table>
  <tr>
    <td></td>
    <td colspan="4">Metaxa2-mtx blastn</td>
    <td colspan="4">Metaxa2-mtx megablast</td>
  </tr>
  <tr>
    <td>Taxonomic level</td>
    <td>Sens</td>
    <td>Spec</td>
    <td>ACC</td>
    <td>MCC</td>
    <td>Sens</td>
    <td>Spec</td>
    <td>ACC</td>
    <td>MCC</td>
  </tr>
  <tr>
    <td>domain</td>
    <td>1.000000</td>
    <td>0.999840</td>
    <td>0.999992</td>
    <td>0.999916</td>
    <td>1.000000</td>
    <td>0.999867</td>
    <td>0.999994</td>
    <td>0.999930</td>
  </tr>

  <tr>
    <td>phylum</td>
    <td>1.000000</td>
    <td>0.999973</td>
    <td>0.999999</td>
    <td>0.999986</td>
    <td>1.000000</td>
    <td>0.999973</td>
    <td>0.999999</td>
    <td>0.999986</td>
  </tr>
  <tr>
    <td>class</td>
    <td>1.000000</td>
    <td>0.904833</td>
    <td>0.994992</td>
    <td>0.948723</td>
    <td>1.000000</td>
    <td>0.904833</td>
    <td>0.994992</td>
    <td>0.948723</td>
  </tr>
  <tr>
    <td>order</td>
    <td>0.969362</td>
    <td>0.829477</td>
    <td>0.961332</td>
    <td>0.699140</td>
    <td>0.969362</td>
    <td>0.829477</td>
    <td>0.961332</td>
    <td>0.699140</td>
  </tr>
  <tr>
    <td>family</td>
    <td>0.967010</td>
    <td>0.382080</td>
    <td>0.894109</td>
    <td>0.433813</td>
    <td>0.967010</td>
    <td>0.382070</td>
    <td>0.894108</td>
    <td>0.433803</td>
  </tr>
  <tr>
    <td>genus</td>
    <td>0.909425</td>
    <td>0.602545</td>
    <td>0.885172</td>
    <td>0.409323</td>
    <td>0.909425</td>
    <td>0.602529</td>
    <td>0.885171</td>
    <td>0.409312</td>
  </tr>
  <tr>
    <td>species</td>
    <td>0.199642</td>
    <td>0.795149</td>
    <td>0.235305</td>
    <td>-0.003090</td>
    <td>0.199642</td>
    <td>0.795127</td>
    <td>0.235304</td>
    <td>-0.003103</td>
  </tr>
  <tr>
    <td>subspecies</td>
    <td>0.111160</td>
    <td>0.978576</td>
    <td>0.153370</td>
    <td>0.062514</td>
    <td>0.111160</td>
    <td>0.978576</td>
    <td>0.153370</td>
    <td>0.062514</td>
  </tr>
</table>

We observed that performance statistical descriptors was almost identical indicating that blast parameters does not represent a substantial difference in the sensitivity and/or specificity of the Metaxa2 taxonomic assignments.

We runned both programs in the server of Biotechnology Institute (UNAM) splitting the dataset into chunks of 1,000 sequences. The jobs were performed over each chunk using 4 threads with 7G each. In the following table are the stats of time and memory spent in each case.







1. Bengtsson-Palme, J. et al. METAXA2: improved identification and taxonomic classification of small and large subunit rRNA in metagenomic data. Mol. Ecol. Resour. 15, 1403–1414 (2015).
