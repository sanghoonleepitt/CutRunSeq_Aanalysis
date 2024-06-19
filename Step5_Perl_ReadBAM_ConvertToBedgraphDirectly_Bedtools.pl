#!/usr/bin/perl

use warnings;
use autodie;
use File::Copy "cp"; 

##########################################################################################
my $BamPath="/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46c_CutRunPeakcallingInstruction/05_CutRunTools_Output_4smp";
my $OutTopPath="/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46c_CutRunPeakcallingInstruction/05_CutRunTools_Output_4smp/06_SEACR_v1.3";
my $OutPath="/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46c_CutRunPeakcallingInstruction/05_CutRunTools_Output_4smp/06_SEACR_v1.3/01a_BedgraphOutput_dupdeleted";

die "Your directoriy is specified wrong" 
	unless -d $BamPath;

unless (-e $OutTopPath or mkdir $OutTopPath) {
		die "There is no outdirectory"
} 
die "Output directory is wrong specified" unless -d $OutTopPath; 


unless (-e $OutPath or mkdir $OutPath) {
		die "There is no outdirectory"
} 
die "Output directory is wrong specified" unless -d $OutPath; 

##########################################################################################

my $LoopCount=0; 

my @ListDir = grep {-d} glob ($BamPath."/*"); 

foreach my $SmpDir (@ListDir) {
	$LoopCount++;
	print "Sample directory: $SmpDir \n";
	 my $BamPath=$SmpDir."/aligned.aug10/dedup/";
	# my $BamPath=$SmpDir."/aligned.aug10/dedup.120bp/";

	my @ListBamFile=grep {-f} glob ($BamPath."*.bam");
	print "My Bam file: $ListBamFile[0] \n"; # /directory/OESTERREICH_4_S4_aligned_reads.bam

	my $SmpName=$ListBamFile[0];
	$SmpName=~s/(.*)\/|_S\d(.*)//g;
	$SmpName="Smp".$SmpName;
	print "sample name: $SmpName\n";

	my $OutFileName=$SmpName.".fragments.bedgraph";
	# $OutFileName=~s/.fragments.bed/.fragments.bedgraph/g;
	print "out file name: $OutFileName\n";

	# my $SortFileName=$OutFileName.".fragments.bed";
	# print "out sort file name: $SortFileName\n";

	 if ($LoopCount >= 2) { 
		 print "sbatch --job-name=BedGrp_$LoopCount --output=Log_Step5_bam2bedgraph_$SmpName.log Slurm_Step5_bedtools_Bam2BedgraphDirectly.sl $ListBamFile[0] $OutPath/$OutFileName\n";
		# system "sbatch --job-name=BedGrp_$LoopCount --output=Log_Step5_bam2bedgraph_$SmpName.log Slurm_Step5_bedtools_Bam2BedgraphDirectly.sl $ListBamFile[0] $OutPath/$OutFileName";
	 } 
	# last if $LoopCount==1;


}