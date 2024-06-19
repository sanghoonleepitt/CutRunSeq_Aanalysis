# CutAndRunSeqAnalysis

---
title: "CutRunPeakCallingInstruction"
author: "Sanghoon Lee"
format: html
editor: visual
---

<!--# -   Quarto markdown basic: https://quarto.org/docs/authoring/markdown-basics.html -->
-   Cut&Run-seq information: https://www.epicypher.com/resources/blog/cut-and-run-vs-cut-and-tag-which-one-is-right-for-you/

# Cut&Run-seq Peak Calling Instruction

CUT&RUN, Cleavage Under Target & Release Using Nuclease

-   Every code file is stored at this Github repository.
-   PPT file I presented in the lab meeting on March 6th, 2024 is stored at this Github repository; "Summary_CutRunSeq_v2.1_20240306_SECRE.pptx"
-   Instruction, how to use IGV, pdf file is stored at this Github repository: "Instruction_HowToUseIGV_v1.0_20240130.pdf"

The lab meeting presentation PPTx and IGV instruction pdf files are stored at\
*/A.V. Lee Lab/Lee-Oesterreich Lab/Lee-Oesterreich General Lab Items/Bioinformatics_Basics_And_Scripts/10_CutRunSeq*

<!--![](FirstSlide_CutRunSeq.png)-->  
<!--# Just paste a screenshot here from a clipboard. Then, the address below is generated automatically. -->
![image](https://github.com/sanghoonleepitt/CutRunSeq_Aanalysis/assets/106251438/8aeb6e49-5922-4c52-9c09-b873a5b8e963)


#### CUT&RUN-seq data analysis procedure

-   Step1. Download fastq.gz files and measure md5sum
-   Step2. Trimming
-   Stpe3. Alignment to a reference genome
-   Step4. Sorting and marking duplicate reads in .bam
-   Step5. Convert .bam to .bedgraph
-   Step6. Peak calling (MACS2 or SEACR) and get .bed files
-   Step7. Conver SEACR output .bed to .bedgraph =\> sort .bedgraph =\> make .bigwig file
-   Step8. IGV visualization

#### Cut&Run-seq data storage in *CRC*

**Pilot cut&Run-seq experiment data on MDA-Mb-134 and MDA-Mb-453 cell lines.**

*/bgfs/alee/LO_LAB/General/Lab_Data/20231012_LeeCHP5_Abdalla_M134M453_CutRunSeq*

|         |  CellLine  |      Subtype       | ChromatinAssociatedProtein | ExperimentType.  |
|:-------------:|:-------------:|:-------------:|:-------------:|:-------------:|
| Sample1 | MDA-Mb-134 |   ER+/HER2-,ILC    |     Antibody for AP2β      |    Experiment    |
| Sample2 | MDA-Mb-453 | ER-/HER2+,ILC-like |     Antibody for AP2β      |    Experiment    |
| Sample3 | MDA-Mb-453 | ER-/HER2+,ILC-like |    Antibody for H3K4ME3    | Positive Control |
| Sample4 | MDA-Mb-453 | ER-/HER2+,ILC-like |         Rabbit IgG         | Negative Control |

**New cut&Run-seq experiment data on HCC2185 and BCK4 cell lines.**

*/bgfs/alee/LO_LAB/General/Lab_Data/20240604_HSSC4_Abdalla_AP2bHCC2185_CutRun*

Raw fastq.gz file download was done and md5sum measurement was done. You can check "MD5Summary_TFAP2bHCC2185_CutRun_Abdalla.txt" file in the folder.

1.  HCC2185 1 AP2B antibody repeat 1
2.  HCC2185 2 AP2B antibody repeat 2
3.  HCC2185 3 AP2B antibody repeat 3
4.  HCC2185 1 IgG antibody repeat 1
5.  HCC2185 2 IgG antibody repeat 2
6.  HCC2185 3 IgG antibody repeat 3
7.  BCK4 1 AP2B antibody repeat 1
8.  BCK4 2 AP2B antibody repeat 2
9.  BCK4 3 AP2B antibody repeat 3
10. BCK4 1 IgG antibody repeat 1
11. BCK4 2 IgG antibody repeat 2\
    ~~12. BCK4 3 IgG antibody repeat 3~~ \# missing
12. BCK4 3 H3K4ME3 (for positive control)

## Step1. Measure md5sum for the downloaded files.

md5sum is used to verify the integrity of files, as virtually any change to a file will cause its MD5 hash to change. Most commonly, md5sum is used to verify that a file has not changed as a result of a faulty file transfer, a disk error or non-malicious meddling.

-   **Step1_Readmd5Summary_MeasureFilemd5sum.R**

You can use this R code or write your own code. After running this code, you will get "MD5Summary_TFAP2bCutRun_Abdalla.txt" output file which summarizes the md5sum measurement and comparison with the md5sum values given by the sequencing core. The output file is already stored at */bgfs/alee/LO_LAB/General/Lab_Data/20231012_LeeCHP5_Abdalla_M134M453_CutRunSeq*

<!-- ![Figure 1. Aligned .bam file from the trimmed .fastq.gz files for Sample 1](Fig1_Summary_md5sum.png) -->
![image](https://github.com/sanghoonleepitt/CutRunSeq_Aanalysis/assets/106251438/b9038a94-94e2-4e95-a317-76ccccd9d893)

Figure 1. Aligned .bam file from the trimmed .fastq.gz files for Sample 1

## Step2. Trimming

Trimmomatic is a flexible read trimming tool for Illumina NGS data

Two files you need

-   **Step1_FindFastqFile_RunSlurm_Trimmomatic.pl**
-   **Slurm_Step1_trimmomaticV0.39_CRC.sl**

This perl code is to run for loop for each sample fastq files and submit slurm job for Trimmomatic This slurm script is to submit Trimmomatic job. You will get trimmed .fastq.gz files at `../04_TrimmomaticOut_CutRun_4smp`

<!-- ![Figure 2. Aligned .bam file from the trimmed .fastq.gz files for Sample 1](Fig2_TrimmedFastqgzFile.png) -->
![image](https://github.com/sanghoonleepitt/CutRunSeq_Aanalysis/assets/106251438/4d35b586-12b0-4c53-a239-3c356e16ce20)

Figure 2. Aligned .bam file from the trimmed .fastq.gz files for Sample 1

## Step3. Bowtie alignment to a reference genome

Trimmomatic is a flexible read trimming tool for Illumina NGS data

Two files you need

-   **Step3_Perl_ReadTrimmomaticFASTQ_Alignment.pl**
-   **Slurm_Step3_Integrated_Bowtie_SHmodified.sl**

This perl code is to run for loop for each sample trimmed fastq files and submit slurm job for Bowtie alignment. Before running Bowtie alignment, you should prefare reference genome in advance. NDA-Mb-134 is human cell line. You need to download human reference genome fasta files fron NCBI or Gencode. I recommend using hg39. Then, you need to make bowtie index files and set the directory of reference genome in your slurm script.

The alignment will be stored at an output directory you directed in your perl code, for example, `../05_CutRunTools_Output_4smp/OESTERREICH_1_S1/aligned.aug10/`

<!-- ![Figure 3. Aligned .bam file from the trimmed .fastq.gz files for Sample 1](Fig3_AlignedBamFile.png) -->
![image](https://github.com/sanghoonleepitt/CutRunSeq_Aanalysis/assets/106251438/ed00a568-3839-4cb9-90ab-dc98b0b52d58)

Figure 3. Aligned .bam file from the trimmed .fastq.gz files for Sample 1

## Step4. Samtools for sorting and duplicate marking for your .bam file.

Samtools allows you to manipulate the .bam files - they can be converted into a non-binary format (SAM format specification here) and can also be ordered and sorted based on the quality of the alignment. Duplicate reads lead to an over-representation of sequence data at the location of those reads. Duplicate marking indicates that the duplicate reads should not be used for analysis. As an alternative, duplicates can be removed.

Two files you need

-   **Step4_Perl_ReadBAM_SortDupMarkingBam.pl**
-   **Slurm_Step4_integrated_SortDupMarkingBam.sl**

When you finish this step, you will get multiple output folders and each folder has sorted or duplicate marking .bam files + bam index (.bai) files. For example, you will get a duplicate-deleted .bam file at `../05_CutRunTools_Output_4smp/OESTERREICH_1_S1/aligned.aug10/dedup/`

<!-- ![Figure 4. Sorted and duplicate read deleted .bam files](Fig4_SortedDupMarkedBAM.png) -->
![image](https://github.com/sanghoonleepitt/CutRunSeq_Aanalysis/assets/106251438/cc7e53e4-7bce-471b-8c17-75fd8938a22d)

Figure 4. Sorted and duplicate read deleted .bam files

## Step5. Convert .bam files to .bedgraph files.

BedGraph is a file format that allows display of continuous-valued data in a track in genome browsers that support the format. "bedtools genomecov" computes histograms (default), per-base reports (-d) and BEDGRAPH (-bg) summaries of feature coverage (e.g., aligned sequences) for a given genome.

Two files you need

-   **Step5_Perl_ReadBAM_ConvertToBedgraphDirectly_Bedtools.pl**
-   **Slurm_Step5_bedtools_Bam2BedgraphDirectly.sl**

In the Perl file, you can direct output directory. For example, I directed "/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46c_CutRunPeakcallingInstruction/*06_SEACR_v1.3/01a_BedgraphOutput_dupdeleted*" as an output directory. My Perl will make the directories, `"/06_SEACR_v1.3"` and `"/06_SEACR_v1.3/01a_BedgraphOutput_dupdeleted"`, automatically. When you finish this step, you will get .bedgraph output files at the output directory you directed.

<!-- ![Figure 5. .bedgraph files from .bam files](Fig5_Bam2BedGraph.png) -->
![image](https://github.com/sanghoonleepitt/CutRunSeq_Aanalysis/assets/106251438/4646d7c5-f750-4109-b361-cb0761a0ddf5)

Figure 5. .bedgraph files from .bam files

## Step6. Run *S*parse *E*nrichment *A*nalysis for *C*UT&*R*UN (SEACR) to get peaking calling .bed files.

SEACR is intended to call peaks and enriched regions from sparse CUT&RUN or chromatin profiling data in which background is dominated by "zeroes" (i.e. regions with no read coverage). `.bedgraph` files are SEACR's input files. SEACR will generate peak calling output files, which are .bed format. SEACR requires R and Bedtools. If you open the slurm script, you can see it loads R and Bedtools.

Two files you need

-   **Step6_Perl_ReadBedgraph_RunSEACR.pl**
-   **Slurm_Step6_SEACR_bedgraph2bed.sl**

[Be careful.]{style="color:red;"} SEACR requires two input files; one is experimental Cut&Run-seq sample's bedgraph file; the other is *negative control* Cut&Run-seq sample's .bedgraph file. As you see the Perl code line 12 and 13, you should assign two .bedgraph files.

> my \$BedgraphFile = \$BedgraphPath."/OESTERREICH_1.fragments.bedgraph";

\# first input file is a bedgraph file of experimental sample in Cut&Run-seq

> my \$BackgroundSmp = \$BedgraphPath="/OESTERREICH_4.fragments.bedgraph";

\# second input file is a bedgraph file of negative control in Cut&Run-seq

In the slurm script, **"Slurm_Step6_SEACR_bedgraph2bed.sl"**, it requires ["SEACR_1.3.sh"]{style="color:red;"} This file is stored at Github too. By the way, this .shell file requires "SEACR_1.3.R" file. This file is also stored at Github too.

In the Perl file, you can direct output directory. For example, I directed "/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46b_CutRun_HCC2185_TFAP2b_Abdalla/06_SEACR_v1.3/*02a_SEACROutput_dupdeleted*" as an output directory. My Perl will make the directories, `"/02a_SEACROutput_dupdeleted"`, automatically. When you finish this step, you will get *.bed* output files at the output directory you directed.

<!--  ![Figure 6. SEACR peak calling to get .bed files from .bedgraph](Fig6_SEACROut_BedFile.png)  -->
![image](https://github.com/sanghoonleepitt/CutRunSeq_Aanalysis/assets/106251438/a0444017-41e6-4d56-a26c-89727aa49328)

Figure 6. SEACR peak calling to get .bed files from .bedgraph

## Step7. Convert SEACR .bed =\> .bedgraph =\> Sort .bedgraph =\> convert the sorted.bedgraph to .bigwig file.

The Integrative Genomics Viewer (IGV) is a high-performance, easy-to-use, interactive tool for the visual exploration of genomic data. It requires .bigwig file as an input file. More detailed explanation of Stpe7 is written in **"Step7_README_Bed2Bedgraph_Bedgraph2BigWig.txt"**

Two files you need

-   **Step7_Perl_BedgraphToBigWig_ReadBedgraphSort_MakeBigWig.pl**
-   **Slurm_Step7_BedgraphSortToBigWig.sl**

Once you direct the folder that has SEACR .bed files, the slurm script will 1) conver .bed to .bedgraph, 2) sort the .bedgraph, and 3) convert .bedgraph to .bigwig file. This .bigwig file is used as an input file for IGV.

<!-- ![Figure 7. Making .bigwig file from SEACR output](Fig7_MakeBigWigFromSEACRout.png)  -->
![image](https://github.com/sanghoonleepitt/CutRunSeq_Aanalysis/assets/106251438/d876d63e-8a2c-4186-a814-5be1edb4ae79)

Figure 7. Making .bigwig file from SEACR output

## Step8. IGV

How to use IGV: refer to "Instruction_HowToUseIGV_v1.0_20240130.pdf" at Pitt OneDrive,\
*/A.V. Lee Lab/Lee-Oesterreich Lab/Lee-Oesterreich General Lab Items/Bioinformatics_Basics_And_Scripts/10_CutRunSeq*

![image](https://github.com/sanghoonleepitt/CutRunSeq_Aanalysis/assets/106251438/fa2cf684-9c0b-440a-b785-644bee0a5f59)

Figure 8. IGV screenshot, after group autoscaling

**The end.**
