#!/usr/bin/perl
# This perl script read TCGA barcode from a txt file, and find files with a specific extension, decompress, and copy them to a designated folder.

#Getting names of directories under given path, https://stackoverflow.com/questions/1692492/getting-names-of-directories-under-given-path
#Regular expression basic: https://www.cs.tut.fi/~jkorpela/perl/regexp.html
#How to remove, copy or rename a file with Perl  https://perlmaven.com/how-to-remove-copy-or-rename-a-file-with-perl

#use strict;
use warnings;
use autodie;
use File::Copy qw(copy);  #copy a file
use File::Copy "cp";

#################################################################
my $path="/bgfs/alee/LO_LAB/General/Lab_Data/20231012_LeeCHP5_Abdalla_M134M453_CutRunSeq"; 
my $OutDir="/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46c_CutRunPeakcallingInstruction/4_TrimmomaticOut_M134M456_CutRunSeq";

die "Your directory is specified wrong"
	unless -d $path;

unless (-e $OutDir or mkdir $OutDir) {
	die "There is no outdirectory"
}
die "output directory is wrong specified" unless -d $OutDir;
############################################################
############################################################

my $count=0;
my @listFile = grep {-f} glob ($path."/*.fastq.gz");
my $fileNumber=0;
my $filename;

foreach my $fastqfile (@listFile) {
	#print "fastq directory/filename: $fastqfile \n";
	$filename=$fastqfile ;
	$filename =~ s/(.*)\///g ;
	$filename =~ s/\.(.*)//g;
	$filename =~ s/\_(.*)//g;
	#print "fastq filename: $filename \n";	
	$fileNumber++;
} # end of foreach 

print "total number of files in the directory: $fileNumber \n";
my $pairNum=$fileNumber/2;
#print "total number of pair: $pairNum \n";

my $R1file=0;
my $R2file=1;
	
for (my $i=0; $i<$pairNum; $i++) {
	$count++;
	my $r1_fastq =  $listFile[$R1file];
	my $r2_fastq =  $listFile[$R2file];
	#my $r1_fastq = "../NoInterleaved_61600_CSER_MET500_phs000673.v2_BCmetaHybrid_91fastq/SRR4306164_1.fastq";
	#my $r2_fastq= "../NoInterleaved_61600_CSER_MET500_phs000673.v2_BCmetaHybrid_91fastq/SRR4306164_2.fastq";
	print "first R1.fastq.gz:  $r1_fastq  \n";
	print "second R2.fastq.gz:  $r2_fastq \n";

	my $dataname = $r1_fastq;
	$dataname =~ s/(.*)\///g;
	$dataname =~ s/\_.\.fastq.gz//g;
	print "data name: $dataname \n";

	my $r1_filename = $r1_fastq;
	my $r2_filename = $r2_fastq;

	$r1_filename =~ s/(.*)\/|.fastq.gz//g;
	$r2_filename =~ s/(.*)\/|.fastq.gz//g;

	$r1_filename =~ s/_001//g;
	$r2_filename =~ s/_001//g;
	
	 if ($count>1)  { 
		# print "sbatch --job-name=Trimmo$count --output=Trimmomatic_$dataname.log Slurm_Step2_trimmomaticV0.39_CRC.sl $r1_fastq $r2_fastq $OutDir/$r1_filename $OutDir/$r2_filename \n";			
		system "sbatch --job-name=Trimmo$count --output=Trimmomatic_$dataname.log Slurm_Step2_trimmomaticV0.39_CRC.sl $r1_fastq $r2_fastq $OutDir/$r1_filename $OutDir/$r2_filename";			
	 }
	$R1file += 2;
	$R2file += 2;

	print "count : $count \n";
	# last if $count==1;
}


