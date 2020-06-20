# Data Prepprocessing
---

* **Libraries used**
1. [GEOquery](https://www.bioconductor.org/packages/release/bioc/html/GEOquery.html)
2. [data.table](https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html)
3. [genefilter](https://www.bioconductor.org/packages/release/bioc/html/genefilter.html)


* **Install in the following order**
1. ```install.packages("BiocManager", dependencies = TRUE)```
2. ```BiocManager::install("genefilter")```
3. ```BiocManager::install("GEOquery")```
4. ```install.packages("data.table", dependencies = TRUE)```

* **The data is fetched from the [Gene Expression Omnibus (GEO) Database](https://www.ncbi.nlm.nih.gov/geo/)**
