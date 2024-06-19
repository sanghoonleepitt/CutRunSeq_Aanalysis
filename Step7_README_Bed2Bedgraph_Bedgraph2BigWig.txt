################################## ################################## ################################## 
### How to make a BigWig track from a bedgraph file, 
https://genome.ucsc.edu/goldenPath/help/bigWig.html#:~:text=Alternatively%2C%20bigWig%20files%20can%20be,to%20the%20Genome%20Browser%20server.

Example 3. 

To create a bigWig track from a bedGraph file, follow these steps:

Create a bedGraph format file following the directions here. When converting a bedGraph file to a bigWig file, you are limited to one track of data in your input file; therefore, you must create a separate bedGraph file for each data track.
Remove any existing track or browser lines from your bedGraph file so that it contains only data.
Download the bedGraphToBigWig program from the binary utilities directory.
Use the fetchChromSizes script from the same directory to create the chrom.sizes file for the UCSC database with which you are working (e.g., hg19). If the assembly genNom is hosted by UCSC, chrom.sizes can be a URL like http://hgdownload.soe.ucsc.edu/goldenPath/genNom/bigZips/genNom.chrom.sizes
Use the bedGraphToBigWig utility to create a bigWig file from your bedGraph file:

bedGraphToBigWig in.bedGraph chrom.sizes myBigWig.bw

(Note that the bedGraphToBigWig program DOES NOT accept gzipped bedGraph input files.)
Move the newly created bigWig file (myBigWig.bw) to a web-accessible http, https, or ftp location.
Paste the URL into the custom track entry form or construct a custom track using a single track line.
Paste the custom track line into the text box on the custom tra
################################## ################################## ################################## 

https://www.biostars.org/p/150036/

awk '{printf "%s\t%d\t%d\t%2.3f\n" , $1,$2,$3,$5}' myBed.bed > myFile.bedgraph
In case the BED file was not sorted properly:

sort -k1,1 -k2,2n myFile.bedgraph > myFile_sorted.bedgraph
Finally, use the UCSC bedGraphToBigWig tool:

bedGraphToBigWig myFile_sorted.bedgraph myChrom.sizes myBigWig.bw  # download "bedGraphToBigWig" at https://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/


How to get chrom size file: 
samtools faidx genome.fasta 
cut -f1,2 genome.fasta.fai > genome.size




awk '{printf "%s\t%d\t%d\t%2.3f\n" , $1,$2,$3,$5}' OESTERREICH_1_SEACROutRelax.relaxed.bed > OESTERREICH_1_SEACROutRelax.bedgraph
sort -k1,1 -k2,2n OESTERREICH_1_SEACROutRelax.bedgraph > OESTERREICH_1_SEACROutRelaxSorted.bedgraph
./bedGraphToBigWig OESTERREICH_1_SEACROutRelaxSorted.bedgraph ChromosomeSize.txt OESTERREICH_1_SEACRRelax.bw


awk '{printf "%s\t%d\t%d\t%2.3f\n" , $1,$2,$3,$5}' OESTERREICH_2_SEACROutRelax.relaxed.bed > OESTERREICH_2_SEACROutRelax.bedgraph
sort -k1,1 -k2,2n OESTERREICH_2_SEACROutRelax.bedgraph > OESTERREICH_2_SEACROutRelaxSorted.bedgraph
./bedGraphToBigWig OESTERREICH_2_SEACROutRelaxSorted.bedgraph ChromosomeSize.txt OESTERREICH_2_SEACRRelax.bw



awk '{printf "%s\t%d\t%d\t%2.3f\n" , $1,$2,$3,$5}' OESTERREICH_3_SEACROutRelax.relaxed.bed > OESTERREICH_3_SEACROutRelax.bedgraph
sort -k1,1 -k2,2n OESTERREICH_3_SEACROutRelax.bedgraph > OESTERREICH_3_SEACROutRelaxSorted.bedgraph
./bedGraphToBigWig OESTERREICH_3_SEACROutRelaxSorted.bedgraph ChromosomeSize.txt OESTERREICH_3_SEACRRelax.bw


################################## ################################## ################################## 
## Let's try to make a BigWig file from bedgraph file without sorting.  This works.  But, let's not use the bigwig file for now. 

/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46a_CutRun_MDAMb134_TFAP2b_Abdalla/11_SEACR_v1.3/02_SEACROutput/bedGraphToBigWig \
/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46b_CutRun_HCC2185_TFAP2b_Abdalla/06_SEACR_v1.3/01a_BedgraphOutput_dupmarked/Smp1.fragments.bedgraph \
/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46a_CutRun_MDAMb134_TFAP2b_Abdalla/11_SEACR_v1.3/02_SEACROutput/ChromosomeSize.txt \
/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46b_CutRun_HCC2185_TFAP2b_Abdalla/06_SEACR_v1.3/01a_BedgraphOutput_dupmarked/Smp1.fragments.bw \

################################## ################################## ################################## 
################################## ################################## ################################## 
### From SEACR output .bed files, 1) Make bedgraph file, 2) sort the bedgraph file, and 3) make bigwig fril. 

awk '{printf "%s\t%d\t%d\t%2.3f\n" , $1,$2,$3,$5}' \
/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46b_CutRun_HCC2185_TFAP2b_Abdalla/06_SEACR_v1.3/02a_SEACROutput_dupmarked/Smp1.relaxed.bed > \
/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46b_CutRun_HCC2185_TFAP2b_Abdalla/06_SEACR_v1.3/02a_SEACROutput_dupmarked/Smp1.relaxed.bedgraph \

sort -k1,1 -k2,2n /bgfs/alee/LO_LAB/Personal/SanghoonLee/H46b_CutRun_HCC2185_TFAP2b_Abdalla/06_SEACR_v1.3/02a_SEACROutput_dupmarked/Smp1.relaxed.bedgraph > \
/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46b_CutRun_HCC2185_TFAP2b_Abdalla/06_SEACR_v1.3/02a_SEACROutput_dupmarked/Smp1.relaxedSorted.bedgraph \

/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46a_CutRun_MDAMb134_TFAP2b_Abdalla/11_SEACR_v1.3/02_SEACROutput/bedGraphToBigWig \
/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46b_CutRun_HCC2185_TFAP2b_Abdalla/06_SEACR_v1.3/02a_SEACROutput_dupmarked/Smp1.relaxedSorted.bedgraph \
 ChromosomeSize.txt /bgfs/alee/LO_LAB/Personal/SanghoonLee/H46b_CutRun_HCC2185_TFAP2b_Abdalla/06_SEACR_v1.3/02a_SEACROutput_dupmarked/Smp1.relaxedSorted.bw




