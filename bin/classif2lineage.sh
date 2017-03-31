#!/bin/bash
cut -f5 classification.txt | grep -v 'Classification' | sort | uniq -c | sort -nr | sed 's/^[ ]\+//;s/; /;/g' | awk '{print $2 "\t" $1}' > abun_otus.txt
cut -f5 classification.txt | grep -v 'Classification' | sed 's/\; otu_[0-9]\+//;s/\; Unclassified$//' | sort | uniq -c | sort -nr | sed 's/^[ ]\+//;s/\; /\;/g;s/\;sp/_sp/' | awk '{print $2 "\t" $1}' > abun_no_otus.txt
