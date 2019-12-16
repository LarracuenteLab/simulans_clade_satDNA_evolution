x<-read.table("/scratch/alarracu_lab/sim_clade_assemblies/0413/final_annotations/motif_analysis/motif_analysis/dsim_motif_analysis/dsim_overlapped_with_genes.tsv",header = TRUE)

#x<-dsim_overlap_with_genes
g<-read.table("dsim_contig_with_genes_analyzed.tsv",header = TRUE)

i=1



y<-subset(x,(x$patern_fimo==i))


dsim_analysis_motif_1<-subset(y,select = c("type_contig","fimo_Start","fimo_stop"))

#assign(paste("dsim_analysis_motif",i,sep = "_"),y[!duplicated(y$contig_start),])



dsim_analysis_motif_1$coverage<-dsim_analysis_motif_1$fimo_stop - dsim_analysis_motif_1$fimo_Start

dsim_analysis_motif_1<-subset(dsim_analysis_motif_1,select = c("type_contig","coverage"))



dsim_analysis_motif_1<-aggregate(dsim_analysis_motif_1$coverage,by=list(attribute_contig=dsim_analysis_motif_1$type_contig),FUN=sum)

colnames(dsim_analysis_motif_1)<-c("attribute_contig","total_coverage_motif")

total_coverage_of_motif_on_x<-sum(dsim_analysis_motif_1$total_coverage_motif)


dsim_analysis_motif_1$frac_motif<-dsim_analysis_motif_1$total_coverage_motif/total_coverage_of_motif_on_x


dsim_analysis_motif_1<-merge(dsim_analysis_motif_1, g ,by.x = "attribute_contig")

dsim_analysis_motif_1$diff_motif<-dsim_analysis_motif_1$fraction_x - dsim_analysis_motif_1$frac_motif

dsim_analysis_motif_1$expected_coverage <- dsim_analysis_motif_1$fraction_x *total_coverage_of_motif_on_x

testing<-data.frame(p=numeric(0))

for (t in 1:nrow(dsim_analysis_motif_1)) {
  x<-matrix(c(dsim_analysis_motif_1[t,"total_coverage_motif"],total_coverage_of_motif_on_x,dsim_analysis_motif_1[t,"expected_coverage"],total_coverage_of_motif_on_x),byrow = TRUE,2,2)
  
  
  #sum(dsim_analysis_motif_1$exp_base_coverage)
  testing[t, ]<-fisher.test(x)$p.value
  
  
}


dsim_analysis_motif_1$p_value<-testing$p

dsim_analysis_motif_1$name<-1

write.table(dsim_analysis_motif_1,"dsim_analysis_motif_1.tsv",sep = "  ",row.names=FALSE)



# 
# dsim_testt<-count(dsim_unique_attributes,"type_contig")
# 
# colnames(dsim_testt)<-c("type_contig","motif_11_test_freq")
# 
# 
# 
# test<-merge(test,dsim_testt,all=TRUE)



# z <- ""
# y <- vector()
# for (i in 1_test:1_test0) {
#   print(paste(motif_freq,i,sep = "_"))
# }

#dsim_unique_attributes<-subset(dsim_unique_attributes,dsim_unique_attributes$contig_start<1_test1_test1_test1_test1_test1_test1_test1_test)



