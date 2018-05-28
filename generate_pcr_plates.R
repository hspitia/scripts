# tool factory Rscript parser suggested by Forester
# http://www.r-bloggers.com/including-arguments-in-r-cmd-batch-mode/
# additional parameters will appear in the ls() below - they are available
# to your script
# echo parameters to the output file
ourargs = commandArgs(TRUE)
if(length(ourargs) == 0) {
  print("No arguments supplied.")
} else {
  
  for(i in 1:length(ourargs)){
    eval(parse(text=ourargs[[i]]))
  }
  
  if (!toupper(ordenmuestras) %in% c("F", "C")) {
    sink(OUTPATH)
    cat("ERROR. Opcion incorrecta en el parametro. \"Orden muestras\".\n\nSolo son permitidas las opciones \"f\" o \"c\".\nPor favor corrija el valor e intente nuevamente.")
    cat("\n")
    sink()
  } else {
    #   sink(OUTPATH)
    #   cat('INPATHS=',INPATHS,'\n')
    #   cat('INNAMES=',INNAMES,'\n')
    #   cat('OUTPATH=',OUTPATH,'\n')
    
    # outfile
    outf = OUTPATH

    # Get the input file name
    inf      = unlist(strsplit(INPATHS[[1]], "[,]"))[1]
    inf.name = unlist(strsplit(INNAMES[[1]], "[,]"))[1]
    
    # Reading data
    in.data = scan(file = inf, what = character(), sep = "\n", quiet = T)
    
    # Define order of samples
    s_byrows = TRUE
    if (toupper(ordenmuestras) == "C") s_byrows = FALSE # Samples ordered by columns
    
    # Define samples and controls
    samples  = in.data[(ncontroles+1):length(in.data)]
    controls = c()
    if (ncontroles > 0) {
      controls  = in.data[1:ncontroles]
    }
    
    # Expand samples names
    expanded_samples = c()
    if(nexpansiones > 0) {
      for(name in samples) {
        c_expansion = paste(name, LETTERS[1:nexpansiones], sep = ".")
        expanded_samples = c(expanded_samples, c_expansion)
      }
    } else {
      expanded_samples = samples
    }
    
    # Create PCR plates
    rows             = nfilas
    cols             = ncolumnas
    n.samples.plate  = (rows * cols) - length(controls)
    n.samples        = length(expanded_samples)
    
    empty.row = rep(" ", cols)
    n.plates  = ceiling(n.samples / n.samples.plate)
    
    plate.design = NULL
    for(i in 0:(n.plates - 1)){
      start = (i * n.samples.plate) + 1
      end   = start + n.samples.plate - 1
      
      plate = NULL
      if(i == (n.plates - 1)){ # last plate?
        end = n.samples
      }
      
      # compute the number of empty samples at end of plate
      complement = (rows * cols) - (length(expanded_samples[start:end]) + length(controls))
      
      # generate current plate
      plate = matrix(data = c(expanded_samples[start:end], controls, rep("", complement)), nrow = (rows), ncol = cols, byrow = s_byrows)
      # put empty row to separate plates in CSV file
      plate = rbind(plate, rep("", cols))
      # merge current plate to whole plate design
      plate.design = rbind(plate.design, plate)
    }
    
    # save to file
    write.table(x = plate.design, file = outf, sep = "\t", row.names = FALSE, col.names = FALSE)
    # #=======================
    # x=ls()
    # cat('Existe el archivo: ', file.exists(inf),'\n')
    # cat('Working directory: ', getwd(),'\n')
    # 
    # cat('all objects=',x,'\n')
    # for(v in x) {cat(eval(parse(text = v)),'\n')}
    # sink()
    # #=======================  
  }
}
sessionInfo()
print.noquote(date())