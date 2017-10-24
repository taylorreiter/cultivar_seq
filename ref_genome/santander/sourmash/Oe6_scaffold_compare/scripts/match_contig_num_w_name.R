# import list of file names generated on linux computer that had low tetranucleotide similarity to the rest of the olive reference genome
low_sim <- read.table("data_out/low_k4_similarity.txt")

# Use regex to select the contig number, and write this to a vector
library(stringr)
regex <- "[0-9]+"
contig_num <- sapply(X = low_sim, function(x) str_extract(x, pattern = regex))
contig_num <- as.numeric(contig_num)

# import contig name list
all_contigs <- read.table("data/scaffold_names.txt")
head(all_contigs)
num_vector <- seq(1, nrow(all_contigs))
all_contigs <- cbind(all_contigs, num_vector)

contam_contigs <- all_contigs[all_contigs$num_vector %in% contig_num, ]

write.table(contam_contigs[[1]], file = "data_out/suspicious_contig_names.txt", quote = FALSE, sep = "\n", row.names = FALSE, col.names = FALSE)
