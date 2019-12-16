
dsech_analysis_motif_1<-read.table("dsech_analysis_motif_1.tsv",header = TRUE)
dsech_analysis_motif_2<-read.table("dsech_analysis_motif_2.tsv",header = TRUE)

dsech_analysis_motif_3<-read.table("dsech_analysis_motif_3.tsv",header = TRUE)
dsech_analysis_motif_4<-read.table("dsech_analysis_motif_4.tsv",header = TRUE)
dsech_analysis_motif_5<-read.table("dsech_analysis_motif_5.tsv",header = TRUE)
dsech_analysis_motif_6<-read.table("dsech_analysis_motif_6.tsv",header = TRUE)
dsech_analysis_motif_7<-read.table("dsech_analysis_motif_7.tsv",header = TRUE)
dsech_analysis_motif_8<-read.table("dsech_analysis_motif_8.tsv",header = TRUE)

dsech_analysis_motif_9<-read.table("dsech_analysis_motif_9.tsv",header = TRUE)
dsech_analysis_motif_10<-read.table("dsech_analysis_motif_10.tsv",header = TRUE)

dsech_analysis_motif_11<-read.table("dsech_analysis_motif_11.tsv",header = TRUE)

dsech_analysis_motif_12<-read.table("dsech_analysis_motif_12.tsv",header = TRUE)

dsech_analysis_motif_13<-read.table("dsech_analysis_motif_13.tsv",header = TRUE)

dsech_analysis_motif_14<-read.table("dsech_analysis_motif_14.tsv",header = TRUE)
dsech_analysis_motif_15<-read.table("dsech_analysis_motif_15.tsv",header = TRUE)
dsech_analysis_motif_16<-read.table("dsech_analysis_motif_16.tsv",header = TRUE)

dsech_analysis_motif_17<-read.table("dsech_analysis_motif_17.tsv",header = TRUE)


dsech_analysis_motif_18<-read.table("dsech_analysis_motif_18.tsv",header = TRUE)

dsech_analysis_motif_19<-read.table("dsech_analysis_motif_19.tsv",header = TRUE)

dsech_analysis_motif_20<-read.table("dsech_analysis_motif_20.tsv",header = TRUE)



dsech_analysis_motif_21<-read.table("dsech_analysis_motif_21.tsv",header = TRUE)

dsech_analysis_motif_22<-read.table("dsech_analysis_motif_22.tsv",header = TRUE)

dsech_analysis_motif_23<-read.table("dsech_analysis_motif_23.tsv",header = TRUE)


dsech_analysis_motif_24<-read.table("dsech_analysis_motif_24.tsv",header = TRUE)

dsech_analysis_motif_25<-read.table("dsech_analysis_motif_25.tsv",header = TRUE)








dsech_all_motifs <- rbind (dsech_analysis_motif_1, dsech_analysis_motif_2, dsech_analysis_motif_3, dsech_analysis_motif_4, dsech_analysis_motif_5, dsech_analysis_motif_6, dsech_analysis_motif_7, dsech_analysis_motif_8, dsech_analysis_motif_9, dsech_analysis_motif_10, dsech_analysis_motif_11, dsech_analysis_motif_12, dsech_analysis_motif_13, dsech_analysis_motif_14, dsech_analysis_motif_15, dsech_analysis_motif_16, dsech_analysis_motif_17, dsech_analysis_motif_18, dsech_analysis_motif_19, dsech_analysis_motif_20, dsech_analysis_motif_21, dsech_analysis_motif_22, dsech_analysis_motif_23, dsech_analysis_motif_24, dsech_analysis_motif_25)


dsech_all_motifs$adj_p <- p.adjust(dsech_all_motifs$p_value,method = "BH")




write.table(dsech_all_motifs,"dsech_all_motifs.tsv",row.names = FALSE,sep = "\t")

