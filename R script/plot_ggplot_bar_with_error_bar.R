library(ggplot2)
data<-data.frame(group=c("1281","347","100","control"),mean=c(1.72,1.19,2.78,2.35),sd=c(0.17,0.08,0.24,0.16))
ggplot(data,aes(x=group,y=mean))+geom_bar(stat='identity',fill="gray",color="black",width=0.7)+geom_errorbar(aes(ymin=mean-sd,ymax=mean+sd),width=.2,color="black")+labs(title="none",x="relative value",y="mean value")+theme_classic()+scale_y_continuous(expand = c(0,0),limits = c(0, 4))
