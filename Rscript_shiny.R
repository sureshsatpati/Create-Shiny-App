library(Seurat)
library(ArchR)
library(ShinyCell2)
options(future.seed = TRUE)
options(future.globals.maxSize = 800 * 1024^3)
archr_obj <- loadArchRProject("/rsrch3/home/genomic_med/ssatpati/Tcell_Exaustion/3.Analysis-Mito0/Common_Cells/ArchR-Save-after-Motif")

scConf <- createConfig(archr_obj)

# Remove metadata columns that contain minimal or redundant information
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

