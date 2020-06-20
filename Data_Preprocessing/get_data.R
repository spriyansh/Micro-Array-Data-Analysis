# Library
library(GEOquery)
library(data.table)
library(genefilter)

# Names
accession <- "GSE14905"
platform <- "GPL570"
exp <- "expression_set.csv"
pheno <- "pheno_set.csv"
feat <- "feature_set.csv"

# load series and platform data from GEO
gset <- getGEO(accession, GSEMatrix =TRUE, AnnotGPL=TRUE)
if (length(gset) > 1) idx <- grep(platform, attr(gset, "names")) else idx <- 1
gset <- gset[[idx]]
fvarLabels(gset) <- make.names(fvarLabels(gset))

# log2 transform
ex <- exprs(gset)
qx <- as.numeric(quantile(ex, c(0., 0.25, 0.5, 0.75, 0.99, 1.0), na.rm=T))
LogC <- (qx[5] > 100) ||
  (qx[6]-qx[1] > 50 && qx[2] > 0) ||
  (qx[2] > 0 && qx[2] < 1 && qx[4] > 1 && qx[4] < 2)
if (LogC) { ex[which(ex <= 0)] <- NaN
exprs(gset) <- log2(ex) }

# Filtering out Low variations
exp_set <- varFilter(exprs(gset), var.func=IQR, var.cutoff=0.5, filterByQuantile=TRUE)

# Save this Sheet
fwrite(as.data.frame(exp_set), file = paste(accession,exp, sep = "_"), sep = ",", row.names = TRUE)
fwrite(as.data.frame(pData(gset)), file = paste(accession,pheno, sep = "_"), sep = ",", row.names = TRUE)
fwrite(as.data.frame(fData(gset)), file = paste(accession,feat, sep = "_"), sep = ",", row.names = TRUE)