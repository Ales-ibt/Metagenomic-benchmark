#!/bin/bash
cut -f3,4,5,6,7,8,9,10 taxonomy.txt | sort | uniq | sed '/ResultTaxonomy/d' | awk -F "\t" '{print $2 ";" $3 ";" $4 ";" $5 ";" $6 ";" $7 ";" $8 "\t" $1}' | sed 's/[;]\+\t/\t/;s/[ ]/_/g;s/[;]\+/;/g;s/;Unclassified\t/\t/' > taxonomy2lineage.txt

