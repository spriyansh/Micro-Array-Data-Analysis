library(biomaRt)
library(data.table)

accession <- "GSE14905" 
tail <- "significant_corr_stats.csv"
tail2 <- "significant_mechanistic.csv" 

df <- read.csv(paste(accession, tail, sep = "_"), header = TRUE)

row <- as.vector(df$row)
column <- as.vector(df$column)

ensembl = useEnsembl(biomart="ensembl", dataset="hsapiens_gene_ensembl")

row_anno <- as.data.frame(getBM(attributes=c('hgnc_symbol','chromosome_name','start_position','end_position'),
                                filters = 'hgnc_symbol', values = row, mart = ensembl))
colnames(row_anno) <- c("row", "row_chromosome", "row_start_bp", "row_stop_bp")

columns_anno <- as.data.frame(getBM(attributes=c('hgnc_symbol','chromosome_name','start_position','end_position'),
                                    filters = 'hgnc_symbol', values = column, mart = ensembl))
colnames(columns_anno) <- c("column", "column_chromosome", "column_start_bp", "column_stop_bp")

r_merge <- merge(df, row_anno, by = "row")
c_merge <- merge(r_merge, columns_anno, by = "column")

merged <- c_merge[c_merge$row_chromosome == c_merge$column_chromosome,]

merged$distance <- merged$row_start_bp -  merged$column_start_bp

fwrite(merged,paste(accession, tail2, sep = "_"), sep = ",")
