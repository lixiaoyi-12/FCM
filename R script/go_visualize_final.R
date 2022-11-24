#################################
# Plot gene ontology enrichment #
#################################

# Requires the package 'ggplot2' (needs to be installed first)
# Load the ggplot2 package
library(ggplot2)

# set the working directory where the tables to use are located
setwd("C:/Users/Peter/Documents/Bioprotocol GO enrichment plot/")

#############################################
# PART 1: plot the representative enriched
# GO terms in the list of all DEGs (Figure 2)
#############################################

# Prepare dataframe
#------------------
# Import the table containing the enriched GO terms
GO_bp <- read.table("/Volumes/lixiaoyi/_for_R/go_bp.txt",header=T,stringsAsFactors = T)
GO_bp$Gene_number <- as.numeric(GO_bp$Gene_number)
GO_bp$GO_biological_process <- chartr("_", " ", GO_bp$GO_biological_process)
GO_bp$'|log10(FDR)|' <- -(log10(GO_bp$FDR))

GO_mf <- read.table("/Volumes/lixiaoyi/_for_R/go_mf.txt",header=T,stringsAsFactors = T)
GO_mf$Gene_number <- as.numeric(GO_mf$Gene_number)
GO_mf$GO_molecular_function <- chartr("_", " ", GO_mf$GO_molecular_function)
GO_mf$'|log10(FDR)|' <- -(log10(GO_mf$FDR))

GO_cc <- read.table("/Volumes/lixiaoyi/_for_R/go_cc.txt",header=T,stringsAsFactors = T)
GO_cc$Gene_number <- as.numeric(GO_cc$Gene_number)
GO_cc$GO_cellular_component <- chartr("_", " ", GO_cc$GO_cellular_component)
GO_cc$'|log10(FDR)|' <- -(log10(GO_cc$FDR))

# Draw the plot with ggplot2 (Figure 2)
#--------------------------------------
ggplot(GO_bp, aes(x = GO_biological_process, y = Fold_enrichment)) +
  geom_hline(yintercept = 1, linetype="dashed", 
             color = "azure4", size=.5)+
  geom_point(data=GO_bp,aes(x=GO_biological_process, y=Fold_enrichment,size = Gene_number, colour = `|log10(FDR)|`), alpha=.7)+
  scale_x_discrete(limits= GO_bp$GO_biological_process)+
  scale_color_gradient(low="green",high="red",limits=c(0, NA))+
  coord_flip()+
  theme_bw()+
  theme(axis.ticks.length=unit(-0.1, "cm"),
        axis.text.x = element_text(margin=margin(5,5,0,5,"pt"),face="bold"),
        axis.text.y = element_text(margin=margin(5,5,5,5,"pt"),face="bold"),
        axis.text = element_text(color = "black",face="bold"),
        panel.grid.minor = element_blank(),
        legend.title.align=0.5)+
  xlab("GO biological processes")+
  ylab("Fold enrichment")+
  labs(color="-log10(FDR)", size="Number\nof genes")+ #Replace by your variable names; \n allow a new line for text
  guides(y = guide_axis(order=2),
         colour = guide_colourbar(order=1))


#######################################################
# PART 2: plot the representative GO terms by condition
# or list of DEGs and compare the enrichment with 
# 3 type of plot (Figures 3, 4, 5)
##########################################

# Prepare dataframe
#------------------
# Import the table containing the enriched GO terms by groups
GO_gp <- read.table("Supplementary Data 4.txt",header=T,stringsAsFactors = T)

# List objects and their structure contained in the dataframe 'GO_gp'
ls.str(GO_gp)

# Transform the column 'Gene_number' into a numeric variable
GO_gp$Gene_number <- as.numeric(GO_gp$Gene_number)

# Replace all the "_" by a space in the column containing the GO terms
GO_gp$GO_biological_process <- chartr("_", " ", GO_gp$GO_biological_process)

# Transform the column 'GO_biological_process' into factors
GO_gp$GO_biological_process<-as.factor(GO_gp$GO_biological_process)

# Transform FDR values by -log10('FDR values')
GO_gp$'|log10(FDR)|' <- -(log10(GO_gp$FDR))

# Change factor order
GO_gp$Group<- factor(GO_gp$Group,levels = c("WT_up","WT_down","mutant_up","mutant_down"))
GO_gp$GO_biological_process<-factor(GO_gp$GO_biological_process,levels=rev(levels(GO_gp$GO_biological_process)))

# Create a vector with new names for groups to use in the plot
# Replace the terms by your own (\n allow to start a new line)
group.labs <- c(`WT_up` = "WT up-\nregulated",
                `WT_down` = "WT down-\nregulated",
                `mutant_up` = "Mutant up-\nregulated",
                `mutant_down` = "Mutant down-\nregulated")

