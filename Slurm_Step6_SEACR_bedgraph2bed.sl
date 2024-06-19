#!/bin/bash
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=63Gb
#SBATCH --time=24:00:00
#SBATCH --account=alee

date
module purge
# module load seacr/1.3 # use downloaded SEACR_1.3.sh and SEACR_1.3.R
module load gcc/8.2.0 bedtools/2.30.0 
module load r/4.1.0


#cd /bgfs/alee/LO_LAB/Personal/SanghoonLee/H46b_CutRun_HCC2185_TFAP2b_Abdalla/06_SEACR_v1.3

echo "bedgraph file" $1
echo "IgG sample" $2
echo "outdir/smpname" $3



./SEACR_1.3.sh $1 $2 norm relaxed $3  # SEACR_1.3.sh file is running once I load module seacr/1.3

date