# Load library
library(data.table)
library(tidyverse)
library(Hmisc)

# Function for correlation cut-off
corr_cut <- function(temp_df3, cut, cor_index){
  
  # making negative cut-off
  cut_n <- cut * -1
  
  # positive cut-off
  temp_df3_p <- temp_df3[which(temp_df3[,cor_index] > cut),]
  
  # negative cut-off
  temp_df3_n <- temp_df3[which(temp_df3[,cor_index] < cut_n),]
  
  # join 
  joined <- as.data.frame(rbind(temp_df3_p, temp_df3_n))
  
  # Returning the list of 3 DataFrames
  return(joined)
}

# Function to find correlations
find_p_corr <- function(cor_df, p_cut, p_ind, fdr_cut, fdr_ind, cor_cut, cor_ind){
  
  # transpose
  cor_df <- t(cor_df)
  
  # Running correlations
  cor_df  <- rcorr(as.matrix(cor_df, type = "pearson"))
  
  # Extracting columns of interest
  cor_df <- as.data.frame(flattenCorrMatrix(cor_df$r, cor_df$P))
  
  # Calculating FDR
  cor_df$adj.p_.al_FDR <- p.adjust(p = cor_df$p, method = "bonferroni")
  
  # considering correlations with high significance
  cor_df <- aftermath(as.data.frame(cor_df), p_cut, p_ind, fdr_cut, fdr_ind)
  
  # Subsetting based on correlation coeff
  cor_df <- corr_cut(cor_df, cor_cut, cor_ind)
  
  return(as.data.frame(cor_df))
}

# Function to convert S3 obj. to matrix
flattenCorrMatrix <- function(cormat, pmat) {
  ut <- upper.tri(cormat)
  data.frame(
    row = rownames(cormat)[row(cormat)[ut]],
    column = rownames(cormat)[col(cormat)[ut]],
    cor  =(cormat)[ut],
    p = pmat[ut]
  )
}

# Function to filter out significant element Significance
aftermath <- function(temp_df2, pvalue, p_index, fdr, adj_index){
  # p-value cut-off
  temp_df2 <- temp_df2[which(temp_df2[,p_index] < as.numeric(pvalue)),]
  
  # FDR Cut-off
  temp_df2 <- temp_df2[which(temp_df2[,adj_index] < as.numeric(fdr)),]
  
  # Returning the list of 3 DataFrames
  return(temp_df2)
}

# Names
accession <- "GSE14905"
exp <- "expression_set.csv"
up_down <- "deg_significant_stats.csv"
corrs <- "significant_corr_stats.csv"

# Loading significant stats Data
sgni_data <- as.data.frame(read.csv(paste(accession, up_down, sep = "_")))

# Taking column of interest
sgni_data <- data.frame(X = as.vector(sgni_data$X))

# Splitting probe ids
sgni_data <- as.data.frame(sgni_data %>% separate_rows(X, sep = " | "))

# Drooping symbol
sgni_data <- sgni_data[!sgni_data$X == "|", ]

# Removing Duplicates
sgni_data <- data.frame(X = as.vector(sgni_data[!duplicated(sgni_data)]))

# Loading the Raw Expression data
e_data <- as.data.frame(read.csv(paste(accession,exp, sep = "_")))

# Extracting data for the significant genes
signi_e_data <- merge(sgni_data, e_data, by = "X")

# Making row-names
rownames(signi_e_data) <- signi_e_data$X

# Removing column x
signi_e_data <- subset(signi_e_data, select = -X )

# finding correlations
corr_elements <- find_p_corr(signi_e_data, 0.01, 4, 0.01, 5, 0.95, 3)

# Saving corr_stats
fwrite(corr_elements, file = paste(accession, corrs, sep = "_"), sep = ",", row.names = FALSE)
