#!/usr/bin/perl

use warnings;
use autodie;
use File::Copy "cp"; 

##########################################################################################
my $BedgraphPath="/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46c_CutRunPeakcallingInstruction/06_SEACR_v1.3/01a_BedgraphOutput_dupdeleted";
my $OutPath="/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46c_CutRunPeakcallingInstruction/06_SEACR_v1.3/02a_SEACROutput_dupdeleted";

	######
	my $BedgraphFile=$BedgraphPath."/OESTERREICH_1.fragments.bedgraph";
	my $BackgroundSmp = $BedgraphPath."/OESTERREICH_4.fragments.bedgraph";
	######

die "Your directoriy is specified wrong" 
	unless -d $BedgraphPath;

unless (-e $OutPath or mkdir $OutPath) {
		die "There is no outdirectory"
} 
die "Output directory is wrong specified" unless -d $OutPath; 
##########################################################################################

my $LoopCount=0; 

my @ListFile = grep {-f} glob ($BedgraphPath."/*.fragments.bedgraph"); 


#foreach my $BedgraphFile (@ListFile ) {
	$LoopCount++;

	print "Bed file: $BedgraphFile \n";

	my $SmpName=$BedgraphFile ;
	$SmpName=~s/(.*)\/|.fragments.bedgraph//g;
	print "sample name: $SmpName\n";

	# my $OutFileName=$BedgraphFile ;
	# $OutFileName=~s/.fragments.bed/.fragments.bedgraph/g;
	# print "out file name: $OutFileName\n";

	# my $SortFileName=$OutFileName.".fragments.bed";
	# print "out sort file name: $SortFileName\n";

	#if ($LoopCount == 3) { 
		# print "sbatch --job-name=BedGrp_$LoopCount --output=Log_Step7_SEACR_$SmpName.log Slurm_Step7_SEACR_bedgraph2bed.sl $BedgraphFile $BackgroundSmp $OutPath/$SmpName\n";
		 system "sbatch --job-name=BedGrp_$LoopCount --output=Log_Step7_SEACR_$SmpName.log Slurm_Step7_SEACR_bedgraph2bed.sl $BedgraphFile $BackgroundSmp $OutPath/$SmpName";
	#}
	# last if $LoopCount==1;

#}