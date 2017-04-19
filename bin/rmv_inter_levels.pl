#!/usr/bin/perl
use strict;
use warnings;

######## PROGRAM THAT ELIMINATES THE INTERIM TAXONOMIC LEVELS OF THE NCBI TAXONOMY #######
######## Alejandra Escobar-Zepeda, UUSMB, IBt, UNAM
######## 12/Enero/2017

scalar@ARGV == 1 || die "usage: $0 <matrix.txt> 
Requires lineage_ete.py and translator_ete.py in the current directory
Requires ete2 installed
" ;

my $file=$ARGV[0];
my %integrated=();
my %recover;
my %chloroplast;
my $name_query;
open (FILE, $file) or die ("I can not open the file $file\n");
my$header=<FILE>;
while (<FILE>) {
	chomp;
	my@line=split(/\t/, $_);
	my$linaje=shift@line;
	$linaje=~s/other_sequences;artificial_sequences;synthetic_construct/Unidentified/;
	$linaje=~s/root/Unidentified/;
	$linaje=~s/[Uu]nknown/Unidentified/;
	$linaje=~s/[Uu]nassigned/Unidentified/;
	$linaje=~s/cellular_organisms/Unidentified/;
	$linaje=~s/unclassified_sequences;unidentified/Unidentified/;
	$linaje=~s/unidentified/Unidentified/;
	$linaje=~s/Koribacteraceae/Acidobacteriaceae/g;
	$linaje=~s/Acidopila/Acidipila/;
	$linaje=~s/Agrobacterium;sullae/Rhizobium;sullae/;
	$linaje=~s/;Unclassified_sp\.//;
	$linaje=~s/_[Gg]roup//g if ($linaje !~ /Termite/);
	$linaje=~s/\"//g;
	$linaje=~s/\'//g;
	$linaje=~s/\,//g;
	$linaje=~s/\[//g  if ($linaje !~ /Bacillus/ or $linaje !~ /Clostridium/);
	$linaje=~s/\]//g  if ($linaje !~ /Bacillus/ or $linaje !~ /Clostridium/);
        $linaje=~s/ /_/g;
        $linaje=~s/[;]+/;/g;
        $linaje=~s/;$//;

	if ($linaje =~ /Chloroplast;/ or $linaje =~ /Mitochondria/){	## From Metaxa
	        $linaje=~s/;Unclassified//g;
		my$numbers=join('+', @line);
		$chloroplast{$linaje}=$numbers;
       
        }elsif ($linaje eq 'Unclassified'){
                $non_class=$_;

	}else{
		if ($linaje =~ m/;/){
			my@taxa=split(';', $linaje);

			if ($taxa[-1] eq $taxa[-2]){
				pop@taxa;
			}
			if ($taxa[-1] eq $taxa[-2]){
				pop@taxa;
			}

			if ($taxa[-1] =~ /^[a-z]/){
				my$corr=join('_', $taxa[-2], $taxa[-1]);
				pop@taxa;
				push(@taxa, $corr);
			}
			if ($taxa[-1] =~ /^Unclassified/){
				pop@taxa;
			}
	
			$name_query=pop(@taxa);
			my$nombre_cut=join(';', @taxa);
			$recover{$name_query}=$nombre_cut;
	
			if (exists $integrated{$name_query}){
				my@repetida=split('\+', $integrated{$name_query});
				my@sumas=();
				for (my $i=0; $i<scalar@line; $i++){
					my$add=$repetida[$i]+$line[$i];
					push(@sumas, $add);
				}
				my$numbers=join('+', @sumas);
				$integrated{$name_query}=$numbers;
			}else{
				my$numbers=join('+', @line);
				$integrated{$name_query}=$numbers;
			}
		}else{
			$recover{$linaje}=$linaje;
			if (exists $integrated{$linaje}){
				my@repetida=split('\+', $integrated{$linaje});
				my@sumas=();
				for (my $i=0; $i<scalar@line; $i++){
					my$add=$repetida[$i]+$line[$i];
					push(@sumas, $add);
				}
				my$numbers=join('+', @sumas);
				$integrated{$linaje}=$numbers;
			}else{
				my$numbers=join('+', @line);
				$integrated{$linaje}=$numbers;
			}
		}
	
	}

}
close(FILE);

my%homog_matrix=ETE(\%integrated);
my($cont_rare,$cont_total)=(0,0);
open OUT, ">clean_$file" or die ("I can not create the output file clean_$file, Check write permissions on current directory\n");
open RARE, ">rare_names.out" or die ("I can not create the output file rare_names.out, Check write permissions on current directory\n");
print OUT "$header";
foreach my$llave_homog (sort keys %homog_matrix){
	$cont_total++;
	if ($homog_matrix{$llave_homog}=~/\*\*$/){
		$cont_rare++;
		my$mod_numeros=$homog_matrix{$llave_homog};
		$mod_numeros=~s/_\*\*$//;
		$mod_numeros=~s/\+/\t/g;
		if ($recover{$llave_homog}){
			print OUT "$recover{$llave_homog}\;$llave_homog\t$mod_numeros\n";	
			print RARE "$recover{$llave_homog}\;$llave_homog\t$mod_numeros\n";	
		}else{
			print "Lost key: $llave_homog\n";
		}
	}else{
		my$mod_numeros=$homog_matrix{$llave_homog};
		$mod_numeros=~s/\+/\t/g;
		print OUT "$llave_homog\t$mod_numeros\n";
	}
}

