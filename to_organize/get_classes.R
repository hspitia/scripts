#!/usr/bin/env Rscript

################################################################################
# Author:   Hector Fabio Espitia Navarro
#           Georgia Institute of Technology
#           
# Version:  1.0
# Date:     07/26/2016
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

# cl = read.delim("svmrfe/class.file.csv")
# fds = getFolds(cl$class, 5)
# lapply(fds, function(l) {cl$genome[l]})

# Get the script name
initial.options <- commandArgs(trailingOnly = FALSE)
script.name <- basename(sub("--file=", "", initial.options[grep("--file=", initial.options)]))

# Process command line arguments
# Create a parser
p <- arg_parser("Get class from genome name",
                name = script.name)
# Add command line arguments
p <- add_argument(p, "names_file", help = "Matrix file")
p <- add_argument(p, "metadata_file", help = "Metadata file")
p <- add_argument(p, "class_column", help = "Number of column of metadata table that describes the class")
p <- add_argument(p, "--output", help = "Output filename", default = "classes.tsv")
# Parse the command line arguments
argv <- parse_args(p)

# Variables initialization
command.line = T
if(command.line) {
    names.file    <- argv$names_file
    metadata.file <- argv$metadata_file
    class.column  <- as.numeric(argv$class_column)
    output.file   <- argv$output
} else {
    # Values to test the script from rstudio
    names.file    <- "/home/hspitia/projects/nthi/svmrfe/ds1/names.txt"
    metadata.file <- "/home/hspitia/projects/nthi/data/metadata/metadata_merged.csv"
    class.column  <- 7
    output.file   <- "/home/hspitia/projects/nthi/svmrfe/ds1/classes.tsv"
}

################################################################################
# Load data

# names
cat('Loading names ...\n')
names = scan(names.file, what = "character")
cat(paste0(length(names), ' names loaded\n'))
flush.console()

# Read metadata table # *********
cat('Loading metadata ... ')
metadata = read.delim(metadata.file, row.names = 1, check.names = F)
rownames(metadata) = metadata$name
cat("Done!\n\n")
flush.console()

# check column names (genomes)
cat('Columns available in the metadata table:\n')
colnames(metadata)
cat('\n')
flush.console()

if (class.column > ncol(metadata)) 
    stop("Class column value must be lesser or equal to the number of available columns in the meteadata file!\n\n")

class.data = data.frame(genome = names, class = "") 
class.data$class = metadata[names, class.column]

cat('\nPreview of the output class file:\n')
head(class.data)

write.table(x = class.data, file = output.file, 
            sep = "\t", quote = F, row.names = F,
            col.names = T) # *********
if(file.exists(output.file)) {
    cat(paste0("\nClass file saved to \'", output.file,"\'\n"))
} else {
    cat(paste0("\nOutput file \'", output.file,"\' could not be written\n"))
}
flush.console()

# rownames(class.data) = class.data$genome
# head(class.data)
# print(class(class.column))
# head(metadata[names, c(1, class.column)])

# # Get the gene names from the rank list
# gene.list = colnames(in.data)[rank.list]
# # head(gene.list)
# 
# # save to a file the top-n features
# if(is.na(top.features)) top.features <- length(gene.list)
# 
# out.features = gene.list[1:top.features]
# flush.console()
# write(x = out.features, file = output.file) # *********
# if(file.exists(output.file)) {
#     cat(paste0("Features list saved to \'", output.file,"\'\n"))
# } else {
#     cat(paste0("Output file \'", output.file,"\' could not be written\n"))
# }
#============================================================================
