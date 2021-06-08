################################################################################
############################# Network with igraph ##############################
################################################################################


################################################################################
# Author: Priyansh Srivastava ##################################################
# Contact: spriyansh29@gmail.com ###############################################
# Dataset: https://zenodo.org/record/2529926/files/limma-voom_luminalpregnant-luminallactateDD;
# https://zenodo.org/record/2529926/files/heatmap_genes ########################
# https://zenodo.org/record/2529926/files/limma-voom_luminalpregnant-luminallactate#
################################################################################


# Library
library(igraph)
library(Hmisc)

# ++++++++++++++++++++++++++++
# flattenCorrMatrix
# ++++++++++++++++++++++++++++
# cormat : matrix of the correlation coefficients
# pmat : matrix of the correlation p-values
flattenCorrMatrix <- function(cormat, pmat) {
  ut <- upper.tri(cormat)
  data.frame(
    row = rownames(cormat)[row(cormat)[ut]],
    column = rownames(cormat)[col(cormat)[ut]],
    cor  =(cormat)[ut],
    p = pmat[ut]
  )
}

# Reading Dataset 
difExpSet <- read.csv("datasets/heatmapDataset.csv", row.names = 1)

# View
#View(difExpSet)

# Transpose
difExpSet <- t(difExpSet)

# Conversion to matrix
difExpSet <- as.matrix(difExpSet)

# Correlation
corrObj <- rcorr(difExpSet, type="pearson")

# Conversion to Dataframe
corrleations <- flattenCorrMatrix(corrObj$r, corrObj$P)

# Significant
corrleations <- corrleations[corrleations$p < 0.05,]

# Correlation based on PC (Upper bound)
corrleations <- corrleations[corrleations$cor > 0.5,]

# Subsetting to dataframe
links <- corrleations[,c(1,2)]

# Desigining Network
network <- graph_from_data_frame(d=links, directed=F) 

# plotting
network$layout <- layout_as_tree

plot(network, vertex.size=10, vertex.label.size=1, vertex.label.dist=1.5)