#!/usr/bin/perl
use strict;
use warnings;

######## THIS PROGRAM INTEGRATES MATRICES WITH THE SAME FORMAT #######
######## Alejandra Escobar-Zepeda, USMB, IBt, UNAM
######## 2/Septiembre/2016


scalar@ARGV == 1 || die "usage: $0 <file_list.txt>
      file_list.txt      List of input files, each one is a matrix with the same format:
                         - No header
                         - Lineage is in the first column separated by ';'
                         - Abundance in integer numbers in the second column
";

my $files = $ARGV[0];
my @names;
my %each_matrix;
open (VALUES, $files) or die ("I can not open the file $files\n") ;
while (<VALUES>) {
	chomp;
	my $name = $_;
	PARSE($name);
	push(@names, $name);
}
close(VALUES);

## Imprimiendo la matriz de conteos
open MATCOUNT, ">integrated_matrix.txt" or die ("I can not create the file integrated_matrix.txt, check write permissions on current directory\n"); 
my $header = join("\t", @names);
print MATCOUNT "TAXONOMY\t$header\n"; #<STDIN>;

my $lastname=scalar@names;
my $cont_names=1;
foreach my $tax (sort keys %each_matrix) {
	print MATCOUNT "$tax\t";
	foreach my $file (@names) {
		if ($each_matrix{$tax}{$file}) {
			print MATCOUNT "$each_matrix{$tax}{$file}\t";
		} else {
			print MATCOUNT "0\t";
		}
	}

	print MATCOUNT "\n";
}
close(MATCOUNT);

### Subrutina que parsea
sub PARSE {
	my $file=shift;
	my @new_array=();
	open (FILE, $file) or die ("I can not open the file $file\n") ;
#	<FILE>;
	while (<FILE>) {
		chomp;
		my($taxo, $abundance)=split('\t', $_);
		my@lineage=split(/;/, $taxo);
		foreach my$each_name (@lineage){
			if ($each_name !~ /epsilon_subdivisions/ and $each_name !~ /[Gg]roup/  and $each_name !~ /unclassified/ and $each_name !~ /[Ii]ncertae_[Ss]edis/ ) {
				push(@new_array, $each_name);
			}
		}
		if (scalar@new_array == 6) {
			my$sp=join("_", $new_array[-1], "sp\.");
			push(@new_array, $sp);
			$taxo=join(";", @new_array);
		}else{
			$taxo=join(";", @new_array);
		}
		$each_matrix{$taxo}{$file}=$abundance;
		@new_array=();
	}
	close(FILE);
}

