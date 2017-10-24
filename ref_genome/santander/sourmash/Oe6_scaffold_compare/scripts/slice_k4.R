k4_comp <- read.csv("data/Oe6_scaffolds_k4.comp.csv")
head(k4_comp)
k4_comp
grep("X8959.scaffold.fa", colnames(k4_comp))

# return column names where column mean is less than .4
k4_comp_slice <- colnames(k4_comp[colMeans(k4_comp) < .4])

# scaffold numbers do not reflect contig names, but do reflect the file names.
# scaffold 2534 contains the 02653 bacterial contamination.

write.table(x = k4_comp_slice, file = "data_out/low_k4_similarity.txt", quote = F, row.names = F, col.names = F)

