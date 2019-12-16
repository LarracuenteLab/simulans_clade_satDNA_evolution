library(ggplot2)
library(reshape2)
library(ggthemes)
library(RColorBrewer)
#install.packages("ggpubr")
library(ggpubr)
#install.packages("ggforce",dependencies=TRUE)
library(ggforce)

fileNames <- Sys.glob("~/Desktop/larracuente/sim_clade/0413/final.NR/alignments/cluster_divergence/*.csv")

datalist = list()
i <-1
for (fileName in fileNames) {
  
  #Read in data frame, label properly
  dists <- read.csv(fileName,sep=",",header=T,row.names = 1)
  #dists <- na.omit(dists)
  dists <- dists[!is.na(dists$maxDyLowerEst),]
  dists <- dists[!is.na(dists$band),]
  
  #Parse file name to get species and repeat type (contained in file name)
  temp <- as.character(unlist(strsplit(fileName,"/"))[11])
  spp <- as.character(unlist(strsplit(temp,"Data"))[1])
  rep <- as.character(unlist(strsplit(temp,"Data"))[2])
  rep <- gsub(".csv", "", rep)
  
  #Add columns to data frame
  dists$spp <- spp
  dists$rep <- rep
  dists$age <- "old"
  
  
  for(j in 1:nrow(dists)) {
    if(dists[j,"maxDyLowerEst"]<=0.05) {
      dists[j,"age"] <- "new"
    }
  }
  
  print(spp)
  print(rep)
  print(nrow(dists))
  print(nrow(subset(dists,dists$age=="new")))
  
  datalist[[i]] <- dists #add data frame to list
  
  #cat(spp,rep,subset(dists, dists$maxDyLowerEst<=0.05))
  
  i <- i+1
}

alldists = do.call(rbind, datalist) #combine all data frames in list to big data frame
alldists$spp <- as.factor(alldists$spp)
alldists$spp_f <- factor(alldists$spp, levels=c("mau","sech","sim","mel"))

nrow(subset(alldists, (alldists$spp=="mau" & alldists$rep=="Rsp")))
nrow(subset(alldists, (alldists$spp=="sech" & alldists$rep=="Rsp")))
nrow(subset(alldists, (alldists$spp=="sim" & alldists$rep=="Rsp")))
nrow(subset(alldists, (alldists$spp=="mel" & alldists$rep=="Rsp")))


test <- subset(alldists, alldists$maxDyLowerEst<=0.05)

nrow(subset(test, (test$spp=="mau" & test$rep=="Rsp")))
nrow(subset(test, (test$spp=="sech" & test$rep=="Rsp")))
nrow(subset(test, (test$spp=="sim" & test$rep=="Rsp")))
nrow(subset(test, (test$spp=="mel" & test$rep=="Rsp")))

p <- ggplot(alldists, aes(x=alldists$rep, y=alldists$maxDyLowerEst, color=alldists$rep))+
  geom_boxplot()+
  geom_sina()+
  scale_color_manual(values=c("orange","dodgerblue"))+
  geom_hline(aes(yintercept=0.05),color="red",linetype="dashed",alpha=0.25)+
  xlab("")+
  ylab("Max distance btwn edges and center")+
  theme(legend.position = "none")

p + facet_grid(.~spp) 


pdf("~/Desktop/larracuente/sim_clade/0413/final.NR/alignments/cluster_divergence/cluster_dY_distribution.pdf",width=11,height=8.5)
p + facet_grid(.~spp)
dev.off()

