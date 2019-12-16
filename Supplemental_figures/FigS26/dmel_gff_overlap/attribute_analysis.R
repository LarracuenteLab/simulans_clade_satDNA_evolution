x<-read.table("/scratch/alarracu_lab/sim_clade_assemblies/0413/final_annotations/motif_analysis/motif_analysis/dmel_motif_analysis/dmel_overlapped_with_genes.tsv",header = TRUE)

#x<-dmel_overlap_with_genes
g<-read.table("dmel_contig_with_genes_analyzed.tsv",header = TRUE)

i=1



y<-subset(x,(x$patern_fimo==i))


dmel_analysis_motif_1<-subset(y,select = c("type_contig","fimo_Start","fimo_stop"))

#assign(paste("dmel_analysis_motif",i,sep = "_"),y[!duplicated(y$contig_start),])



dmel_analysis_motif_1$coverage<-dmel_analysis_motif_1$fimo_stop - dmel_analysis_motif_1$fimo_Start

dmel_analysis_motif_1<-subset(dmel_analysis_motif_1,select = c("type_contig","coverage"))



dmel_analysis_motif_1<-aggregate(dmel_analysis_motif_1$coverage,by=list(attribute_contig=dmel_analysis_motif_1$type_contig),FUN=sum)

colnames(dmel_analysis_motif_1)<-c("attribute_contig","total_coverage_motif")

total_coverage_of_motif_on_x<-sum(dmel_analysis_motif_1$total_coverage_motif)


dmel_analysis_motif_1$frac_motif<-dmel_analysis_motif_1$total_coverage_motif/total_coverage_of_motif_on_x


dmel_analysis_motif_1<-merge(dmel_analysis_motif_1, g ,by.x = "attribute_contig")

dmel_analysis_motif_1$diff_motif<-dmel_analysis_motif_1$fraction_x - dmel_analysis_motif_1$frac_motif

dmel_analysis_motif_1$expected_coverage <- dmel_analysis_motif_1$fraction_x *total_coverage_of_motif_on_x

testing<-data.frame(p=numeric(0))

for (t in 1:nrow(dmel_analysis_motif_1)) {
  x<-matrix(c(dmel_analysis_motif_1[t,"total_coverage_motif"],total_coverage_of_motif_on_x,dmel_analysis_motif_1[t,"expected_coverage"],total_coverage_of_motif_on_x),byrow = TRUE,2,2)
  
  
  #sum(dmel_analysis_motif_1$exp_base_coverage)
  testing[t, ]<-fisher.test(x)$p.value
  
  
}


dmel_analysis_motif_1$p_value<-testing$p

dmel_analysis_motif_1$name<-1

write.table(dmel_analysis_motif_1,"dmel_analysis_motif_1.tsv",sep = "  ",row.names=FALSE)



# 
# dmel_testt<-count(dmel_unique_attributes,"type_contig")
# 
# colnames(dmel_testt)<-c("type_contig","motif_11_test_freq")
# 
# 
# 
# test<-merge(test,dmel_testt,all=TRUE)



# z <- ""
# y <- vector()
# for (i in 1_test:1_test0) {
#   print(paste(motif_freq,i,sep = "_"))
# }

#dmel_unique_attributes<-subset(dmel_unique_attributes,dmel_unique_attributes$contig_start<1_test1_test1_test1_test1_test1_test1_test1_test)



