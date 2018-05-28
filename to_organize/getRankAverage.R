#!/usr/bin/env Rscript

################################################################################
# Author:   Hector Fabio Espitia Navarro
#           Georgia Institute of Technology
#           
# Version:  1.3
# Date:     08/09/2016
# ==============================================================================
# 
################################################################################

# Install required packages
personal.lib.path = Sys.getenv("R_LIBS_USER")
if(!file.exists(personal.lib.path))                                                                                    
    dir.create(personal.lib.path)

packages <- c("argparser", "e1071")
if(any(!(packages %in% installed.packages()))){
    cat("Please wait a moment! Installing required packages ...\n")
    install.packages(packages[!(packages %in% installed.packages())], 
                     quiet = T, repos="http://cran.rstudio.com/",
                     lib = personal.lib.path)
    cat("Required packages installed!\n")
}

# Load packages
suppressPackageStartupMessages(library(argparser, quietly = TRUE))
suppressPackageStartupMessages(library(e1071, quietly = TRUE))

# ############################################################################

# Get the script name
initial.options <- commandArgs(trailingOnly = FALSE)
script.name <- basename(sub("--file=", "", initial.options[grep("--file=", initial.options)]))

# Process command line arguments
# Create a parser
p <- arg_parser("Compute the rank average from multiple rank lists",
                name = script.name)
# Add command line arguments
p <- add_argument(p, "matrix_file", help = "Matrix file used to perform the SVMRFE (without features with the same value along of all the genomes)")
p <- add_argument(p, "rank_files_list", help = "File with a list of rank files")
# p <- add_argument(p, "--rem_features_file", help = "Removed features file")
p <- add_argument(p, "--output", help = "Output filename", default = "average_rank.txt")
# Parse the command line arguments
argv <- parse_args(p)

# Variables initialization
command.line = T
if(command.line) {
    matrix.file       <- argv$matrix_file
    list.file         <- argv$rank_files_list
    rem.features.file <- argv$rem_features_file
    print(rem.features.file)
    output.file       <- argv$output
} else {
    # Values to test the script using rstudio
    # matrix.file       <- "svmrfe/04.new_no_NT25364_70%/datasets/ds1/matrix.txt"
    matrix.file       <- "svmrfe/04.new_no_NT25364_70%/datasets/ds1/matrix.txt.cols_removed.txt"
    list.file         <- "svmrfe/04.new_no_NT25364_70%/results/01_no_cv/ds1.results_list.txt"
    rem.features.file <- "svmrfe/04.new_no_NT25364_70%/datasets/ds1/ds1.removed_features.txt"
    output.file       <- "svmrfe/04.new_no_NT25364_70%/results/01_no_cv/ds1.average_rank.txt"
}

################################################################################
# Load data

# Read LS-BSR table # *********
cat('Loading matrix... ')
in.table <- read.delim(matrix.file, row.names = 1, check.names = F)
cat("Done!\n")
flush.console()



# files list
cat('Loading results files list .. ')
file.list <- scan(file = list.file, what = "character")
cat("Done!\n")
flush.console()

# # removed features
# removed.features = c()
# if (!is.na(rem.features.file)){
#     cat('Loading removed features... ')
#     removed.features <- scan(file = rem.features.file, what = "character")
#     cat("Done!\n")
#     flush.console()
# }

feature.names <- rownames(in.table)
# feature.names <- feature.names[!(feature.names %in% removed.features)]

cat('Loading results files list ...')
file.list <- scan(file = list.file, what = "character")
cat("Done!\n")
flush.console()

cat('Processing results files...\n')
ranking.results <- lapply(file.list, function(x) {
    cat(paste(x, " "))
    flush.console()
    ranked.features <- scan(file = x, what = "character")
    indices <-
        unlist(lapply(ranked.features, function(x)
            which(x == feature.names)))
})

cat("Done!\n")
flush.console()

cat('Computing ranking average... ')
flush.console()
sort.res = sort(apply(sapply(ranking.results, function(x)
    sort(x, index.return = T)$ix), 1, mean), index = T)

feature.ids  <- sort.res$ix
rank.average <- sort.res$x

ranked.feature.names = feature.names[feature.ids]

ranked.features.data = data.frame(FeatureName = ranked.feature.names,
                                  FeatureID = feature.ids,
                                  AvgRank = rank.average)
cat("Done!\n\n")
flush.console()

cat("Preview of results:\n\n")
flush.console()
head(ranked.features.data)

write.table(ranked.features.data, file = output.file, quote = F, row.names = F)

cat(paste("\nResults saved to '"), output.file, "'\n", sep = "")
flush.console()



