

#obtain significant genes
library(BgeeDB)
human <- Bgee$new(species = "Homo_sapiens",dataType="rna_seq")

#load dataset
Homo_sapiens_TopAnatData_0000092 <- loadTopAnatData(human,stage= "UBERON:0000092")

#generate background gene list
file_name_background_0000092 <- read.table("/Volumes/lixiaoyi/_for_R/topAnat/mart_export_background.txt",blank.lines.skip=F, head = T, stringsAsFactors = FALSE,quote = "",sep ="\t")
i_dataframe_background_0000092 <- data.frame(file_name_background_0000092)
background_0000092 <- c(i_dataframe_background_0000092[,1])
background_0000092 <- unique(background_0000092)


#generate foreground gene list
file_name_foreground_0000092 <- read.table("/Volumes/lixiaoyi/_for_R/topAnat/mart_export_foreground.txt",blank.lines.skip=F, head =F, stringsAsFactors = FALSE,quote = "",sep ="\t")
i_dataframe_foreground_0000092 <- data.frame(file_name_foreground_0000092)
foreground_0000092 <- c(i_dataframe_foreground_0000092[,1])
foreground_0000092 <- unique(foreground_0000092)


#generate factor
geneList_0000092 <- factor(as.integer(background_0000092 %in% foreground_0000092))
names(geneList_0000092) <- unique(background_0000092)
summary(geneList_0000092)
#topAnat analysis
human_TopAnatObject_0000092 <-  topAnat(Homo_sapiens_TopAnatData_0000092, geneList_0000092,nodeSize = 20)
#classic
Homo_sapiens_results_0000092_classic <- runTest(human_TopAnatObject_0000092, algorithm = 'classic', statistic = 'fisher')
tableOver_0000092_classic <- makeTable(Homo_sapiens_TopAnatData_0000092, human_TopAnatObject_0000092, Homo_sapiens_results_0000092_classic, cutoff = 0.05)
write.table(tableOver_0000092_classic,file="/Volumes/lixiaoyi/_for_R/topAnat/topanat_result_genelist_fecel.xls",sep="\t",row.names=FALSE, quote=FALSE)

term <- "UBERON:0002661"
annotated <- genesInTerm(human_TopAnatObject_0000092, term)[["UBERON:0002661"]]
annotated[annotated %in% sigGenes(human_TopAnatObject_0000092)]
out <- annotated[annotated %in% sigGenes(human_TopAnatObject_0000092)]
write.table(out,file="~/result_using_stampy/gene_list/topanat/UBERON0002661.xls",sep="\t",row.names=FALSE, quote=FALSE)
