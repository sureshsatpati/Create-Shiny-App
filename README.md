# Create-Shiny-App

This repository contains code and resources for creating an interactive Shiny app designed for visualizing and analyzing single-cell data, including RNA-seq and ATAC-seq results. The app enables users to explore and interact with multi-omic datasets, providing an intuitive interface for visual exploration of gene expression, chromatin accessibility, and other genomic features.

Key Features:

Interactive Visualizations: Provides dynamic plots such as heatmaps, PCA, t-SNE, UMAP, and violin plots for exploring single-cell gene expression and chromatin accessibility.

Customizable Filters: Users can apply filters to explore specific cell types, genes, or genomic regions, and visualize differential expression or accessibility.

Multi-omic Data Integration: Combines results from different assays (e.g., scRNA-seq, scATAC-seq) for integrated analysis and exploration.

Real-time Analysis: Supports running analyses in real-time, providing immediate feedback as users interact with the data.

User-friendly Interface: Easy-to-use UI designed for both bioinformaticians and biologists to explore complex datasets without requiring coding experience.

Requirements:

R (for Shiny app development)

ShinyCell (for building the interactive web application)

ggplot2 (for data visualization)

# Code
library(Seurat)

library(ArchR)

library(ShinyCell2)

options(future.seed = TRUE)

options(future.globals.maxSize = 800 * 1024^3)

archr_obj <- loadArchRProject("/rsrch3/home/genomic_med/ssatpati/Tcell_Exaustion/3.Analysis-Mito0/Common_Cells/ArchR-Save-after-Motif")

scConf <- createConfig(archr_obj)

..Remove metadata columns that contain minimal or redundant information..
scConf <- delMeta(scConf, c("ReadsInTSS", "ReadsInPromoter", "ReadsInBlacklist",
                            "NucleosomeRatio", "nMultiFrags", "nMonoFrags",
                            "nFrags", "nDiFrags", "ReadsInPeaks"))

makeShinyFiles(archr_obj, scConf = scConf, dimred.to.use = "UMAP_ATAC",
     bigWigGroup = c("Clusters"), shiny.prefix = "sc1",
     shiny.dir = "shinyApp_track_plots/",
     default.gene1 = "IRF1", default.gene2 = "GATA2", chunkSize = 500)

makeShinyCodes(shiny.prefix = "sc1",
               shiny.dir = "./shinyApp_track_plots/",
               shiny.title = "scATAC-seq")

