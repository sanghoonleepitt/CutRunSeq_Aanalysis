#!/usr/bin/perl

use warnings;
use autodie;
use File::Copy "cp"; 

##########################################################################################
my $BedPath="/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46c_CutRunPeakcallingInstruction/06_SEACR_v1.3/02a_SEACROutput_dupdeleted";
my $OutPath="/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46c_CutRunPeakcallingInstruction/06_SEACR_v1.3/02a_SEACROutput_dupdeleted";

die "Your directoriy is specified wrong" 
	unless -d $BedPath;

# unless (-e $OutPath or mkdir $OutPath) {
# 		die "There is no outdirectory"
# } 
# die "Output directory is wrong specified" unless -d $OutPath; 
##########################################################################################
my $LoopCount=0; 
my @ListBedFile = grep {-f} glob ($BedPath."/*.relaxed.bed"); 

foreach my $BedFile (@ListBedFile ) {
	$LoopCount++;

	print "Bed file: $BedFile\n";

	my $SmpName=$BedFile;
	$SmpName=~s/(.*)\/|.relaxed.bed//g;
	print "sample name: $SmpName\n";

	my $BedgraphOutFileName=$SmpName.".relaxed.bedgraph";
	print "out file name: $BedgraphOutFileName\n";

	my $SortBedgraphFileName=$SmpName.".relaxedSorted.bedgraph";
	print "out sort file name: $SortBedgraphFileName\n";

	my $BigWigFileName=$SmpName.".relaxedSorted.bw";
	print "out BigWig file name: $BigWigFileName\n";

	if ($LoopCount >= 1) { 
		# print "sbatch --job-name=BigWig_$LoopCount --output=Log_Step6_MakeBigWig_$SmpName.log Slurm_Step6_BedgraphSortToBigWig.sl $BedFile $OutPath/$BedgraphOutFileName $OutPath/$SortBedgraphFileName $OutPath/$BigWigFileName\n";
		 system "sbatch --job-name=BigWig_$LoopCount --output=Log_Step6_MakeBigWig_$SmpName.log Slurm_Step6_BedgraphSortToBigWig.sl $BedFile $OutPath/$BedgraphOutFileName $OutPath/$SortBedgraphFileName $OutPath/$BigWigFileName";
	}
	# last if $LoopCount==1;

}