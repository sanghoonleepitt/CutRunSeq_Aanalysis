#!/bin/bash
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=63GB
#SBATCH --time=24:00:00
#SBATCH --account=alee


date
module purge
module load gcc/8.2.0 trimmomatic/0.38  # CRC


echo fastq_r1, $1 ;  fastq_r2, $2
echo fastq1 filename, $3 ; fastq2 filename $4 
#lecture, http://www.usadellab.org/cms/?page=trimmomatic

java -jar /ihome/crc/install/trimmomatic/Trimmomatic-0.38/trimmomatic-0.38.jar PE -phred33 \
$1 $2 $3.paired.fastq.gz $3.unpaired.fastq.gz $4.paired.fastq.gz $4.unpaired.fastq.gz \
ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36


date

