
dmel_analysis_motif_1<-read.table("dmel_analysis_motif_1.tsv",header = TRUE)
dmel_analysis_motif_2<-read.table("dmel_analysis_motif_2.tsv",header = TRUE)

dmel_analysis_motif_3<-read.table("dmel_analysis_motif_3.tsv",header = TRUE)
dmel_analysis_motif_4<-read.table("dmel_analysis_motif_4.tsv",header = TRUE)
dmel_analysis_motif_5<-read.table("dmel_analysis_motif_5.tsv",header = TRUE)
dmel_analysis_motif_6<-read.table("dmel_analysis_motif_6.tsv",header = TRUE)
dmel_analysis_motif_7<-read.table("dmel_analysis_motif_7.tsv",header = TRUE)
dmel_analysis_motif_8<-read.table("dmel_analysis_motif_8.tsv",header = TRUE)

dmel_analysis_motif_9<-read.table("dmel_analysis_motif_9.tsv",header = TRUE)
dmel_analysis_motif_10<-read.table("dmel_analysis_motif_10.tsv",header = TRUE)

dmel_analysis_motif_11<-read.table("dmel_analysis_motif_11.tsv",header = TRUE)

dmel_analysis_motif_12<-read.table("dmel_analysis_motif_12.tsv",header = TRUE)

dmel_analysis_motif_13<-read.table("dmel_analysis_motif_13.tsv",header = TRUE)

dmel_analysis_motif_14<-read.table("dmel_analysis_motif_14.tsv",header = TRUE)
dmel_analysis_motif_15<-read.table("dmel_analysis_motif_15.tsv",header = TRUE)
dmel_analysis_motif_16<-read.table("dmel_analysis_motif_16.tsv",header = TRUE)

dmel_analysis_motif_17<-read.table("dmel_analysis_motif_17.tsv",header = TRUE)


dmel_analysis_motif_18<-read.table("dmel_analysis_motif_18.tsv",header = TRUE)

dmel_analysis_motif_19<-read.table("dmel_analysis_motif_19.tsv",header = TRUE)

dmel_analysis_motif_20<-read.table("dmel_analysis_motif_20.tsv",header = TRUE)



dmel_analysis_motif_21<-read.table("dmel_analysis_motif_21.tsv",header = TRUE)

dmel_analysis_motif_22<-read.table("dmel_analysis_motif_22.tsv",header = TRUE)

dmel_analysis_motif_23<-read.table("dmel_analysis_motif_23.tsv",header = TRUE)


dmel_analysis_motif_24<-read.table("dmel_analysis_motif_24.tsv",header = TRUE)

dmel_analysis_motif_25<-read.table("dmel_analysis_motif_25.tsv",header = TRUE)








dmel_all_motifs <- rbind (dmel_analysis_motif_1, dmel_analysis_motif_2, dmel_analysis_motif_3, dmel_analysis_motif_4, dmel_analysis_motif_5, dmel_analysis_motif_6, dmel_analysis_motif_7, dmel_analysis_motif_8, dmel_analysis_motif_9, dmel_analysis_motif_10, dmel_analysis_motif_11, dmel_analysis_motif_12, dmel_analysis_motif_13, dmel_analysis_motif_14, dmel_analysis_motif_15, dmel_analysis_motif_16, dmel_analysis_motif_17, dmel_analysis_motif_18, dmel_analysis_motif_19, dmel_analysis_motif_20, dmel_analysis_motif_21, dmel_analysis_motif_22, dmel_analysis_motif_23, dmel_analysis_motif_24, dmel_analysis_motif_25)


dmel_all_motifs$adj_p <- p.adjust(dmel_all_motifs$p_value,method = "bonferroni")




write.table(dmel_all_motifs,"dmel_all_motifs.tsv",row.names = FALSE,sep = "\t")

