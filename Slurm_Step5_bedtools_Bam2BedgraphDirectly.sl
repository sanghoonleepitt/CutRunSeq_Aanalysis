#!/bin/bash
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=63Gb
#SBATCH --time=24:00:00
#SBATCH --account=alee

date
module purge
module load gcc/8.2.0 bedtools/2.30.0 

echo $1 "bam file" 
echo $2 "output dir/bedgraph"

bedtools genomecov -bg -ibam $1 > $2


date