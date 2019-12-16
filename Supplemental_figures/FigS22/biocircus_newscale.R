  library(BioCircos)
  library(stringr)
  library(qdapRegex)
  clusters <- read.table("RSP_CLUSTER_INFO_SUMMARY.csv",sep=",",header=T,stringsAsFactors = FALSE)
  
  clusters <- subset(clusters, clusters$species=="D. sim")
  cyto_lengths<-data.frame(Cytoband=character(),length=numeric(),monemers=character(),stringsAsFactors = FALSE)
  
dist<-dist_dsim_rsp
dist2<-dist_dsim_1.688near
  
  row_counter=1
  names<-colnames(dist)
  
  setter=2   #make is 3 for 1.688 and 2 for rsp
  Threshold=0.05
  inner_only=FALSE #set true if want to draw within cytoband connection only
  outer_only=FALSE #set true if want to draw inbetween cytoband connection only.]
                  #DONT SET BOTH PARAMETERS TRUE
  
  
  setter_scale=0
  names2<-colnames(dist2)
  
  ordering_dist<-append(names,names2,after=length(names))
  
  ordering_frame<-data.frame(cytoband=ordering_dist,stringsAsFactors = FALSE)
  
  
  ordering_frame$first_pos<-rm_between(ordering_frame$cytoband,":","-",extract = TRUE)
  
  ordering_frame$first_pos<-as.numeric(ordering_frame$first_pos)
  ordering_frame<-ordering_frame[order(ordering_frame$first_pos),]
  
  scale_name<-ordering_frame$cytoband
  
  for (i in 1:NROW(scale_name)){
    bandname<-cyto_lengths$Cytoband
    
    nametoextract <-scale_name[i]
    nametoextract<-strsplit(nametoextract,'.',fixed = TRUE)
    nametoextract<- nametoextract[[1]]
  
    if(nametoextract[1]=="1"){
    nametoextract<-gsub("[^0-9.]", "", nametoextract[3])  #make is 3 for 1.688 and 2 for rsp
    }else{
      nametoextract<-gsub("[^0-9.]", "", nametoextract[2])  #make is 3 for 1.688 and 2 for rsp
      
    }
  
    print(nametoextract)
   if(is.element(nametoextract,bandname)){
  
     cyto_lengths[which(cyto_lengths$Cytoband==nametoextract),2]<-as.numeric(cyto_lengths[which(cyto_lengths$Cytoband==nametoextract),2]) + 1
    
    cyto_lengths[which(cyto_lengths$Cytoband==nametoextract),3]<-paste(cyto_lengths[which(cyto_lengths$Cytoband==nametoextract),3],scale_name[i],sep ="||")
     
     
     
  
   }else{
     print("yes")
     cyto_lengths[row_counter,]<-c(nametoextract,1,scale_name[i])
     row_counter=row_counter+1
   }
    
  
    
    
    
  }
  
  
  
  
  
  
  
  # 
  # pp<-BioCircos(genome = myGenome, genomeFillColor = c("tomato2", "darkblue"),
  #               genomeTicksScale = 4e+3)
  
  
  cytobands<-list()
  
  for(i in 1:NROW(cyto_lengths)){
    cytobands[as.character(cyto_lengths[i,1])]<-as.numeric(cyto_lengths[i,2])
    
    
  }
  
 cytobands[as.character(NROW(cytobands)+1)]<-as.numeric(cytobands[7])+2 #adding gap code
  
  
  # myGenome = list("A" = 10560,
  #                 "B" = 8808,
  #                 "C" = 12014,
  #                 "D" = 7664,
  #                 "E" = 9403,
  #                 "F" = 8661)
  # 
  
  link1<-vector()
  link2<-vector()
  
  pos1<-vector()
  pos2<-vector()
  
  
  names<-colnames(dist)
  for(r in 1:NROW(dist)){
    for (c in r:ncol(dist)) {
      
      if(r != c && dist[r,c]<Threshold &&dist[r,c]>0){
        
      #we will extract the name of the cytoband for that row we are at looping and also the start coordinatie
        
       nametoextract <-names[r]
       nametoextract<-strsplit(nametoextract,'.',fixed = TRUE)
       nametoextract<- nametoextract[[1]]
       nametoextract<-gsub("[^0-9.]", "", nametoextract[setter])  #make is 3 for 1.688 and 2 for rsp
       
       link1<-append(link1,nametoextract,after = length(link1))
       
        
        
       coordinatetoextract<-names[r]
       
       vectorofdatapoints<- cyto_lengths[which(cyto_lengths$Cytoband==nametoextract),3]
       
       vectorofdatapoints<-strsplit(vectorofdatapoints,'||',fixed = TRUE)
       vectorofdatapoints<-vectorofdatapoints[[1]]
       coordinatetoextract<-as.numeric(which(vectorofdatapoints==names[r]))
       
       print(coordinatetoextract)
       
  
       pos1<-append(pos1,coordinatetoextract,after = length(pos1))
       
      
  
       
       #####################here we will do the same but for the column 
       
       nametoextract <-names[c]
       nametoextract<-strsplit(nametoextract,'.',fixed = TRUE)
       nametoextract<- nametoextract[[1]]
       nametoextract<-gsub("[^0-9.]", "", nametoextract[setter])#make is 3 for 1.688 and 2 for rsp
       
       link2<-append(link2,nametoextract,after = length(link2))
       
       
       coordinatetoextract<-names[c]
       
       vectorofdatapoints<- cyto_lengths[which(cyto_lengths$Cytoband==nametoextract),3]
       
       vectorofdatapoints<-strsplit(vectorofdatapoints,'||',fixed = TRUE)
       vectorofdatapoints<-vectorofdatapoints[[1]]
       coordinatetoextract<-as.numeric(which(vectorofdatapoints==names[c]))
       
       print(coordinatetoextract)
       
       pos2<-append(pos2,coordinatetoextract,after = length(pos2))
       
       
  
       print("done")
        
        
        
        
      }
      
      
      
    
      
      
  }}
  
  
  if(inner_only==TRUE){
  vector_of_similarity<-which(link1==link2)
  link1<-link1[vector_of_similarity]
  link2<-link2[vector_of_similarity]
  pos1<-pos1[vector_of_similarity]
  pos2<-pos2[vector_of_similarity]
  
    
    
    
  }
  if(outer_only==TRUE){
    
    
    vector_of_similarity<-which(link1!=link2)
    link1<-link1[vector_of_similarity]
    link2<-link2[vector_of_similarity]
    pos1<-pos1[vector_of_similarity]
    pos2<-pos2[vector_of_similarity]
    
    
    
  }
  
  
  
  
  links_chromosomes_1 = link1 #c('1', '5', '9') # Chromosomes on which the links should start
  links_chromosomes_2 = link2 #c('2', '4', '10') # Chromosomes on which the links should end
  
  links_pos_1 =  pos1 #c(1, 2, 3)
  links_pos_2 = pos2 #c(10000, 8000, 12000)
  #links_labels = c("Link 1", "Link 2", "Link 3")
  
  tracklist = BioCircosBackgroundTrack("myBackgroundTrack", minRadius = 0, maxRadius = 0,
                                       borderSize = 0, fillColors = "#EEFFEE")  
  
  tracklist = tracklist + BioCircosLinkTrack('myLinkTrack', links_chromosomes_1, links_pos_1,
                                             links_pos_1, links_chromosomes_2, links_pos_2, links_pos_2,
                                             maxRadius = 1)
  
  testing<-BioCircos(genome=cytobands,tracklist, genomeFillColor = "PuOr",
            chrPad = 0.01, displayGenomeBorder = FALSE, yChr =  FALSE,
            genomeTicksDisplay = FALSE,  genomeLabelTextSize = "11pt", genomeLabelDy = 0)
  
  
  
  if(setter==2){
  htmlwidgets::saveWidget(testing,"dsimrsp.html")
  
  
  
  
  }else{
    htmlwidgets::saveWidget(testing,"dsim1.688.html")
    
    
  }
  
  
  
  
  # 
  # myGenome = list("A" = 1,
  #                 "B" = 10,
  #                 "C" = 5,
  #                 "D" = 6,
  #                 "E" = 2,
  #                 "F" = 3)
  # 
  # exp<-BioCircos(genome = cytobands, genomeFillColor = c("tomato2", "darkblue"))
  # htmlwidgets::saveWidget(exp,"exp.html")
  # 
  # 
