library("ape")
library("ggplot2")
library("ggtree")
library("RColorBrewer")
require('gtools')


#function to call the max() fxn but ignoring NA, important for drawing tip labels
my.max <- function(x) ifelse( !all(is.na(x)), max(x, na.rm=T), NA)

#Read in tree, Newick format
infile <- "~/Desktop/raxml_satDNA/RAxML_bipartitions.dmau_rsp_Xchrom_dere_MAFFT.phy_automre.converted.done"
spp <- "dmau"
reptype <- "rsp"

sat.tree <- read.tree(sprintf("%s",infile))
sat.tree <- root(sat.tree, "RSP_LIKE.dere.consensus_1_169")

#Output of htseq RPM counting script, run thru eccDNA_repeat_variants_counts_table.R (on BH)
mapping <- read.table(sprintf("~/Desktop/satDNA_mapping/4-mauE_rsp.txt",spp,reptype),sep="\t",header=T)

#######################################################

#making a data frame with annotations to pass to ggtree using the %<+% operator
dd <- data.frame(tips=sat.tree$tip.label,cyto=sapply(strsplit(sat.tree$tip.label,"\\."), `[`, 2))
#translation: make data frame with first column matching tip lapels in phylo object, second column is the cyto band (done by splitting tip labels on "." and saving second place)
#translation: if making tree for 1.688, take third field
dd$cyto <- gsub("[A-Z]","",dd$cyto)
dd$cyto <- as.factor(dd$cyto)
#translation: remove the cyto subdivision A-F, keeping it as a factor
#then sort the levels (i.e. cyto bands) numerically:
dd$cyto <- factor(dd$cyto, levels = mixedsort(levels(dd$cyto)))

row.names(dd) <- NULL
#Make column in annotations to hold variant ID:
dd$var <- NA
#Make another column to hold the % total reads represented by that variant
dd$RPM <- NA
#Make another column to hold pch shape
dd$tshape <- 19
#Make yet another column to hold alpha value
dd$talpha <- 1

#Assign RPM value to each variant to the annotations data frame (dd) from mapping data:
for(i in 1:nrow(dd)) {
  
  label <- as.character(dd[i,1]) #for each row in annotations dataframe, save label (containing start-end) as variable
  
  cyto <- as.character(dd[i,"cyto"])
  if(cyto=="het") {
    dd[i,"talpha"] <- 0.75
  }
  
  #Parsing the label to get the contig name, just involves a lot of juggling
  contig <- as.character(unlist(strsplit(label,"\\."))[3])
  contig <- gsub("U_", "U.", contig)
  contig <- as.character(unlist(strsplit(contig,"_"))[1])
  contig <- gsub("U.", "U_", contig)
  
  label <- sub("U_","U.",label) #fix annoying formatting thing with the U contigs
  
  start <- as.numeric(unlist(strsplit(label,"_"))[3]) #parse it and save as variable = "start"
  end <- as.numeric(unlist(strsplit(label,"_"))[4])
  
  #############################################################################
  
  for(j in 1:nrow(mapping)) {
    
    mapcoord <- as.character(mapping[i,1])
    mapcoord <- sub("U_","U.",mapcoord) #fix annoying formatting thing with the U contigs
    mapstart <- as.numeric(unlist(strsplit(mapcoord,"_"))[3])
    
    mapRPM <- as.numeric(as.character(mapping[i,3]))
    
    if(start == mapstart) {
      dd[i,"RPM"] <- mapRPM
      break
    } 
  }
}

#manually set value for tree root (D. ere), which won't have anything associated with it
#dd$RPM[dd$cyto=="dere"] <- (my.max(dd$RPM)/10)
dd$RPM[dd$cyto=="dere"] <- 800


#Define color palette################################

#Full set:

cols <- c("#660033",	"#FF6699",	"#CC0000",	"#FF6633",	"#FF9966",	"#FFCC00",	"#FFFF33",	"#99FF33",	"#339900",	"#336600",	"#66CC99",	"#99FFFF",	"#FFCCFF",	"#9933FF",	"#0000FF",	"#000099",	"black",	"grey")

#Select below as needed, ensures colors are consistent across species

#D. mau 1.688:

