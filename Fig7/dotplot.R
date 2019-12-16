
library(ggplot2)

species='dmau'
count_all=read.table("mau.summary",header=T)
#summary(count_all)

#combine 1.688 family
tmp <- summarise(count_all[count_all$family=='1pt688',], 
          ID='1pt688', family='1pt688', class='Satellite', color='1.688', 
          count_gDNA=sum(count_gDNA), RPM_gDNA=sum(RPM_gDNA), 
          count_eccDNA=sum(count_eccDNA), RPM_eccDNA=sum(RPM_eccDNA), relative_RPM=sum(relative_RPM))

count <- rbind(count_all[count_all$family!='1pt688',], tmp)

#exclude some classes
count <- count[count$class!='Low_complexity' & count$class!='Simple_repeat' & count$class!='Other' & count$class!='centromere_island' & count$class!='piRNA_cluster', ]

count$class <- factor(count$class, 
                      levels=c('Satellite', 'RC', 'Non-LTR_retrotransposon', 'LTR', 'DNA'),
                      labels=c('Satellite', 'RC', 'Non-LTR', 'LTR', 'DNA'))

count$color <- factor(count$color, 
                      levels=c('Rsp-like','1.688','Satellite', 'RC', 'Non-LTR_retrotransposon', 'LTR', 'DNA'),
                      labels=c('Rsp-like','1.688','Satellite', 'RC', 'Non-LTR', 'LTR', 'DNA'))

outfile <- paste(species,"dotplot.pdf", sep="_")

pdf(outfile, width=5,height=3)
ggplot(count, aes(RPM_gDNA, RPM_eccDNA, color=color))+
  geom_point() + 
  geom_abline(slope = 1, intercept = 0, linetype='dashed') +
  #color
  scale_color_manual(values=c("royalblue","orange","darkgreen","turquoise2","brown","yellow2","purple"))+
  xlim(0,11000)+ 
  ylim(0,80000)+
  theme(panel.background = element_rect(colour = "black", fill = "white"))+
  theme(panel.grid.major = element_blank())+
  theme(panel.grid.minor = element_blank())+
  geom_hline(yintercept=0, size=0.25,colour="grey")+
  theme(axis.text.y = element_text(colour = "black", size=8))+
  #face="italic"
  theme(axis.text.x = element_text(colour = "black", size=8))+
  theme(axis.ticks = element_line(colour = "black"))+
  theme(axis.line = element_line(size=0.5))+
  theme(axis.title = element_text(size=10))+
  theme(legend.title = element_blank()) +
  theme(legend.key = element_rect(fill = "transparent", colour = "transparent"))
dev.off()
