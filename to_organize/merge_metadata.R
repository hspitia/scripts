metadata = read.delim("data/metadata/metadata.csv", header = T, check.names = F)
head(metadata)

cdc.metadata = read.delim("data/metadata/Hi_initial_classification_LDRR_06-09-2016.csv", header = T, check.names = F)
head(cdc.metadata)

merged.metadata = merge(x = metadata, y = cdc.metadata,
                        by.x = "name", by.y = "Lab_Id", all = T)

merged.metadata
merged.metadata = cbind(merged.metadata$n, merged.metadata[,-2])

write.table(x = merged.metadata, file = "data/metadata/metadata_merged.csv", 
            sep = "\t", row.names = F, col.names = T, na = "")
