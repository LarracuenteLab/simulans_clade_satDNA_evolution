i=1
row_count=1
t=1
check=FALSE
fimo<-read.csv("//scratch//alarracu_lab//sim_clade_assemblies//0413//final_annotations//motif_analysis//fimo_and_cluster_csv_files//dsim_fimo.csv",header =TRUE)
contig<-read.csv("//scratch//alarracu_lab//sim_clade_assemblies//0413//final_annotations//motif_analysis//motif_analysis//gff_files//dsim_contig_with_genes.csv",header = TRUE,fileEncoding="UTF-8-BOM")

x1<-fimo$start_fimo
x2<-fimo$stop_fimo
y1<-contig$start_contig
y2<-contig$stop_contig

dsim_overlapped<-data.frame(type_contig=character(0),patern_fimo=numeric(0),fimo_Start=numeric(0),fimo_stop=numeric(0),contig_start=numeric(0),contig_stop=numeric(0),strand=character(0),matched_sequence=character(0),stringsAsFactors = FALSE)


#contig_type,start_contig,stop_contig,score_contig,strand_contig,attribute_contig


for(i in 1:nrow(fimo))   #for(i in 1:nrow(fimo)) 
  
{
  
  check=FALSE
  for(t in 1:nrow(contig)) 
    
  {
    
    if(x1[i] <= y2[t] && y1[t] <= x2[i]){
      
      
      dsim_overlapped[row_count, ] <- c(as.character(contig[t,1]),fimo[i,1],fimo[i,3],fimo[i,4], contig[t,2],contig[t,3],as.character(fimo[i,5]) ,as.character(fimo[i,9]))
      row_count=row_count+1
      check=TRUE
    }
    
  }
  
  if(check==FALSE){
    
    
    dsim_overlapped[row_count, ] <- c(as.character("un_annotated"),fimo[i,1],fimo[i,3],fimo[i,4], contig[t,2],contig[t,3],as.character(fimo[i,5]) ,as.character(fimo[i,9]))
    row_count=row_count+1
    
    
  }
  
  
}










write.table(dsim_overlapped,"//scratch//alarracu_lab//sim_clade_assemblies//0413//final_annotations//motif_analysis//motif_analysis//dsim_overlapped_with_genes.tsv",sep = "\t",row.names=FALSE)


