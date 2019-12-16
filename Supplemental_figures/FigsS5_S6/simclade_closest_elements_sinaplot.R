library(ggplot2)
library(reshape2)
library(ggthemes)
library(RColorBrewer)
#install.packages("ggpubr")
library(ggpubr)
#install.packages("ggforce",dependencies=TRUE)
library(ggforce)


mauclusters <- read.table("~/Desktop/larracuente/sim_clade/0413/final.NR/dmau_X_repeat_clusters_genes.txt",sep="\t",header=T,stringsAsFactors = FALSE)
sechclusters <- read.table("~/Desktop/larracuente/sim_clade/0413/final.NR/dsech_X_repeat_clusters_genes.txt",sep="\t",header=T,stringsAsFactors = FALSE)
simclusters <- read.table("~/Desktop/larracuente/sim_clade/0413/final.NR/dsim_X_repeat_clusters_genes.txt",sep="\t",header=T,stringsAsFactors = FALSE)
melclusters <- read.table("~/Desktop/larracuente/sim_clade/0413/final.NR/dmel_X_repeat_clusters_genes.txt",sep="\t",header=T)


#Change this as needed, 1.688 or RSP-LIKE
mau <-subset(mauclusters, Cluster=="RSP-LIKE")
mau$species <- factor("D. mau")
sech <-subset(sechclusters, Cluster=="RSP-LIKE")
sech$species <- factor("D. sech")
sim <-subset(simclusters, Cluster=="RSP-LIKE")
sim$species <- factor("D. sim")
mel <-subset(melclusters, Cluster=="RSP-LIKE")
mel$species <- factor("D. mel")

mau$Dist.upstream[mau$Dist.upstream <= 0] <- 1
mau$Dist.downstream[mau$Dist.downstream <= 0] <- 1
sech$Dist.upstream[sech$Dist.upstream <= 0] <- 1
sech$Dist.downstream[sech$Dist.downstream <= 0] <- 1
sim$Dist.upstream[sim$Dist.upstream <= 0] <- 1
sim$Dist.downstream[sim$Dist.downstream <= 0] <- 1
mel$Dist.upstream[mel$Dist.upstream <= 0] <- 1
mel$Dist.downstream[mel$Dist.downstream <= 0] <- 1

#Calculate how many clusters directly adjacent to 1.688 (either up or downstream). Relevant for Rsp
nrow(subset(mau, (mau$Closest.upstream=="1.688" | mau$Closest.downstream=="1.688") & (mau$Dist.upstream <= 100 | mau$Dist.downstream <= 100)) )
nrow(subset(sech, (sech$Closest.upstream=="1.688" | sech$Closest.downstream=="1.688") & (sech$Dist.upstream <= 100 | sech$Dist.downstream <= 100)) )
nrow(subset(sim, (sim$Closest.upstream=="1.688" | sim$Closest.downstream=="1.688") & (sim$Dist.upstream <= 100 | sim$Dist.downstream <= 100)) )
nrow(subset(mel, (mel$Closest.upstream=="1.688" | mel$Closest.downstream=="1.688") & (mel$Dist.upstream <= 100 | mel$Dist.downstream <= 100)) )

test <- subset(sim, sim$Repeats>=2)
test <- subset(sim, (sim$Closest.upstream=="1.688" | sim$Closest.downstream=="1.688") & (sim$Dist.upstream <= 10 | sim$Dist.downstream <= 10) & sim$Repeats>=2)

allspecies <- rbind(mau,sech,sim,mel)

#allspecies$Closest.upstream
#Lord help me, i am back on my bullshit regex
allspecies$Closest.upstream <- gsub("^((?!GENE|1.688|RSP-LIKE).)*$", "TE", allspecies$Closest.upstream,perl=TRUE)
allspecies$Closest.downstream <- gsub("^((?!GENE|1.688|RSP-LIKE).)*$", "TE", allspecies$Closest.downstream,perl=TRUE)