foreach my$llave_chlo (sort keys %chloroplast){
	$cont_total++;
	my$content=$chloroplast{$llave_chlo};
	$content=~s/\+/\t/g;
	print OUT "$llave_chlo\t$content\n";
}

print OUT "$non_class\n";

close(OUT);
close(RARE);
print "Total number of entries in the original matrix: $cont_total\n";
print "Total number of not found names in NCBI: $cont_rare\n";

## Subrutina que llama el script de python para obtener la filogenia completa del NCBI
sub ETE {
	my %hash_sub=%{$_[0]};
	my %regresa=();
	open TMP, ">names.tmp.list", or die ("I can not create the output file names.tmp.list, Check write permissions on current directory\n");
	foreach my $llave (sort keys %hash_sub){
		my$mod_llave=$llave;
		$mod_llave=~ s/_/ /g;
		print TMP "$mod_llave\t$hash_sub{$llave}\n";
	}
	close(TMP);

	system("./lineage_ete.py names.tmp.list > ete_names.out");
	system(q(cat ete_names.out | sed -e "s/\[//g;s/\]//g;s/u'//g;s/'//g;s/,[ ]/\;/g;s/[ ]/_/g;s/_\t/\t/" > ete_lineage.txt));

	open TEMP, ">to_translate.list", or die ("I can not create the output file translated.list, Check write permissions on current directory\n");
	open LIN, ("ete_lineage.txt") or die ("I can not open the file ete_lineage.txt\n");
	while (<LIN>) {
		my @ranks = qw(superkingdom phylum class order family genus species subspecies);
		my %ranksarray;
		my $conta = 0;
		foreach my $taxonomy (@ranks) {
		        $ranksarray{$taxonomy} = $conta;
		        $conta++;
		}

		chomp;
		if ($_ !~ /_\*\*$/){
			my($tax_ids, $guide, $abundance)=split('\t', $_);
			$guide=~s/_$//;
			my(@ids)=split(';', $tax_ids);
			my(@tax)=split(';', $guide);

			foreach my $taxidx (0..$#tax) {
				unless ($tax[$taxidx] =~ /no_rank/ or $tax[$taxidx] =~ /species_subgroup/ or $tax[$taxidx] =~ /species_group/ or $tax[$taxidx] =~ /subfamily/ or $tax[$taxidx] =~ /superfamily/ or $tax[$taxidx] =~ /suborder/ or $tax[$taxidx] =~ /subclass/ or $tax[$taxidx] =~ /superclass/ or $tax[$taxidx] =~ /infraclass/ or $tax[$taxidx] =~ /subgenus/ or $tax[$taxidx] =~ /tribe/ or $tax[$taxidx] =~ /subphylum/ or $tax[$taxidx] =~ /u\'kingdom/ or $tax[$taxidx] eq 'kingdom' or $tax[$taxidx] =~ /varietas/ or $tax[$taxidx] =~ /subkingdom/) {
					my $query=$tax[$taxidx];
					my $index = $ranksarray{$query};
	        	        	$ranks[$index] = $ids[$taxidx];
	        		}
			}
			foreach my $elem (@ranks) {
			        $elem = 0 unless $elem =~ /\d+/;
			}
			my $result = join(";", @ranks);
			$result=~s/;[0;]+$//;			
			print TEMP "$result\t$abundance\n";

		}else{
			my($name_rare, $abun)=split('\t', $_);
			$regresa{$name_rare}=$abun;
		}

	}
	close(LIN);
	close(TEMP);

	system("./translator_ete.py to_translate.list > ete_final.out");

	open DIRTY, ("ete_final.out") or die ("I can not open the file ete_final.out\n");
	while (<DIRTY>) {
		chomp;
		my$sucio=$_;
		$sucio=~s/ \{\} /no_rank/g;
		$sucio=~s/\{\d+: u'//g;
		$sucio=~s/'\} ;/;/g; 
		$sucio=~s/; /;/g;
		$sucio=~s/ /_/g;
		my@limpio=split(';', $sucio);
		my$abundance=pop(@limpio);
		my$name_ok=join(";", @limpio);
		$regresa{$name_ok}=$abundance;
	}
	close(DIRTY);
	system("rm names.tmp.list ete_names.out ete_lineage.txt to_translate.list ete_final.out");
	return(%regresa);
}

