
library(ggplot2)
library(dplyr)

count_all=read.table("iso.summary",header=T)
mel <- count_all[,c(1,2,3,8,9)]
mel$species <- "mel"

count_all=read.table("sech.summary",header=T)
sech <- count_all[,c(1,2,3,8,9)]
sech$species <- "sech"

count_all=read.table("sim.summary",header=T)
sim <- count_all[,c(1,2,3,8,9)]
sim$species <- "sim"

count_all=read.table("mau.summary",header=T)
mau <- count_all[,c(1,2,3,8,9)]
mau$species <- "mau"

count_all <- rbind(mel,sim, sech, mau)
count_all$species <- factor(count_all$species, 
                            levels=c('mel', 'sim', 'sech', 'mau'),
                            labels=c('Dmel','Dsim','Dsech','Dmau'))

#exclude some classes
count <- count_all[count_all$class!='Low_complexity' & count_all$class!='Simple_repeat' & count_all$class!='Other' & count_all$class!='centromere_island' & count_all$class!='piRNA_cluster', ]

count$class <- factor(count$class, 
                      levels=c('Satellite', 'LTR', 'Non-LTR_retrotransposon', 'DNA', 'RC'),
                      labels=c('Satellite', 'LTR', 'Non-LTR', 'DNA', 'RC'))

y <- 'log(relative_RPM)'

  outfile <- paste("boxplot","relative_RPM.pdf",sep="_")

  pdf(outfile, width=8, height=4)
  ggplot(count, aes(class, log(relative_RPM+1), color=species))+
    geom_boxplot() + 
    scale_color_manual(values=c("green4","blue","red","black"))+
    xlab("")+ 
    ylab(y)+
    theme(panel.background = element_rect(colour = "black", fill = "white"))+
    theme(panel.grid.major = element_blank())+
    theme(panel.grid.minor = element_blank())+
    geom_hline(yintercept=0, size=0.25,colour="grey")+
    theme(axis.text.y = element_text(colour = "black", size=10))+
    #face="italic"
    theme(axis.text.x = element_text(colour = "black", size=10))+
    theme(axis.ticks = element_line(colour = "black"))+
    theme(axis.line = element_line(size=0.5))+
    theme(axis.title = element_text(size=10))+
    theme(legend.title = element_blank())+
    theme(legend.text = element_text(face = "italic", size=10))
  dev.off()

  

y <- 'log(RPM_eccDNA)'

  outfile <- paste("boxplot","RPM_eccDNA.pdf", sep="_")

  pdf(outfile, width=8, height=4)
  ggplot(count, aes(class, log(RPM_eccDNA+1), color=species))+
    geom_boxplot() + 
    scale_color_manual(values=c("green4","blue","red","black"))+
    xlab("")+ 
    ylab(y)+
    theme(panel.background = element_rect(colour = "black", fill = "white"))+
    theme(panel.grid.major = element_blank())+
    theme(panel.grid.minor = element_blank())+
    geom_hline(yintercept=0, size=0.25,colour="grey")+
    theme(axis.text.y = element_text(colour = "black", size=10))+
    #face="italic"
    theme(axis.text.x = element_text(colour = "black", size=10))+
    theme(axis.ticks = element_line(colour = "black"))+
    theme(axis.line = element_line(size=0.5))+
    theme(axis.title = element_text(size=10))+
    theme(legend.title = element_blank())+
    theme(legend.text = element_text(face = "italic", size=10))
  dev.off()
  