#PLot closest elements as sina plots#########################
t1 <- ggplot(data=allspecies, aes(x=allspecies$Closest.upstream,y=allspecies$Dist.upstream,color=allspecies$species))+
  geom_sina()+
  theme(axis.text.x = element_text(angle = 90))+
  scale_y_log10(breaks=c(1,10,100,1000,10000),limits=c(1e-1,100000))+
  theme(legend.title=element_blank())+
  #  theme(panel.background = element_rect(fill="white"))+
  #  theme(panel.grid.major = element_blank())+
  #  theme(panel.grid.minor = element_blank())+
  xlab("")+
  ylab("Distance (bp)")+
  ggtitle("Closest upstream element to 1.688 cluster")

t1 + facet_grid(species ~ .) + theme(strip.text.y = element_text(size=14,face="bold"))


t2 <- ggplot(data=allspecies, aes(x=allspecies$Closest.downstream,y=allspecies$Dist.downstream,color=allspecies$species))+
  geom_sina()+
  theme(axis.text.x = element_text(angle = 90))+
  scale_y_log10(breaks=c(1,10,100,1000,10000),limits=c(1e-1,100000))+
  theme(legend.title=element_blank())+
  #  theme(panel.background = element_rect(fill="white"))+
  #  theme(panel.grid.major = element_blank())+
  #  theme(panel.grid.minor = element_blank())+
  xlab("")+
  ylab("Distance (bp)")+
  ggtitle("Closest downstream element to 1.688 cluster")

t2 + facet_grid(species ~ .) + theme(strip.text.y = element_text(size=14,face="bold"))


###########################################################

#OLD, DON'T USE: Plot closest element as barplots##########################
q1 <- ggplot(data=allspecies, aes(allspecies$Closest.upstream))+
  geom_bar(stat="count")+
  theme(axis.text.x = element_text(angle = 90))+
  theme(legend.title=element_blank())+
  #  theme(panel.background = element_rect(fill="white"))+
  #  theme(panel.grid.major =element_blank())+
  #  theme(panel.grid.minor = element_blank())+
  xlab("")+
  ggtitle("Closest upstream")

q1 + facet_grid(species ~ .) + theme(strip.text.y = element_text(size=14,face="bold"))

q2 <- ggplot(data=allspecies, aes(allspecies$Closest.downstream))+
  geom_bar(stat="count")+
  theme(axis.text.x = element_text(angle = 90))+
  theme(legend.title=element_blank())+
  #  theme(panel.background = element_rect(fill="white"))+
  #  theme(panel.grid.major =element_blank())+
  #  theme(panel.grid.minor = element_blank())+
  xlab("")+
  ggtitle("Closest downstream")

q2 + facet_grid(species ~ .) + theme(strip.text.y = element_text(size=14,face="bold"))

####################################################

p1 <- ggplot(data=mau, aes(x=mau$Closest.upstream,y=mau$Dist.upstream))+
  geom_violin(trim=T,scale="width",adjust=0.5,fill="firebrick1")+
  geom_point()+
  theme(axis.text.x = element_text(angle = 90))+
  scale_y_log10(breaks=c(1,10,100,1000,10000),limits=c(1,100000))+
  theme(legend.title=element_blank())+
  #  theme(panel.background = element_rect(fill="white"))+
  #  theme(panel.grid.major = element_blank())+
  #  theme(panel.grid.minor = element_blank())+
  xlab("")+
  ylab("Distance (log10)")+
  ggtitle("D. mau distance to upstream")

p2 <- ggplot(data=mau, aes(x=mau$Closest.downstream,y=mau$Dist.downstream))+
  geom_violin(trim=T,scale="width",adjust=0.5,fill="firebrick1")+
  geom_point()+
  theme(axis.text.x = element_text(angle = 90))+
  scale_y_log10(breaks=c(1,10,100,1000,10000),limits=c(1,100000))+
  theme(legend.title=element_blank())+
  #  theme(panel.background = element_rect(fill="white"))+
  #  theme(panel.grid.major = element_blank())+
  #  theme(panel.grid.minor = element_blank())+
  xlab("")+
  ylab("")+
  ggtitle("D. mau distance to downstream")

