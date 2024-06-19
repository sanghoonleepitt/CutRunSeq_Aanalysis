#!/usr/bin/perl

use warnings;
use autodie;
use File::Copy "cp";

##########################################################################################
## Input Directory
my $FastqDir="/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46c_CutRunPeakcallingInstruction/04_TrimmomaticOut_CutRun_4smp";

## Output Directory
my $Path="/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46c_CutRunPeakcallingInstruction/05_CutRunTools_Output_4smp";

##########################################################################################

my $SmpBase; my $OutSubDir;  
my @ListFile = grep {-f} glob ($FastqDir."/*_R1.paired.fastq.gz");
my $TotalSmpNumb = scalar(@ListFile); 
print "total sample number: $TotalSmpNumb \n";

for (my $i=0; $i<$TotalSmpNumb; $i++) {
	my $FASTQFile = $ListFile[$i]; 
	print "Fastq file name: $FASTQFile \n";

	$OutSubDir = $FASTQFile; 
	$OutSubDir =~ s/\_R1.paired.fastq.gz//g; 
	$OutSubDir =~ s/(.*)\///g;
	$SmpBase = $OutSubDir; 
	print "SmpBase : $SmpBase \n";

	unless (-e $Path."/".$OutSubDir or mkdir $Path."/".$OutSubDir) {
		die "There is no outdirectory"
	} 	

	 if ($i > 0) {
		# print "sbatch --job-name=Step1_s$i --output=Log_CutRunTools_Step1.log Slurm_Step3_Integrated_Bowtie_SHmodified.sl $FastqDir $FASTQFile $SmpBase $Path \n";
		 system "sbatch --job-name=Step1_s$i --output=Log_CutRunTools_Step1.log Slurm_Step3_Integrated_Bowtie_SHmodified.sl $FastqDir $FASTQFile $SmpBase $Path";
	 }
	# last if $i ==0; 
}


















