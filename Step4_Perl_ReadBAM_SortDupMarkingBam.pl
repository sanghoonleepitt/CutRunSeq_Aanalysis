#!/usr/bin/perl

use warnings;
use autodie;
use File::Copy "cp"; 

##########################################################################################
my $TopPath="/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46c_CutRunPeakcallingInstruction/05_CutRunTools_Output_4smp";

die "Your directoriy is specified wrong" 
	unless -d $TopPath;
##########################################################################################

my $LoopCount=0; 

my @ListDir = grep {-d} glob ($TopPath."/OESTERREICH*"); 

foreach my $SmpDir (@ListDir) {
	$LoopCount++;
	print "Sample directory: $SmpDir \n";
	my $BamPath=$SmpDir."/aligned.aug10";

	my @ListBamFile=grep {-f} glob ($BamPath."/*.bam");
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

	 if ($LoopCount >= 3) { 
		# print "sbatch --job-name=BedGrp_$LoopCount --output=Log_Step4_RmvDupBam_$SmpName.log Slurm_Step4_integrated_SortDupMarkingBam.sl $ListBamFile[0] $BamPath $SmpDir\n";
		 system "sbatch --job-name=BedGrp_$LoopCount --output=Log_Step4_RmvDupBam_$SmpName.log Slurm_Step4_integrated_SortDupMarkingBam.sl $ListBamFile[0] $BamPath $SmpDir"; 
	 } 
	 # last if $LoopCount==2;


}