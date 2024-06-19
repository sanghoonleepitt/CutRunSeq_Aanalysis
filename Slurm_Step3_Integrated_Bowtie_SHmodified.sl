#!/bin/bash
#SBATCH -n 1                               # Request one core
#SBATCH -N 1                               # Request one node (if you request more than one core with -n, also using
                                           # -N 1 means all cores will be on the same node)
#SBATCH -t 0-12:00                         # Runtime in D-HH:MM format
###SBATCH -p short                           # Partition to run in
#SBATCH --mem=32000                        # Memory total in MB (for all cores)
#SBATCH --account=alee
#SBATCH -o CutRunToolStep1_%j.out                 # File to which STDOUT will be written, including job ID
#SBATCH -e CutRunToolStep1_%j.err                 # File to which STDERR will be written, including job ID
###SBATCH --mail-type=ALL                    # Type of email notification- BEGIN,END,FAIL,ALL
###SBATCH --mail-user=bernardzhu@gmail.com   # Email to which notifications will be sent

#=================================================
#remember to change hg19 to mm10 if needed
#remember to create/modify file "length" with the length of the reads (currently 42)
#=================================================

#Usage: ./integrated.sh CR_NFYA_RNP115_r3_S5_R1_001.fastq.gz
#Note: an experiment will have both *R1_001.fastq.gz and *R2_001.fastq.gz files. Specify the *R1_001.fastq.gz file.

module load cutruntools/1028_2019
module load gcc/10.2.0 
module load trimmomatic/0.38
module load bowtie2/2.4.5
module load gcc/8.2.0 samtools/1.14
# module load gcc/6.2.0

trimmomaticbin=/ihome/crc/install/cutruntools/python2.7/bin
adapterpath=/ihome/crc/install/cutruntools/qzhudfci-cutruntools-e613a5a6930b
bowtie2bin=/ihome/crc/install/cutruntools/python2.7/bin
# samtoolsbin=/ihome/crc/install/cutruntools/python2.7/bin
# len=`cat length`

echo $1 ": fastq Directory"
echo $2 ": directory/fastq_1.paired.fastq.gz"
echo $3 ": SampleBase"
echo $4 ": OutDirecotyr" 

workdir=$4   #`pwd`
workdir=$workdir/$3
trimdir=$workdir/trimmed
trimdir2=$workdir/trimmed3
logdir=$workdir/logs
bt2idx=/ix/xiaosongwang/sal170/3_TopHat-fusion_TCGA_OV/BowtieIndex2_hg38_new   # Ref genome location
aligndir=$workdir/aligned.aug10

mkdir $trimdir
mkdir $trimdir2
mkdir $logdir
mkdir $aligndir

infile=$2
base=$3
#base=`basename $infile _R1_001.fastq.gz`


>&2 echo "Input file is $infile"
>&2 date

#trimming paired-end
#good version
>&2 echo "Trimming file $base ..."
>&2 date
# java -jar /ihome/crc/install/trimmomatic/Trimmomatic-0.38/trimmomatic-0.38.jar PE -threads 1 -phred33 $workdir/"$base"_R1_001.fastq.gz $workdir/"$base"_R2_001.fastq.gz $trimdir/"$base"_1.paired.fastq.gz $trimdir/"$base"_1.unpaired.fastq.gz $trimdir/"$base"_2.paired.fastq.gz $trimdir/"$base"_2.unpaired.fastq.gz ILLUMINACLIP:$adapterpath/Truseq3.PE.fa:2:15:4:4:true LEADING:20 TRAILING:20 SLIDINGWINDOW:4:15 MINLEN:25

>&2 echo "Second stage trimming $base ..."
>&2 date
#/home/qz64/kseq_test $trimdir/"$base"_1.paired.fastq.gz $len $trimdir2/"$base"_1.paired.fastq.gz
#/home/qz64/kseq_test $trimdir/"$base"_2.paired.fastq.gz $len $trimdir2/"$base"_2.paired.fastq.gz

>&2 echo "Aligning file $base ..."
>&2 date
($bowtie2bin/bowtie2 -p 2 --dovetail --phred33 -x $bt2idx/genome -1 $1/"$base"_R1.paired.fastq.gz -2 $1/"$base"_R2.paired.fastq.gz) 2> $logdir/"$base".bowtie2 | samtools view -bS - > $aligndir/"$base"_aligned_reads.bam
# ($bowtie2bin/bowtie2 -p 2 --dovetail --phred33 -x $bt2idx/genome -1 $trimdir/"$base"_1.paired.fastq.gz -2 $trimdir/"$base"_2.paired.fastq.gz) 2> $logdir/"$base".bowtie2 | samtools view -bS - > $aligndir/"$base"_aligned_reads.bam
# ($bowtie2bin/bowtie2 -p 2 --dovetail --phred33 -x $bt2idx/hg19 -1 $trimdir/"$base"_1.paired.fastq.gz -2 $trimdir/"$base"_2.paired.fastq.gz) 2> $logdir/"$base".bowtie2 | $samtoolsbin/samtools view -bS - > $aligndir/"$base"_aligned_reads.bam


>&2 echo "Finished"
>&2 date
