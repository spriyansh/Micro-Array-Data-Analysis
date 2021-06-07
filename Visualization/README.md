# Visualizations
---
<br>

* *This section explores various plots for data visualizations*

<br>

* **Libraries used**
1. [chromoMap](https://cran.r-project.org/web/packages/chromoMap/index.html)
2. [ggplot2](https://ggplot2.tidyverse.org/)

<br>

* **Install in the following order**
1. ```install.packages("chromoMap", dependencies = TRUE)```
2. ```install.packages("ggplot2", dependencies = TRUE)```

<br>

#### 1. Chromosome location plot: _This plot is used to visulize position of the genes on their respective chromosomes. A text file having entrie chromosomal lengths is a pre-requisitive, it can be found [here](https://raw.githubusercontent.com/spriyansh/Micro-Array-Data-Analysis/master/Visualization/Chrom_info.txt)_
<p align="center"><img src="https://github.com/spriyansh/Micro-Array-Data-Analysis/blob/master/Visualization/plots/Chromosome_Location_Plot.png" width="350"></p>

<br>

#### 2. Volcano Plot: _A volcano plot is a type of scatterplot that shows statistical significance (P value) versus magnitude of change (fold change). It enables quick visual identification of genes with large fold changes that are also statistically significant [ref](https://training.galaxyproject.org/training-material/topics/transcriptomics/tutorials/rna-seq-viz-with-volcanoplot/tutorial.html)._
<p align="center"><img src="https://github.com/spriyansh/Micro-Array-Data-Analysis/blob/master/Visualization/plots/Volcano.png"></p>

#### 3. Heatmaps: _Heatmaps are commonly used to visualize RNA-Seq results. They are useful for visualizing the expression of genes across the samples [ref](https://training.galaxyproject.org/training-material/topics/transcriptomics/tutorials/rna-seq-viz-with-volcanoplot/tutorial.html)._
<p align="center"><img src="https://github.com/spriyansh/Micro-Array-Data-Analysis/blob/master/Visualization/plots/Heatmap.png"></p>

#### 4. Boxplots: _A boxplot is a very useful graph that shows the shape of the distribution of the data as well as its central value (median), and variability (inter-quartile range, and usually the minimum and maximum values)[ref](http://nebc.nerc.ac.uk/nebc_website_frozen/nebc.nerc.ac.uk//tools/bioinformatics-docs/other-bioinf/microarray-quality.html#:~:text=package%20from%20Bioconductor.-,Boxplots,the%20minimum%20and%20maximum%20values)._
<p align="center"><img src="https://github.com/spriyansh/Micro-Array-Data-Analysis/blob/master/Visualization/plots/boxplot.png"></p>

#### 5. MA-plot: _An MA plot is an application of a Bland–Altman plot for visual representation of genomic data. The plot visualizes the differences between measurements taken in two samples, by transforming the data onto M (log ratio) and A (mean average) scales, then plotting these values.[ref](https://en.wikipedia.org/wiki/MA_plot#:~:text=An%20MA%20plot%20is%20an,scales%2C%20then%20plotting%20these%20values.)._
<p align="center"><img src="https://github.com/spriyansh/Micro-Array-Data-Analysis/blob/master/Visualization/plots/MA.png"></p>
