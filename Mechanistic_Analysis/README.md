# Mechanistic Analysis
---
<br>

* *Mechanistic analysis involves discovery of meachincal interactions among the genomic elements. For, example if two correlated mRNAs are situated in the close proximity to each other i.e. (<1000 bp), then they can have cis-interactions among them, given they reside on the same chromosome.*

<br>

* **Libraries used**
1. [biomaRt](https://bioconductor.org/packages/release/bioc/html/biomaRt.html)
2. [data.table](https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html)

<br>

* **Install in the following order**
1. ```install.packages("BiocManager", dependencies = TRUE)```
2. ```BiocManager::install("biomaRt")```
3. ```install.packages("data.table", dependencies = TRUE)```

<br>

* *The [script](https://raw.githubusercontent.com/spriyansh/Micro-Array-Data-Analysis/master/Mechanistic_Analysis/mechanic_pairs.R) discuss the extraction of mechanically close pairs and their regulation status. The script can also be used as a data-mining tool from biomart.*
