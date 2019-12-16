
dmau_analysis_motif_1<-read.table("dmau_analysis_motif_1.tsv",header = TRUE)
dmau_analysis_motif_2<-read.table("dmau_analysis_motif_2.tsv",header = TRUE)

dmau_analysis_motif_3<-read.table("dmau_analysis_motif_3.tsv",header = TRUE)
dmau_analysis_motif_4<-read.table("dmau_analysis_motif_4.tsv",header = TRUE)
dmau_analysis_motif_5<-read.table("dmau_analysis_motif_5.tsv",header = TRUE)
dmau_analysis_motif_6<-read.table("dmau_analysis_motif_6.tsv",header = TRUE)
dmau_analysis_motif_7<-read.table("dmau_analysis_motif_7.tsv",header = TRUE)
dmau_analysis_motif_8<-read.table("dmau_analysis_motif_8.tsv",header = TRUE)

dmau_analysis_motif_9<-read.table("dmau_analysis_motif_9.tsv",header = TRUE)
dmau_analysis_motif_10<-read.table("dmau_analysis_motif_10.tsv",header = TRUE)

dmau_analysis_motif_11<-read.table("dmau_analysis_motif_11.tsv",header = TRUE)

dmau_analysis_motif_12<-read.table("dmau_analysis_motif_12.tsv",header = TRUE)

dmau_analysis_motif_13<-read.table("dmau_analysis_motif_13.tsv",header = TRUE)

dmau_analysis_motif_14<-read.table("dmau_analysis_motif_14.tsv",header = TRUE)
dmau_analysis_motif_15<-read.table("dmau_analysis_motif_15.tsv",header = TRUE)
dmau_analysis_motif_16<-read.table("dmau_analysis_motif_16.tsv",header = TRUE)

dmau_analysis_motif_17<-read.table("dmau_analysis_motif_17.tsv",header = TRUE)


dmau_analysis_motif_18<-read.table("dmau_analysis_motif_18.tsv",header = TRUE)

dmau_analysis_motif_19<-read.table("dmau_analysis_motif_19.tsv",header = TRUE)

dmau_analysis_motif_20<-read.table("dmau_analysis_motif_20.tsv",header = TRUE)



dmau_analysis_motif_21<-read.table("dmau_analysis_motif_21.tsv",header = TRUE)

dmau_analysis_motif_22<-read.table("dmau_analysis_motif_22.tsv",header = TRUE)

dmau_analysis_motif_23<-read.table("dmau_analysis_motif_23.tsv",header = TRUE)


dmau_analysis_motif_24<-read.table("dmau_analysis_motif_24.tsv",header = TRUE)

dmau_analysis_motif_25<-read.table("dmau_analysis_motif_25.tsv",header = TRUE)








dmau_all_motifs <- rbind (dmau_analysis_motif_1, dmau_analysis_motif_2, dmau_analysis_motif_3, dmau_analysis_motif_4, dmau_analysis_motif_5, dmau_analysis_motif_6, dmau_analysis_motif_7, dmau_analysis_motif_8, dmau_analysis_motif_9, dmau_analysis_motif_10, dmau_analysis_motif_11, dmau_analysis_motif_12, dmau_analysis_motif_13, dmau_analysis_motif_14, dmau_analysis_motif_15, dmau_analysis_motif_16, dmau_analysis_motif_17, dmau_analysis_motif_18, dmau_analysis_motif_19, dmau_analysis_motif_20, dmau_analysis_motif_21, dmau_analysis_motif_22, dmau_analysis_motif_23, dmau_analysis_motif_24, dmau_analysis_motif_25)


dmau_all_motifs$adj_p <- p.adjust(dmau_all_motifs$p_value,method = "BH")




write.table(dmau_all_motifs,"dmau_all_motifs.tsv",row.names = FALSE,sep = "\t")

