library("ape")
library("Biostrings")
library("ggplot2")
library("ggtree")
library("RColorBrewer")
require('gtools')
#library("phytools") #will have to dig if want to install this... :/

infile <- "/Users/johnsproul/Dropbox/X_satellite_paper/Figures/New_coordinates_all_files/Supplemental_Figures/1.688_all_species_tree/RAxML_bipartitions.allspecies_dere_Xchrom_1.688_clusters_min2_cytoband.MAAFT.converted.done"

sat.tree <- read.tree(sprintf("%s",infile))

mauflank <- read.table("/Users/johnsproul/Dropbox/X_satellite_paper/Figures/New_coordinates_all_files/Supplemental_Figures/1.688_all_species_tree/cluster_edges/dmau_1.688_cluster_edges.txt",sep="\t",header=T)
mauflank$spp <- "dmau"
melflank <- read.table("/Users/johnsproul/Dropbox/X_satellite_paper/Figures/New_coordinates_all_files/Supplemental_Figures/1.688_all_species_tree/cluster_edges/dmel_1.688_cluster_edges.txt",sep="\t",header=T)
melflank$spp <- "dmel"
sechflank <- read.table("/Users/johnsproul/Dropbox/X_satellite_paper/Figures/New_coordinates_all_files/Supplemental_Figures/1.688_all_species_tree/cluster_edges/dsech_1.688_cluster_edges.txt",sep="\t",header=T)
sechflank$spp <- "dsech"
simflank <- read.table("/Users/johnsproul/Dropbox/X_satellite_paper/Figures/New_coordinates_all_files/Supplemental_Figures/1.688_all_species_tree/cluster_edges/dsim_1.688_cluster_edges.txt",sep="\t",header=T)
simflank$spp <- "dsim"

flanking <- rbind(mauflank,melflank,sechflank,simflank)

sat.tree <- root(sat.tree, "dere.1.688.dere.consensus_1_389")

groupInfo <- split(sat.tree$tip.label, gsub("\\..+", "", sat.tree$tip.label)) #LOOK AT THIS BULLSHIT REGEX
#LOOK AT IT
#translation: after full stop (\\.), match any number of anything (.+), then get rid of it ("" as part of gsub)
#so left with "dmel, dmau, dsech, dsim" from tip label

#Used for when plotting branches different colors (i.e. multiple species)
sat.tree <- groupOTU(sat.tree, groupInfo)

#making a data frame with annotations to pass to ggtree using the %<+% operator (lol)
dd <- data.frame(tips=sat.tree$tip.label,cyto=sapply(strsplit(sat.tree$tip.label,"\\."), `[`, 4))
#translation: make data frame with first column matching tip lapels in phylo object, second column is the cyto band (done by splitting tip labels on "." and saving second place)
#translation: if making tree for 1.688, take third field
dd$cyto <- gsub("[A-Z]","",dd$cyto)
dd$cyto <- as.factor(dd$cyto)
#translation: remove the cyto subdivision A-F, keeping it as a factor
#then sort the levels (i.e. cyto bands) numerically:
dd$cyto <- factor(dd$cyto, levels = mixedsort(levels(dd$cyto)))

#This section used to assign different tip shapes to first/last in cluster
dd$spp=sapply(strsplit(sat.tree$tip.label,"\\."), `[`, 1)
dd$tshape <- 19
for(i in 1:nrow(dd)) {
  
  label <- as.character(dd[i,1]) #for each row in annotations dataframe, save label (containing start-end) as variable
  spp <- as.character(unlist(strsplit(label,"\\."))[1])
  
  start <- as.numeric(unlist(strsplit(label,"_"))[3])
  
  for(j in 1:nrow(flanking)) {
    clusspp <- as.character(flanking[j,"spp"])
    firststart <- as.numeric(flanking[j,"first_start"])
    laststart <- as.numeric(flanking[j,"last_start"])
    
    if(start == firststart & identical(spp,clusspp)) {
      dd[i,"tshape"] <- 8
    } else if (start == laststart & identical(spp,clusspp)) {
      dd[i,"tshape"] <- 8
    }
  }
}
################################################
row.names(dd) <- NULL

p <- ggtree(sat.tree,layout="rectangular") %<+% dd

#Get nodes to highlight based on bootstrapping values
d <- p$data
d <- d[!d$isTip,]
d$label <- as.numeric(d$label)
d <- subset(d,d$label>=90)
nodes <- d$node
###################################################

#Note: could not figure out how to get legend to sort correctly (factors share aesthetic), so need to manually fix in Illustrator
#cols <- c("#660033", "#336600",	"#66CC99",	"#99FFFF",	"#FFCCFF",	"#9933FF",	"#0000FF",	"#000099", "#FF6699",	"#CC0000","#FF6633",	"#FF9966",	"#FFCC00",	"#FFFF33",	"#99FF33",	"#339900", "black", "orange2", "#339933","#990099","dodgerblue3","grey")
#species only:
cols <- c("black", "orange2", "#339933","#990099","dodgerblue3","grey")


p <- ggtree(sat.tree, aes(color=group),layout="rectangular") %<+% dd + 
  geom_tippoint(aes(color=cyto,shape=tshape),size=0.75,alpha=1)+ #get rid of shape field if want tip shapes to be the same
  xlim(0,1.25)+
  scale_colour_manual(values=cols)+
  #scale_fill_manual(values=cols)+
  theme(legend.position="right",legend.key=element_blank())+
  geom_treescale(x=0.5,y=2,offset=5)+
  #geom_text2(aes(subset = !isTip, label=label), color="black")+
  #geom_text2(aes(label=label, subset = !is.na(as.numeric(label)) & as.numeric(label) > 90), color="black")+
  geom_point2(aes(subset=(node %in% nodes),shape=15), size=3,alpha=0.5,color="#996666")+
  scale_shape_identity()+ #remove this line if tip shapes should be the same
  geom_point2(aes(subset=(node %in% nodes),shape=15), size=3,alpha=0,color="#996666")

p+scale_alpha(range=c(0.75,1))

outfile <- gsub("MAAFT","notips.dereroot.pdf",infile)
pdf(sprintf("%s",outfile),width=8.5,height=11)
plot(p)
dev.off()


#This is for is want to plot internal branches with grey color
# p$data$group <- as.character(p$data$group)
# 
# p$data$group[p$data$isTip==FALSE] <- "internal"
# 
# p$data$group <- as.factor(p$data$group)
# 
# p + geom_tippoint(aes(color=cyto),size=1.5,alpha=1)+
#   xlim(0,NA)+
#   scale_colour_manual(values=cols)+
#   #scale_fill_manual(values=cols)+
#   theme(legend.position="right",legend.key=element_blank())+
#   geom_treescale(x=0.5,y=2,offset=5)+
#   #geom_text2(aes(subset = !isTip, label=label), color="black")+
#   #geom_text2(aes(label=label, subset = !is.na(as.numeric(label)) & as.numeric(label) > 90), color="black")
# outfile <- gsub("MAAFT","tips.gray.dereroot.pdf",infile)
# pdf(sprintf("%s",outfile),width=8.5,height=11)
# plot(p)
# dev.off()
# 
# #open_tree(p,angle=0) + theme(legend.position = "right") #IT'S SO BEAUTIFUL
# 
# #plot(sat.tree,type="fan",show.tip.label= FALSE,no.margin=TRUE,open.angle=15,direction="rightwards")


###########################################################################################################



