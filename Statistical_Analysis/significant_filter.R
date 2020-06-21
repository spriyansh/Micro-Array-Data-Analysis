# Library
library(data.table)
library(limma)
library(tidyverse)

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
pheno <- "pheno_set.csv"
feat <- "feature_set.csv"
st <- "all_stats.csv"
ups <- "deg_up_stats.csv"
downs <- "deg_downs_stats.csv"
up_down <- "deg_significant_stats.csv"

# Load data
results <- as.data.frame(read.csv(paste(accession,st, sep = "_"), row.names = 1))

# Filtering
results <- as.data.frame(aftermath(results, 0.01, 4, 0.01, 5))

# Writting files
fwrite(results, paste(accession,st, sep = "_"), sep = ",", row.names = TRUE)

# Reading files with NA
anno <- read.csv(paste(accession,feat, sep = "_"), na.strings=c("","NA"))

# Selecting columns of Interest
anno <- anno[,c("X","Gene.symbol","Gene.title","Gene.ID","GenBank.Accession")]

# Reading files with 
stats <- read.csv(paste(accession,st, sep = "_"))

# outer join
annotated <- merge(stats, anno, by = "X")

# Remove un-annotated genes
annotated <- annotated %>% drop_na()

# Splitting
annotated <- as.data.frame(annotated %>% separate_rows(Gene.symbol,Gene.title, Gene.ID, sep = "///"))

# Sorting
annotated <- annotated[order(annotated$Gene.symbol),]

# Merging
annotated <- as.data.frame(annotated %>%
                             group_by(Gene.symbol) %>%
                             filter(across(c("logFC"), ~ n_distinct(sign(.)) == 1)) %>%
                             summarise(across(c("logFC","P.Value","adj.P.Val","B","AveExpr","t"), mean), X = str_c(X, collapse= " | "),
                                       Gene.title = str_c(Gene.title, collapse= " | "), Gene.ID = str_c(Gene.ID, collapse= " | "),
                                       GenBank.Accession = str_c(GenBank.Accession, collapse= " | ")))

# Up
up <- annotated[(as.numeric(as.character(annotated[,2])) > 0.5),]

# down
down <- annotated[(as.numeric(as.character(annotated[,2])) < -0.5),]

# Significant
signi <- rbind(up, down)

# Writing the Data
fwrite(as.data.frame(signi), file = paste(accession, up_down, sep = "_"), sep = ",")
fwrite(as.data.frame(up),file = paste(accession, ups, sep = "_"), sep = ",")
fwrite(as.data.frame(down), file = paste(accession, downs, sep = "_"), sep = ",")
