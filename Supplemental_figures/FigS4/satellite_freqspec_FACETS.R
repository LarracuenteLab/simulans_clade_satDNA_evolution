library(ggplot2)
library(reshape2)
library(ggthemes)
library(RColorBrewer)
#install.packages("ggpubr")
library(ggpubr)
#install.packages("ggforce",dependencies=TRUE)
library(ggforce)

mauclusters <- read.table("dmau_X_repeat_clusters_v4.txt",sep="\t",header=T)
sechclusters <- read.table("dsech_X_repeat_clusters_v4.txt",sep="\t",header=T)
simclusters <- read.table("dsim_X_repeat_clusters_v4.txt",sep="\t",header=T)
melclusters <- read.table("dmel_X_repeat_clusters_v4.txt",sep="\t",header=T)

mau <-subset(mauclusters, Cluster=="1.688" | Cluster=="RSP-LIKE")
mau$spp <- as.factor("D. mau")
sech <-subset(sechclusters, Cluster=="1.688" | Cluster=="RSP-LIKE")
sech$spp <- as.factor("D. sech")
sim <-subset(simclusters, Cluster=="1.688" | Cluster=="RSP-LIKE")
sim$spp <- as.factor("D. sim")
mel <-subset(melclusters, Cluster=="1.688" | Cluster=="RSP-LIKE")
mel$spp <- as.factor("D. mel")

nrow(subset(sim, Cluster=="RSP-LIKE" & Repeats >= 25))

allspecies <- rbind(mau,sech,sim,mel)
allspecies$spp_f <- factor(allspecies$spp, levels=c("D. mau","D. sech","D. sim","D. mel"))

sizes <- c(mau$Repeats,sech$Repeats,sim$Repeats,mel$Repeats)
max(sizes)
#labs <- seq(by=5,from=0,to=max(sizes))

palette <-c("orange","dodgerblue")

p1 <- ggplot(data=allspecies, aes(allspecies$Repeats,fill=Cluster))+
  geom_histogram(binwidth=1)+
  scale_fill_manual(values=c(palette))+
  #theme(legend.title=element_blank())+
  #theme(panel.background = element_rect(fill="white"))+
  #theme(panel.grid.major =element_blank())+
  #theme(panel.grid.minor = element_blank())+
  theme_bw()+
  theme(strip.text = element_text(face="bold", size=14))+
  xlab("Cluster size")+
  ylab("Count")+
  scale_x_continuous(limits=c(0,150),breaks=seq(0,150,5),labels=seq(0,150,5))+
  #scale_x_continuous(limits=c(1,max(sizes)+1))+
  theme(axis.text.x = element_text(angle = 90,hjust=1,vjust=0.5))


p2 <- ggplot(data=allspecies, aes(x=allspecies$Cluster,y=allspecies$Repeats,fill=Cluster))+
  geom_boxplot(outlier.shape = NA)+
  geom_sina(maxwidth=0.70)+
  #geom_boxplot()+
  #geom_jitter(width = 0.2)+
  scale_fill_manual(values=c(palette))+
  #theme(legend.title=element_blank())+
  #theme(panel.background = element_rect(fill="white"))+
  #theme(panel.grid.major =element_blank())+
  #theme(panel.grid.minor = element_blank())+
  theme_bw()+
  theme(strip.text = element_text(face="bold", size=14))+
  xlab("")+
  ylab("Size of locus")+
  scale_y_log10(breaks=c(1,5,10,25,50,100),labels=c(1,5,10,25,50,100))+
  theme(axis.text.x = element_text(angle = 90,hjust=1,vjust=0.5,size=12))+
  theme(axis.text.y = element_text(size=12))+
  theme(legend.position = "none")

p2 + facet_grid(. ~ spp_f)

