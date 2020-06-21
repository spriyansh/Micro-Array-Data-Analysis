# Library
library(data.table)
library(tidyverse)

# Names
accession <- "GSE14905"
feat <- "feature_set.csv"
up_down <- "deg_significant_stats.csv"
corrs <- "significant_corr_stats.csv"

# Loading data
corr_stats <- read.csv(paste(accession, corrs, sep = "_"))
corr_stats <- corr_stats[,c("row","column","cor")]

# Reading files with NA
anno <- read.csv(paste(accession,feat, sep = "_"), na.strings=c("","NA"))

# Selecting columns of Interest
anno <- anno[,c("X","Gene.symbol","Gene.title","Gene.ID","GenBank.Accession")]

# subsetting columns
row <- as.data.frame(corr_stats$row)
col <- as.data.frame(corr_stats$column)
coefs <- as.data.frame(corr_stats$cor)

# Renaming subsets
colnames(row) <- "X"
colnames(col) <- "X"
colnames(coefs) <- "corr_coeff"

# outer join with X
row_anno <- merge(row, anno, by = "X")
col_anno <- merge(col, anno, by = "X")

# joining back the dataframe
corr_stats <- cbind(row_anno,col_anno, coefs)

# selecting columns
corr_stats <- corr_stats[, c(2, 7,11)] 

# Renaming columns
colnames(corr_stats) <- c("row", "column", "corr_coeff")

# Splitting columns one by one
corr_stats <- as.data.frame(corr_stats %>% separate_rows(row, sep = "///"))
corr_stats <- as.data.frame(corr_stats %>% separate_rows(column, sep = "///"))

# Removing duplicates simulatneously
corr_stats <- corr_stats[!duplicated(corr_stats[c(1,2)]),]

# Saving the stats
fwrite(corr_stats, file = paste(accession, corrs, sep = "_"), sep = ",", row.names = FALSE)

# Loading the data for mapping
s_cors <- read.csv(paste(accession, corrs, sep = "_"))
reg_status <- read.csv(paste(accession, up_down, sep = "_"))

# choosing column of interst
reg_status <- cbind(as.data.frame(reg_status$Gene.symbol),as.data.frame(reg_status$logFC))
colnames(reg_status) <- c("X", "logFC")
colnames(s_cors) <- c("X","X2", "corr")

# Mapping the regulation status
Xmapped <- merge(reg_status, s_cors, by = "X")
colnames(Xmapped) <- c("row","row_logFC", "X", "corr")
mapped <- merge(reg_status, Xmapped , by = "X")
colnames(mapped) <- c("column","columns_logFC", "row","row_logFC", "corr")

# Removing conflicts
mapped <- mapped[sign(as.numeric(mapped$row_logFC))==sign(as.numeric(mapped$columns_logFC)),]

# Saving the Data
fwrite(mapped, file = paste(accession, corrs, sep = "_"), sep = ",", row.names = FALSE)
