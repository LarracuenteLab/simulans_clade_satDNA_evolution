library(ggplot2)
library(reshape2)
library(ggthemes)
library(RColorBrewer)
library(ggpubr)

mauclusters <- read.table("/Users/johnsproul/Dropbox/X_satellite_paper/Figures/New.coordinates/Figure_2_sat_distribution/AML/danis/dmau_X_repeat_clusters_v4.txt",sep="\t",header=T)
sechclusters <- read.table("/Users/johnsproul/Dropbox/X_satellite_paper/Figures/New.coordinates/Figure_2_sat_distribution/AML/danis/dsech_X_repeat_clusters_v4.txt",sep="\t",header=T)
simclusters <- read.table("/Users/johnsproul/Dropbox/X_satellite_paper/Figures/New.coordinates/Figure_2_sat_distribution/AML/danis/dsim_X_repeat_clusters_v4.txt",sep="\t",header=T)
melclusters <- read.table("/Users/johnsproul/Dropbox/X_satellite_paper/Figures/New.coordinates/Figure_2_sat_distribution/AML/danis/dmel_X_repeat_clusters_v4.txt",sep="\t",header=T)

mau <-subset(mauclusters, Cluster=="RSP-LIKE" | Cluster =="1.688")
mau$spp <- as.factor("D. mau")
sech <-subset(sechclusters, Cluster=="RSP-LIKE" | Cluster =="1.688")
sech$spp <- as.factor("D. sech")
sim <-subset(simclusters, Cluster=="RSP-LIKE" | Cluster =="1.688")
sim$spp <- as.factor("D. sim")
mel <-subset(melclusters, Cluster=="RSP-LIKE" | Cluster =="1.688")
mel$spp <- as.factor("D. mel")

palette <-c("orange","royalblue1")

#mau.m <- melt(mau,id.vars="Cyto_start")
#sech.m <- melt(sech,id.vars="Cyto_start")
#sim.m <- melt(sim,id.vars="Cyto_start")
#mel.m <- melt(mel,id.vars="Cyto_start")

allspecies <- rbind(mau,sech,sim,mel)

p <- ggplot(mel, aes(x=TransCoor, y = Repeats,fill=Cluster)) +
  geom_bar(stat='identity')+
  scale_fill_manual(values=c(palette))+
  #theme(legend.title=element_blank())+
  #theme(panel.background = element_rect(fill="white"))+
  #theme(panel.grid.major =element_blank())+
  #theme(panel.grid.minor = element_blank())+
  theme_bw()+
  theme(strip.text = element_text(face="bold", size=14))+
  #scale_y_continuous(limits=c(0,1),breaks=c(0.25,0.50,0.75,1))+
  theme(axis.text = element_text(colour ="black",size=14))+
  theme(axis.ticks = element_line(colour ="black"))+
  #xlim(labels=c(0,5,10,15,20,25),breaks=c(1,5e6,10e6,15e6,20e6,25e6))+
  xlim(1,24e6)+
  ylim(0,210)+
  #scale_x_continuous(labels=c(0,5,10,15,20,25),breaks=c(1,5e6,10e6,15e6,20e6,25e6))+
  #  ggtitle("Chr X")+
  xlab("Position (Mb)")+
  ylab("Count")


pdf("/Users/johnsproul/Dropbox/X_satellite_paper/Figures/New.coordinates/Figure_2_sat_distribution/AML/danis/X_satellite_distrib_jss.pdf",width=11,height=2.125)
p + facet_grid(spp ~ .)
dev.off()