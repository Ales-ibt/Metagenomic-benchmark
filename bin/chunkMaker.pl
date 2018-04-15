#!/usr/bin/perl
use strict;
use warnings;

###  PROGRAM THAT GENERATES SEQUENCE CHUNKS FROM A FASTA FILE ###
###  Alejandra Escobar-Zepeda, UUSMB, IBt, UNAM
###  03/July/2017


scalar@ARGV == 2 || die "usage: $0 <file.fasta> <chunk_size[int]>
";

my$file=$ARGV[0];
my$size=$ARGV[1];

my($cont_chunk, $cont_seq, $flag)=(0,0,0);
my($id,$seq);

open (ARCH, $file) or die ("I cannot open the file $file\n");
while (defined($id=<ARCH>)) {
	$seq=<ARCH>;	
	chomp $id;
	chomp $seq;

	if($cont_seq<=$size){
		if ($flag==0){
			$cont_chunk++;
			system("mkdir chunk_$cont_chunk");
			open (OUT, ">file_$cont_chunk\_$file");
		}
		$flag=1;
	
		print OUT "$id\n$seq\n";
	
		$cont_seq++;
	}else{
		print OUT "$id\n$seq\n";
		$flag=0;
		$cont_seq=0;
		close(OUT);
		system("mv file_$cont_chunk\_$file chunk_$cont_chunk");

	}
}
close(OUT);
system("mv file_$cont_chunk\_$file chunk_$cont_chunk");
close(ARCH);

