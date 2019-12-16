x<-read.table("/scratch/alarracu_lab/sim_clade_assemblies/0413/final_annotations/motif_analysis/motif_analysis/dsech_motif_analysis/dsech_overlapped_with_genes.tsv",header = TRUE)

#x<-dsech_overlap_with_genes
g<-read.table("dsech_contig_with_genes_analyzed.tsv",header = TRUE)

i=2



y<-subset(x,(x$patern_fimo==i))


dsech_analysis_motif_1<-subset(y,select = c("type_contig","fimo_Start","fimo_stop"))

#assign(paste("dsech_analysis_motif",i,sep = "_"),y[!duplicated(y$contig_start),])



dsech_analysis_motif_1$coverage<-dsech_analysis_motif_1$fimo_stop - dsech_analysis_motif_1$fimo_Start

dsech_analysis_motif_1<-subset(dsech_analysis_motif_1,select = c("type_contig","coverage"))



dsech_analysis_motif_1<-aggregate(dsech_analysis_motif_1$coverage,by=list(attribute_contig=dsech_analysis_motif_1$type_contig),FUN=sum)

colnames(dsech_analysis_motif_1)<-c("attribute_contig","total_coverage_motif")

total_coverage_of_motif_on_x<-sum(dsech_analysis_motif_1$total_coverage_motif)


dsech_analysis_motif_1$frac_motif<-dsech_analysis_motif_1$total_coverage_motif/total_coverage_of_motif_on_x


dsech_analysis_motif_1<-merge(dsech_analysis_motif_1, g ,by.x = "attribute_contig")

dsech_analysis_motif_1$diff_motif<-dsech_analysis_motif_1$fraction_x - dsech_analysis_motif_1$frac_motif

dsech_analysis_motif_1$expected_coverage <- dsech_analysis_motif_1$fraction_x *total_coverage_of_motif_on_x

testing<-data.frame(p=numeric(0))

for (t in 1:nrow(dsech_analysis_motif_1)) {
  x<-matrix(c(dsech_analysis_motif_1[t,"total_coverage_motif"],total_coverage_of_motif_on_x,dsech_analysis_motif_1[t,"expected_coverage"],total_coverage_of_motif_on_x),byrow = TRUE,2,2)
  
  
  #sum(dsech_analysis_motif_1$exp_base_coverage)
  testing[t, ]<-fisher.test(x)$p.value
  
  
}


dsech_analysis_motif_1$p_value<-testing$p

dsech_analysis_motif_1$name<-1

write.table(dsech_analysis_motif_1,"dsech_analysis_motif_1.tsv",sep = "  ",row.names=FALSE)



# 
# dsech_testt<-count(dsech_unique_attributes,"type_contig")
# 
# colnames(dsech_testt)<-c("type_contig","motif_11_test_freq")
# 
# 
# 
# test<-merge(test,dsech_testt,all=TRUE)



# z <- ""
# y <- vector()
# for (i in 1_test:1_test0) {
#   print(paste(motif_freq,i,sep = "_"))
# }

#dsech_unique_attributes<-subset(dsech_unique_attributes,dsech_unique_attributes$contig_start<1_test1_test1_test1_test1_test1_test1_test1_test)



