#  Loading library
library(biomaRt)
library(data.table)

# Defining the names
accession <- "GSE14905" 
tail <- "significant_corr_stats.csv"
tail2 <- "significant_mechanistic.csv" 

# reading the correlated pairs
df <- read.csv(paste(accession, tail, sep = "_"), header = TRUE)

# Extracting rows and columns for annotations
row <- as.vector(df$row)
column <- as.vector(df$column)

# Selecting database for annotations
ensembl = useEnsembl(biomart="ensembl", dataset="hsapiens_gene_ensembl")

# Annotating the rows and columns
row_anno <- as.data.frame(getBM(attributes=c('hgnc_symbol','chromosome_name','start_position','end_position'),
                                filters = 'hgnc_symbol', values = row, mart = ensembl))
colnames(row_anno) <- c("row", "row_chromosome", "row_start_bp", "row_stop_bp")

columns_anno <- as.data.frame(getBM(attributes=c('hgnc_symbol','chromosome_name','start_position','end_position'),
                                    filters = 'hgnc_symbol', values = column, mart = ensembl))
colnames(columns_anno) <- c("column", "column_chromosome", "column_start_bp", "column_stop_bp")

# Merging back to the original DataFrame
r_merge <- merge(df, row_anno, by = "row")
c_merge <- merge(r_merge, columns_anno, by = "column")

# Dropping pairs with different chromosomal locations
merged <- c_merge[c_merge$row_chromosome == c_merge$column_chromosome,]

# Calculating the distance between the start points
merged$distance <- merged$row_start_bp -  merged$column_start_bp

# Saving the results
fwrite(merged,paste(accession, tail2, sep = "_"), sep = ",")
