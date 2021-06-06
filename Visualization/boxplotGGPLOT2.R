################################################################################
############################ Boxplot with ggplot 2 #############################
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
options(ggrepel.max.overlaps = Inf)

# Reading Dataset 
longExpSet <- read.csv("datasets/boxDataset.csv")

# ggplot2
g<- ggplot(data = longExpSet,
           aes(x=Sample,
               y=Expression,
               color=Group)) +
  
  scale_color_manual(values = c("#D55E00", "#009E73"))+
  geom_boxplot() + 
  stat_summary(fun=mean, geom="point", shape= 8, color="#56B4E9", size = 2)+
  theme_bw() +
  theme(
  panel.grid.major = element_line(size = 0.05, 
                                  linetype = 'dotted', colour = "#000000"), 
panel.grid.minor = element_line(size = 0.05, 
                                linetype = 'dashed', colour = "#000000"),
legend.position = "bottom",
legend.text = element_text(size = 12),
legend.title = element_blank(),
legend.key.size = unit(1, "cm"),
panel.border=element_blank())

g