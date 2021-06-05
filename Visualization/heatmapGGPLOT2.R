################################################################################
############################ Heatmap with ggplot 2 #############################
################################################################################


################################################################################
# Author: Priyansh Srivastava ##################################################
# Contact: spriyansh29@gmail.com ###############################################
# Dataset: https://zenodo.org/record/2529926/files/limma-voom_luminalpregnant-luminallactateDD;
# https://zenodo.org/record/2529926/files/heatmap_genes ########################
# https://zenodo.org/record/2529926/files/limma-voom_luminalpregnant-luminallactate#
################################################################################


# Library
library(ggplot2)
library(reshape2)
library(viridis)

# Reading Dataset 
difExpSet <- read.csv("datasets/heatmapDataset.csv", row.names = 1)

# View
#View(difExpSet)

heatmap(
  as.matrix(difExpSet), Rowv=NA,
  Colv=as.dendrogram(hclust(dist(t(as.matrix(difExpSet)))),
                     ColSideColors = viridis_pal())
)