p3 <- ggplot(data=sech, aes(x=sech$Closest.upstream,y=sech$Dist.upstream))+
  geom_violin(trim=T,scale="width",adjust=0.5,fill="olivedrab2")+
  geom_point()+
  theme(axis.text.x = element_text(angle = 90))+
  scale_y_log10(breaks=c(1,10,100,1000,10000),limits=c(1,100000))+
  theme(legend.title=element_blank())+
  #  theme(panel.background = element_rect(fill="white"))+
  #  theme(panel.grid.major = element_blank())+
  #  theme(panel.grid.minor = element_blank())+
  xlab("")+
  ylab("Distance (log10)")+
  ggtitle("D. sech")

p4 <- ggplot(data=sech, aes(x=sech$Closest.downstream,y=sech$Dist.downstream))+
  geom_violin(trim=T,scale="width",adjust=0.5,fill="olivedrab2")+
  geom_point()+
  theme(axis.text.x = element_text(angle = 90))+
  scale_y_log10(breaks=c(1,10,100,1000,10000),limits=c(1,100000))+
  theme(legend.title=element_blank())+
  #  theme(panel.background = element_rect(fill="white"))+
  #  theme(panel.grid.major = element_blank())+
  #  theme(panel.grid.minor = element_blank())+
  xlab("")+
  ylab("")+
  ggtitle("D. sech")

p5 <- ggplot(data=sim, aes(x=sim$Closest.upstream,y=sim$Dist.upstream))+
  geom_violin(trim=T,scale="width",adjust=0.5,fill="dodgerblue1")+
  geom_point()+
  theme(axis.text.x = element_text(angle = 90))+
  scale_y_log10(breaks=c(1,10,100,1000,10000),limits=c(1,100000))+
  theme(legend.title=element_blank())+
  #  theme(panel.background = element_rect(fill="white"))+
  #  theme(panel.grid.major = element_blank())+
  #  theme(panel.grid.minor = element_blank())+
  xlab("")+
  ylab("Distance (log10)")+
  ggtitle("D. sim")

p6 <- ggplot(data=sim, aes(x=sim$Closest.downstream,y=sim$Dist.downstream))+
  geom_violin(trim=T,scale="width",adjust=0.5,fill="dodgerblue1")+
  geom_point()+
  theme(axis.text.x = element_text(angle = 90))+
  scale_y_log10(breaks=c(1,10,100,1000,10000),limits=c(1,100000))+
  theme(legend.title=element_blank())+
  #  theme(panel.background = element_rect(fill="white"))+
  #  theme(panel.grid.major = element_blank())+
  #  theme(panel.grid.minor = element_blank())+
  xlab("")+
  ylab("")+
  ggtitle("D. sim")

p7 <- ggplot(data=mel, aes(x=mel$Closest.upstream,y=mel$Dist.upstream))+
  geom_violin(trim=T,scale="width",adjust=0.5)+
  geom_point()+
  theme(axis.text.x = element_text(angle = 90))+
  scale_y_log10(breaks=c(1,10,100,1000,10000),limits=c(1,100000))+
  theme(legend.title=element_blank())+
  #  theme(panel.background = element_rect(fill="white"))+
  #  theme(panel.grid.major = element_blank())+
  #  theme(panel.grid.minor = element_blank())+
  xlab("")+
  ylab("Distance (log10)")+
  ggtitle("D. mel")

p8 <- ggplot(data=mel, aes(x=mel$Closest.downstream,y=mel$Dist.downstream))+
  geom_violin(trim=T,scale="width",adjust=0.5)+
  geom_point()+
  theme(axis.text.x = element_text(angle = 90))+
  scale_y_log10(breaks=c(1,10,100,1000,10000),limits=c(1,100000))+
  theme(legend.title=element_blank())+
  #  theme(panel.background = element_rect(fill="white"))+
  #  theme(panel.grid.major = element_blank())+
  #  theme(panel.grid.minor = element_blank())+
  xlab("")+
  ylab("")+
  ggtitle("D. mel")

pdf("/scratch/alarracu_lab/sim_clade_assemblies/0413/final_annotations/figures/X_rsp_cluster_distance_closest.pdf",width=11,height=8.5)
ggarrange(p1,p2,p3,p4,p5,p6,p7,p8,ncol=2,nrow=4)
dev.off()


########################################################
