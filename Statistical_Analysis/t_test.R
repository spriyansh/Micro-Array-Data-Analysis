# Library
library(data.table)
library(limma)
library(tidyverse)
library(dplyr)
library(stringr)
library(Hmisc)

# Function to convert List to DataFrame
list_to_df <-function(list1, list2){
  n <- c()
  for(x in list1){
    n<-c(n, x)
  }
  for(y in list2){
    n<-c(n, y)
  }
  n<- as.data.frame(n)
  return(n)
}

# Function to make meta data
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

# Names
accession <- "GSE14905"
exp <- "expression_set.csv"
pheno <- "pheno_set.csv"
feat <- "feature_set.csv"
st <- "all_stats.csv"
ups <- "deg_up_stats.csv"
downs <- "deg_downs_stats.csv"
up_down <- "deg_significant_stats.csv"
corrs <- "significant_corr_stats.csv"

# Load data
e_data <- read.csv(paste(accession,exp, sep = "_"), row.names = 1)
p_data <-read.csv(paste(accession,pheno, sep = "_"), row.names = 1)

# Make the metadata
meta_data <- meta_make(e_data,21,"control", 61, "experiment")

# Making factors as labels
design_factors <- factor(make.names(meta_data$groups))

# Making Design Matrix
design <- model.matrix(~ design_factors + 0)

# Renaming columns
colnames(design) <- levels(design_factors)

# Fitting to linear Models
fit <- lmFit(e_data, design)

# Making Contrast Matrix
cont.matrix <- makeContrasts(disease_vs_healthy = experiment-control,levels=design)

# Fitting contrast matrix to linear Models
fit2  <- contrasts.fit(fit, cont.matrix)

# Emperical Bayes
fit2  <- eBayes(fit2, 0.01)

# Extracting data
tT <- topTable(fit2, adjust="fdr", number = nrow(fit2))

# Writting files
fwrite(as.data.frame(tT), paste(accession,st, sep = "_"), sep = ",", row.names = TRUE)
