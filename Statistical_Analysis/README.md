# Statistical Analysis
---
<br>

* **Statistical analysis involves following-**
1. Finding differentially expressed genes. Use [this](https://raw.githubusercontent.com/spriyansh/Micro-Array-Data-Analysis/master/Statistical_Analysis/t_test.R) script for performing [t-test](https://en.wikipedia.org/wiki/Student%27s_t-test)
2. Finding the regulation status of the differentially expressed gene. Use [this](https://raw.githubusercontent.com/spriyansh/Micro-Array-Data-Analysis/master/Statistical_Analysis/significant_filter.R) for filtering
3. Finding the correlated genes

<br>

* **Libraries used**
1. [Limma](https://www.bioconductor.org/packages/release/bioc/html/limma.html)
2. [data.table](https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html)
3. [tidyverse](https://www.tidyverse.org/)
4. [Hmisc](https://cran.r-project.org/web/packages/Hmisc/index.html)

<br>

* **Install in the following order**
1. ```install.packages("BiocManager", dependencies = TRUE)```
2. ```BiocManager::install("limma")```
3. ```install.packages("tidyverse", dependencies = TRUE)```
4. ```install.packages("Hmisc", dependencies = TRUE)```

<br>

* **User-defined functions**
1. *Conversion of list to DataFrame* - The function accepts two lists and make dataframe out of them. This function is used by the user-fdefined```meta_make()``` function to make metadat for design matrix
```
list_to_df <-function(list1, list2){
  n <- c()
  for(x in list1){
    n<-c(n, x)}
  for(y in list2){
    n<-c(n, y)}
  n<- as.data.frame(n)
  return(n)
}
```
2. *Making the metadata for making design Matrix* - Function accepts expression data as a dataframe and makes a metadata file using the column names of the expression data. The function needs 4 parameters i.e. 2-Group definitions and 2-Group indexes. The function only works with two group experiments or two group testings.  
```
meta_make <- function(temp_df, ind_set1,set1, ind_set2, set2){
  s1 <- list(rep(set1,ind_set1))
  s2 <- list(rep(set2,ind_set2))
  g <- list_to_df(s1,s2)
  samp_names <- as.data.frame(colnames(temp_df))
  colnames(samp_names)<- "sample_id"
  temp_meta <- cbind(samp_names, g)
  names(temp_meta)[2]<- "groups"
  return(temp_meta)
}
```
3. *Finding based on statistics of the t-test* - Function accepts DataFrame of the t-test results from ```limma```. The index of the columns are also passed along with the cut-off filter i.e. ```0.03``` for ```adj.p-value``` and ```0.01``` for ```p-value```. The upregulated and downregulated genes are filtered with ```LogFC``` with ```<-0.5``` as down-regulated and ```>0.5``` as up-regulated.
```
aftermath <- function(temp_df2, pvalue, p_index, fdr, adj_index){
  temp_df2 <- temp_df2[which(temp_df2[,p_index] < as.numeric(pvalue)),]
  temp_df2 <- temp_df2[which(temp_df2[,adj_index] < as.numeric(fdr)),]
  return(temp_df2)
}
```