#cols <- c("#660033",	"#FF6699",	"#CC0000",	"#FF6633",	"#FF9966",	"#FFCC00",	"#FFFF33",	"#99FF33",	"#339900",	"#336600",	"#66CC99",	"#99FFFF",	"#FFCCFF",	"#9933FF",	"#0000FF",	"black",	"grey")

#D. mau Rsp:

cols <- c("#660033", "#CC0000",	"#FF6633", "#FF9966", "#66CC99",	"#99FFFF", "black")

#D. mel 1.688:

#cols <- c("#660033",	"#FF6699",	"#CC0000",	"#FF6633",	"#FF9966",	"#FFCC00",	"#FFFF33",	"#99FF33",	"#339900",	"#336600",	"#66CC99",	"#99FFFF",	"#FFCCFF",	"#9933FF",	"black",	"grey")

#D. mel Rsp:

#cols <- c("#CC0000","#FF6633","#FFCC00","black","grey")

#D.sech 1.688:

#cols <- c("#660033",	"#FF6699",	"#CC0000",	"#FF6633",	"#FF9966",	"#FFCC00",	"#FFFF33",	"#99FF33",	"#339900",	"#336600",	"#66CC99",	"#99FFFF",	"#FFCCFF",	"#9933FF",	"#0000FF",	"#000099",	"black",	"grey")

#D. sech Rsp:

cols <- c("#FF6699",	"#CC0000",	"#FF6633",	"#FF9966",	"#FFCC00", "black","grey")

#D. sech Rsp new coordinates:

cols <- c("#FF6699",	"#CC0000",	"#FF6633",	"#FFCC00", "black","grey")

#D. sim 1.688:

#cols <- c("#660033",	"#FF6699",	"#CC0000",	"#FF6633",	"#FF9966",	"#FFCC00",	"#FFFF33",	"#99FF33",	"#339900",	"#336600",	"#66CC99",	"#99FFFF",	"#FFCCFF",	"#9933FF",	"#0000FF",	"black",	"grey")

#D. sim Rsp

#cols <- c("#660033",	"#FF6699",	"#CC0000",	"#FF6633",	"#FF9966",  "#FFFF33",	"#99FF33",	"#339900",	"#336600",	"#66CC99",	"#99FFFF", "black", "grey")

#D. sim Rsp new coordinates

cols <- c("#660033",	"#FF6699",	"#CC0000",	"#FF6633",	"#FF9966",	"#FFCC00", "#FFFF33",	"#99FF33",	"#339900",	"#336600",	"#66CC99",	"#99FFFF", "black", "grey")

#D. ere 1.688

#cols <- c("#660033",	"#FF6699",	"#CC0000",	"#FF6633",	"#FF9966",	"#FFCC00",	"#FFFF33", "#339900", "black")

#D. ere Rsp

#cols <- c("#660033",	"#FF6699",	"#CC0000", "black")

###################################################

p <- ggtree(sat.tree,layout="rectangular") %<+% dd

#Get nodes to highlight based on bootstrapping values
d <- p$data
d <- d[!d$isTip,]
d$label <- as.numeric(d$label)
d <- subset(d,d$label>=90)
nodes <- d$node
###################################################

p <- ggtree(sat.tree,layout="rectangular") %<+% dd + 
  geom_tippoint(aes(color=cyto,size=RPM,shape=tshape,alpha=talpha))+
  xlim(0,0.7)+
  scale_colour_manual(values=cols)+
  #scale_alpha_discrete(range=c(0.5,1))+
  theme(legend.position="right",legend.key=element_blank())+
  geom_treescale(x=0.4,y=0,offset=5)+
  scale_shape_identity()+
  #geom_text2(aes(label=label, subset = !is.na(as.numeric(label)) & as.numeric(label) > 100), color="black")+
  geom_point2(aes(subset=(node %in% nodes),shape=15), size=3,alpha=0.5,color="#996666")

p+scale_alpha(range=c(0.75,1))


outfile <- gsub("automre","BSnodes.edges.scaledtips.pdf",infile)
pdf(sprintf("%s",outfile),width=11,height=8.5)
p+scale_alpha(range=c(0.75,1))
dev.off()



###########################################################################################################
