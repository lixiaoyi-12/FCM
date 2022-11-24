scores<-read.table("~/scores.txt")
names(scores)<-c('type','scores')
scores_plot<-ggplot(scores, aes(x=scores, fill=type)) + geom_histogram(binwidth=0.05, alpha=.5, position="identity")+labs(x="PhastCons Scores", y = "Count")+theme(plot.title = element_text(hjust = 0.5,face = "bold"))+theme_bw()+labs(x="PhastCons Scores", y = "Count")+scale_fill_manual(values = c("#f8766D","#00BFC4"))
axis_theme1<-theme(axis.title=element_text(face="bold",color="black",size=15),axis.text=element_text(colour="black",size=12,face="bold"))
nsuce_scores_plot_all<-nuce_scores_plot+axis_theme1+legend_theme1

#transparent
ggplot(scores, aes(x=scores, fill=type)) + geom_histogram(binwidth=0.02,  position="identity",aes(alpha=type))+labs(x="PhastCons Scores", y = "Count")+theme(plot.title = element_text(hjust = 0.5,face = "bold"))+theme_bw()+labs(x="PhastCons Scores", y = "Count")+scale_fill_manual(values=c("#878788","#719960","#E2E1E1"))+scale_alpha_manual(name = "type", values = c(.8, 0.999, .4))
