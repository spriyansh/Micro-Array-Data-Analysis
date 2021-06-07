################################################################################
############################ MA Plot with ggplot 2 #############################
################################################################################


################################################################################
# Author: Priyansh Srivastava ##################################################
# Contact: spriyansh29@gmail.com ###############################################
# Dataset: https://zenodo.org/record/2529117/files/limma-voom_luminalpregnant-luminallactate;
# https://zenodo.org/record/2529117/files/volcano_genes ########################
################################################################################


# Library
library(ggplot2)

# Reading Dataset 
difExpGen <- read.csv("datasets/differentiallyExpressedGenes.csv")

# Designing the plot
maPlot <- ggplot(data = difExpGen, # Passing the dataset
                      aes(x = AveExpr, # Mapping to x-axis
                          y = logFC, # Mapping to y-axis
                          ) # Mapping to colour
) + 
  # Adding points
  geom_point(size=2,alpha = 0.1 # Size of points # Alpha of dots
  ) +

  # Scaling Alpha for legend
  guides(colour = guide_legend(override.aes = list(alpha = 0.7)))+
  
  # Adding the basic theme
  theme_bw() +
  
  # Override defaults
  theme(
    panel.grid.major = element_line(size = 0.05, 
                                    linetype = 'dotted', colour = "#000000"), 
    panel.grid.minor = element_line(size = 0.05, 
                                    linetype = 'dashed', colour = "#000000"),
    panel.border=element_blank())

# Plotting the ma
maPlot