# Data Pre-processing
---

<br>
<br>

* **The Data-preprocessing steps involves-**
1. Getting the Data
2. Normalization
2. Removing low expression counts

<br>
<br>

* **Libraries used**
1. [GEOquery](https://www.bioconductor.org/packages/release/bioc/html/GEOquery.html)
2. [data.table](https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html)
3. [genefilter](https://www.bioconductor.org/packages/release/bioc/html/genefilter.html)

<br>
<br>

* **Install in the following order**
1. ```install.packages("BiocManager", dependencies = TRUE)```
2. ```BiocManager::install("genefilter")```
3. ```BiocManager::install("GEOquery")```
4. ```install.packages("data.table", dependencies = TRUE)```

<br>
<br>

* **The data can be fetched from the following sources**
1. From [Gene Expression Omnibus (GEO) Database](https://www.ncbi.nlm.nih.gov/geo/) use [script](https://raw.githubusercontent.com/spriyansh/Micro-Array-Data-Analysis/master/Data_Preprocessing/get_geo_data.R)
2. From ```.CEL``` files use this script