# Draw the plot in facets by group with ggplot2
# to represent -log10(FDR), Number of genes and 
# Fold enrichment of each GO biological process per group (Figure 3)
#-------------------------------------------------------------------
ggplot(GO_gp, aes(x = GO_biological_process, y = Fold_enrichment)) +
  geom_hline(yintercept = 1, linetype="dashed", 
             color = "azure4", size=.5)+
  geom_point(data=GO_gp,aes(x=GO_biological_process, y=Fold_enrichment,size = Gene_number, colour = `|log10(FDR)|`), alpha=.7)+
  scale_color_gradient(low="green",high="red",limits=c(0, NA))+
  coord_flip()+
  theme_bw()+
  theme(axis.ticks.length=unit(-0.1, "cm"),
        axis.text.x = element_text(margin=margin(5,5,0,5,"pt")),
        axis.text.y = element_text(margin=margin(5,5,5,5,"pt")),
        axis.text = element_text(color = "black"),
        panel.grid.minor = element_blank(),
        legend.title.align=0.5)+
  xlab("GO biological processes")+
  ylab("Fold enrichment")+
  labs(color="-log10(FDR)", size="Number\nof genes")+
  facet_wrap(~Group,ncol=4,labeller=as_labeller(group.labs))+#after "ncol=", specify the number of groups you have
  guides(y = guide_legend(order=2),
         colour = guide_colourbar(order=1))


# Draw the plot with ggplot2
# to represent -log10(FDR) and Number of genes 
# of each GO biological process per group (Figure 4)
#---------------------------------------------------
ggplot(GO_gp, aes(x = GO_biological_process, y = Group)) +
  geom_point(data=GO_gp,aes(x=GO_biological_process, y=Group,size = Gene_number, colour = `|log10(FDR)|`), alpha=.7)+
  scale_y_discrete(labels =group.labs)+
  scale_color_gradient(low = "green", high = "red", limits=c(0, NA))+
  coord_flip()+
  theme_bw()+
  theme(axis.ticks.length=unit(-0.1, "cm"),
        axis.text.x = element_text(margin=margin(5,5,0,5,"pt"),angle = 45, hjust = 1),
        axis.text.y = element_text(margin=margin(5,5,5,5,"pt")),
        axis.text = element_text(color = "black"),
        axis.title.x=element_blank())+
  xlab("GO biological processes")+
  labs(color="-log10(FDR)", size="Number\nof genes")


# To represent -log10(FDR) values per group in a heatmap (Figure 5),
# prepare a new dataframe with data for each biological process for each group
#-----------------------------------------------------------------------------
#List all the different GO biological process among groups
list_biol_process<-levels(factor(GO_gp$GO_biological_process)) 

#Get the number of different biological processes   
len<-length(list_biol_process)

#List the different group names in a dataframe
df<-as.data.frame(c("WT_up","WT_down","mutant_up","mutant_down")) 

#Replicate the group names by the number of biological processes
df<-as.data.frame(df[rep(seq_len(nrow(df)), each=len),]) 

#In a second column, add the different biological processes for each group
df[,2]<-list_biol_process 

#Rename columns with the same name that in GO_gp for corresponding columns
colnames(df) <- c("Group","GO_biological_process")

#Merge df and GO_gp, adding NAs when no data present in GO_gp1
GO_gp1<-merge(data.frame(df, row.names=NULL), data.frame(GO_gp, row.names=NULL), 
              by.x=c("Group","GO_biological_process"), by.y=c("Group","GO_biological_process"), all = TRUE)

#Rename all colums
colnames(GO_gp1) <- c("Group","GO_biological_process","Gene_number","Fold_enrichment","FDR","|log10(FDR)|")

# Transform some columns into factors, and order factors
GO_gp1$GO_biological_process<-as.factor(GO_gp1$GO_biological_process)
GO_gp1$GO_biological_process<-factor(GO_gp1$GO_biological_process,levels=rev(levels(GO_gp1$GO_biological_process)))
GO_gp1$Group<- factor(GO_gp1$Group,levels = c("WT_up","WT_down","mutant_up","mutant_down"))

#add a column with logical values depending on the presence or absence of NA in corresponding row
GO_gp1$na <- is.na(GO_gp1$Gene_number)

# Plot the heatmap (Figure 5) - for NAs, a cross is drawn in cells
# thus you should get a warning message with a number
# corresponding to missing cross in cells where -log10(FDR) is plotted
#---------------------------------------------------------------------
ggplot(GO_gp1, aes(x=GO_biological_process,y=Group,fill=`|log10(FDR)|`))+ 
  geom_tile(color = "black")+
  scale_y_discrete(labels =group.labs)+
  scale_fill_gradient2(low = "navyblue", high = "red", mid = "white",
                       midpoint = 1, na.value = "white", limits=c(0, NA))+
  theme_minimal()+
  theme(axis.text = element_text(size=10, colour="black"),
        axis.text.x = element_text(angle = 45, hjust = 1),
        panel.grid.major = element_blank(),
        axis.title.x=element_blank(),
        plot.background = element_rect(fill="white",colour="white"))+
  xlab("GO biological processes")+
  labs(fill="-log10(FDR)")+
  coord_flip()+
  geom_point(shape=4,colour="grey40",aes(size=ifelse(na, "dot", "no_dot")),show.legend =T)+
  scale_size_manual(values=c(dot=2, no_dot=NA), guide="none")
