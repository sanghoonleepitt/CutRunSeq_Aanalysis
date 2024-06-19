#!/bin/bash
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=63Gb
#SBATCH --time=24:00:00
#SBATCH --account=alee

date
# module purge
# module load gcc/8.2.0 bedtools/2.30.0 

echo "relaxed bed file: " $1  
echo "output dir/relaxedBedgraph file: " $2 
echo "output dir/Sorted bedgraph file: " $3
echo "output dir/bigwig file: " $4


awk '{printf "%s\t%d\t%d\t%2.3f\n" , $1,$2,$3,$5}' $1 > $2
sort -k1,1 -k2,2n $2 > $3
./bedGraphToBigWig $3 ChromosomeSize.txt $4


# awk '{printf "%s\t%d\t%d\t%2.3f\n" , $1,$2,$3,$5}' \
# /bgfs/alee/LO_LAB/Personal/SanghoonLee/H46b_CutRun_HCC2185_TFAP2b_Abdalla/06_SEACR_v1.3/02a_SEACROutput_dupmarked/Smp1.relaxed.bed > \
# /bgfs/alee/LO_LAB/Personal/SanghoonLee/H46b_CutRun_HCC2185_TFAP2b_Abdalla/06_SEACR_v1.3/02a_SEACROutput_dupmarked/Smp1.relaxed.bedgraph \

# sort -k1,1 -k2,2n /bgfs/alee/LO_LAB/Personal/SanghoonLee/H46b_CutRun_HCC2185_TFAP2b_Abdalla/06_SEACR_v1.3/02a_SEACROutput_dupmarked/Smp1.relaxed.bedgraph > \
# /bgfs/alee/LO_LAB/Personal/SanghoonLee/H46b_CutRun_HCC2185_TFAP2b_Abdalla/06_SEACR_v1.3/02a_SEACROutput_dupmarked/Smp1.relaxedSorted.bedgraph \
 
# /bgfs/alee/LO_LAB/Personal/SanghoonLee/H46a_CutRun_MDAMb134_TFAP2b_Abdalla/11_SEACR_v1.3/02_SEACROutput/bedGraphToBigWig \
# /bgfs/alee/LO_LAB/Personal/SanghoonLee/H46b_CutRun_HCC2185_TFAP2b_Abdalla/06_SEACR_v1.3/02a_SEACROutput_dupmarked/Smp1.relaxedSorted.bedgraph \
# ChromosomeSize.txt /bgfs/alee/LO_LAB/Personal/SanghoonLee/H46b_CutRun_HCC2185_TFAP2b_Abdalla/06_SEACR_v1.3/02a_SEACROutput_dupmarked/Smp1.relaxedSorted.bw



date