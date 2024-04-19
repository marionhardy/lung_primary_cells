
## This assumes that you have a counts dataframe 

library(DESeq2)
library(tidyverse)
library(ggrepel)
library(RColorBrewer)
library(pheatmap)

# Create the coldata for the summarized experiment

coldata = data.frame(
  celltype = c(rep('primary_lung',each = 12)),
  treatment = rep(c("Control","Pitavastatin","Cytokine",
                              "Pitava_Cyto"), each = 3, times = 1),
  ID = c("ZEKI0001","ZEKI0002","ZEKI0003","ZEKI0004",
         "ZEKI0005","ZEKI0006","ZEKI0007","ZEKI0008",
         "ZEKI0009","ZEKI0010","ZEKI0011","ZEKI0012"),
  replicate=as.factor(rep(c(1:3),4)))

rownames(coldata) = coldata$ID

write.csv(coldata,"./data/coldata.csv")

# Read your counts, here it's from a .txt used for statistics given to me by Nick

counts = as.data.frame(read.table("./data/chmiel_rnaseq_2022_counts.txt", header = TRUE))
counts$id = rownames(counts)

# Verify that 

table(colnames(counts)[-13] == rownames(coldata))

# Remove the gene version from the annotation

strrep =
  sub(pattern = "\\.(.*)","",counts$id)

counts$id = strrep
counts = counts[!duplicated(counts$id),]

## Expression analysis of

rownames(counts) = counts$id
counts = counts[,-13]

# Comparing all treatments
# Create the full model for comparison of samples

dds <- DESeqDataSetFromMatrix(countData = counts, colData = coldata,
                              design = ~treatment) 

# Generate a linear model

dds$treatment <- relevel(dds$treatment, "Control")
dds <- DESeq(dds)

resultsNames(dds)

# Checking size factors and dispersion

sizeFactors(dds) # those size factors look ok! 

res = results(dds)
plotMA(res)

# Checking PCA

rld <- vst(dds)

plotPCA(rld,intgroup="treatment") + 
  geom_text_repel(max.overlaps = 15,
                  box.padding = 0.25,
                  segment.color = 'grey50',
                  fontface = "italic",
                  label = rld$treatment)+
  theme_bw()+
  labs(title = 'PCA per treatment')


plotPCA(rld,intgroup="replicate") + 
  geom_text_repel(max.overlaps = 15,
                  box.padding = 0.25,
                  segment.color = 'grey50',
                  fontface = "italic",
                  label = rld$replicate)+
  theme_bw()+
  labs(title = 'PCA per treatment')


saveRDS(dds,"./data_output/dds.Rds")

