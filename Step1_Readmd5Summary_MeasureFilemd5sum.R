library(data.table)
library(dplyr)
################################################################################
setwd("/bgfs/alee/LO_LAB/Personal/SanghoonLee/H46c_CutRunPeakcallingInstruction")

FastqDir <- "/bgfs/alee/LO_LAB/General/Lab_Data/20231012_LeeCHP5_Abdalla_M134M453_CutRunSeq"
MD5SumFile <- "/bgfs/alee/LO_LAB/General/Lab_Data/20231012_LeeCHP5_Abdalla_M134M453_CutRunSeq/md5_report.txt"
OutFileName <- "/bgfs/alee/LO_LAB/General/Lab_Data/20231012_LeeCHP5_Abdalla_M134M453_CutRunSeq/MD5Summary_TFAP2bCutRun_Abdalla.txt"
################################################################################
cat(paste("FileName","FileNameProvided","md5sumProvided","md5sumMeasured","md5sumComparison",sep="\t"),file=OutFileName,sep="\n",append = TRUE) 

################################################################################
# MD5sumData<-read.table(MD5SumFile,sep='\t',stringsAsFactors=F,check.names=F,header=FALSE)
MD5sumData<-fread(MD5SumFile,stringsAsFactors=FALSE,header=FALSE) %>% data.frame; head(MD5sumData)
colnames(MD5sumData) <- c("MD5sumData", "FileName"); MD5sumData[1:2,]
#				MD5sumData                     FileName
# [1] "54f4c252255ab357f0e53a4ce13ca50e  01.RawData/OVC3_2DN1_2.fq.gz"
# [2] "51684532366253719f251882e4ef6faa  01.RawData/OVC3_2DN2_1.fq.gz"

############################################################################
###  Step2. Measure MD5sum in each bam file. 
############################################################################

FastqFileAll <-list.files(path=FastqDir , full=TRUE); LoopNumb<-0;  FastqFileAll[1:2]
# [1] "./1_RawData/O433_2DN1_1.fq.gz"    "./1_RawData/O433_2DN1_2.fq.gz"
# [3] "./1_RawData/O433_2DN2_1.fq.gz"    "./1_RawData/O433_2DN2_2.fq.gz"

for (EachFile in FastqFileAll) {
	# EachFile  <- FastqFileAll[1]; print(paste0("Each filename: ", EachFile)) # "./1_RawData/O433_2DN1_1.fq.gz"
	md5sumMeasured<-system(paste("md5sum", EachFile , sep=" "),intern=TRUE)
   	md5sumMeasuredUnlist<-unlist(strsplit(md5sumMeasured,' '))[1]; print(md5sumMeasuredUnlist)  #  "85daa3b959a33aa433c207d17cad9296"

	## find file name provided by each FastqFile
	FastqFileName <- gsub("(.*)\\/", "", EachFile); print(FastqFileName )

	if(any(grepl(FastqFileName, MD5sumData$FileName))) {
		FileNameProvided<-MD5sumData[grep(FastqFileName, MD5sumData$FileName), 2]; print(FileNameProvided)
		## find provided md5sum by a file name
		md5sumProvided <- MD5sumData[grep(FastqFileName, MD5sumData$FileName), 1]; print(md5sumProvided)
		## compare the md5sumMeasured and md5sumProvided
		ComparisonResult<-ifelse(md5sumMeasuredUnlist==md5sumProvided, 'MD5sumSame', 'Wrong')
	} else {
		FileNameProvided<- "MD5SumNotExist"; 
		md5sumProvided <- "NotAvail"
		ComparisonResult<- "NotAvail"; 
	}
	print(paste0("Comparison Result: ", ComparisonResult))

	cat(paste(FastqFileName , FileNameProvided, md5sumProvided,md5sumMeasuredUnlist, ComparisonResult,sep="\t"),file=OutFileName,sep="\n",append = TRUE) 

	LoopNumb<-LoopNumb+1;
	print(paste0("current loopNumb: ", LoopNumb))
}



