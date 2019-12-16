
dsim_analysis_motif_1<-read.table("dsim_analysis_motif_1.tsv",header = TRUE)
dsim_analysis_motif_2<-read.table("dsim_analysis_motif_2.tsv",header = TRUE)

dsim_analysis_motif_3<-read.table("dsim_analysis_motif_3.tsv",header = TRUE)
dsim_analysis_motif_4<-read.table("dsim_analysis_motif_4.tsv",header = TRUE)
dsim_analysis_motif_5<-read.table("dsim_analysis_motif_5.tsv",header = TRUE)
dsim_analysis_motif_6<-read.table("dsim_analysis_motif_6.tsv",header = TRUE)
dsim_analysis_motif_7<-read.table("dsim_analysis_motif_7.tsv",header = TRUE)
dsim_analysis_motif_8<-read.table("dsim_analysis_motif_8.tsv",header = TRUE)

dsim_analysis_motif_9<-read.table("dsim_analysis_motif_9.tsv",header = TRUE)
dsim_analysis_motif_10<-read.table("dsim_analysis_motif_10.tsv",header = TRUE)

dsim_analysis_motif_11<-read.table("dsim_analysis_motif_11.tsv",header = TRUE)

dsim_analysis_motif_12<-read.table("dsim_analysis_motif_12.tsv",header = TRUE)

dsim_analysis_motif_13<-read.table("dsim_analysis_motif_13.tsv",header = TRUE)

dsim_analysis_motif_14<-read.table("dsim_analysis_motif_14.tsv",header = TRUE)
dsim_analysis_motif_15<-read.table("dsim_analysis_motif_15.tsv",header = TRUE)
dsim_analysis_motif_16<-read.table("dsim_analysis_motif_16.tsv",header = TRUE)

dsim_analysis_motif_17<-read.table("dsim_analysis_motif_17.tsv",header = TRUE)


dsim_analysis_motif_18<-read.table("dsim_analysis_motif_18.tsv",header = TRUE)

dsim_analysis_motif_19<-read.table("dsim_analysis_motif_19.tsv",header = TRUE)

dsim_analysis_motif_20<-read.table("dsim_analysis_motif_20.tsv",header = TRUE)



dsim_analysis_motif_21<-read.table("dsim_analysis_motif_21.tsv",header = TRUE)

dsim_analysis_motif_22<-read.table("dsim_analysis_motif_22.tsv",header = TRUE)

dsim_analysis_motif_23<-read.table("dsim_analysis_motif_23.tsv",header = TRUE)


dsim_analysis_motif_24<-read.table("dsim_analysis_motif_24.tsv",header = TRUE)

dsim_analysis_motif_25<-read.table("dsim_analysis_motif_25.tsv",header = TRUE)








dsim_all_motifs <- rbind (dsim_analysis_motif_1, dsim_analysis_motif_2, dsim_analysis_motif_3, dsim_analysis_motif_4, dsim_analysis_motif_5, dsim_analysis_motif_6, dsim_analysis_motif_7, dsim_analysis_motif_8, dsim_analysis_motif_9, dsim_analysis_motif_10, dsim_analysis_motif_11, dsim_analysis_motif_12, dsim_analysis_motif_13, dsim_analysis_motif_14, dsim_analysis_motif_15, dsim_analysis_motif_16, dsim_analysis_motif_17, dsim_analysis_motif_18, dsim_analysis_motif_19, dsim_analysis_motif_20, dsim_analysis_motif_21, dsim_analysis_motif_22, dsim_analysis_motif_23, dsim_analysis_motif_24, dsim_analysis_motif_25)


dsim_all_motifs$adj_p <- p.adjust(dsim_all_motifs$p_value,method = "BH")




write.table(dsim_all_motifs,"dsim_all_motifs.tsv",row.names = FALSE,sep = "\t")

