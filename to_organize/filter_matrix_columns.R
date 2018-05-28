#!/usr/bin/env Rscript

################################################################################
# Author:   Hector Fabio Espitia Navarro
#           Georgia Institute of Technology
#           
# Version:  1.0
# Date:     08/03/2016
# ==============================================================================
# 
################################################################################

# Install required packages
personal.lib.path = Sys.getenv("R_LIBS_USER")
if(!file.exists(personal.lib.path))                                                                                    
    dir.create(personal.lib.path)

packages <- c("argparser")
if(any(!(packages %in% installed.packages()))){
    cat("Please wait a moment! Installing required packages ...\n")
    install.packages(packages[!(packages %in% installed.packages())], 
                     quiet = T, repos="http://cran.rstudio.com/",
                     lib = personal.lib.path)
    cat("Required packages installed!\n")
}

# Load packages
suppressPackageStartupMessages(library(argparser, quietly = TRUE))

################################################################################

# Get the script name
initial.options <- commandArgs(trailingOnly = FALSE)
script.name <- basename(sub("--file=", "", initial.options[grep("--file=", initial.options)]))

# Process command line arguments
# Create a parser
p <- arg_parser("Runs SVM-RFE",
                name = script.name)
# Add command line arguments
p <- add_argument(p, "matrix_file", help = "Matrix file")
p <- add_argument(p, "col_names", help = "Column names to filter out")
p <- add_argument(p, "--output", help = "Output filename", default = "filtered_matrix.txt")
# Parse the command line arguments
argv <- parse_args(p)

# Variables initialization
command.line = TRUE
if(command.line) {
    matrix.file   <- argv$matrix_file
    col.names     <- argv$col_names
    output.file   <- argv$output
} else {
    # Values to test the script using rstudio
    # input.file    <- "ANI_Distance.tsv"
    matrix.file   <- "svmrfe/ds2/matrix.txt"
    col.names     <- "svmrfe/ds1/missing_genomes.txt"
    output.file   <- "svmrfe/ds1/filtered_matrix.txt"
}

################################################################################
# Load data
cat('Loading matrix ... ')
matrix.data = read.delim(matrix.file, stringsAsFactors = FALSE, check.names = FALSE, row.names = 1)
cat("Done!\n")
cat(paste(nrow(matrix.data), "rows x", ncol(matrix.data), "cols loaded\n"))
flush.console()

cat('Loading columns to filter out ... ')
cat("Done!\n")
columns.to.filter = scan(col.names, what = "character", quiet = T)
cat(paste(length(columns.to.filter), "cols loaded\n"))
flush.console()

cat('Filtering columns ... ')
filtered.matrix = matrix.data[, !(colnames(matrix.data) %in% columns.to.filter)]
cat("Done!\n")
flush.console()
write.table(filtered.matrix, file = output.file, 
            sep = "\t", col.names = T, row.names = T, quote = FALSE)

if(file.exists(output.file)) {
    cat(paste0("Filtered matrix saved to \'", output.file,"\'\n"))
} else {
    cat(paste0("Output file \'", output.file,"\' could not be written\n"))
}
flush.console()
