setwd("/Users/taylorreiter/Desktop/sourmash_results/")

# Read in relevant csvs
jgi_names_key<-read.csv("jgi_names2.csv")


Oe6_fungi_k21_s10k<-read.csv("Oe6_scaled_10k/fungi_k21_s10k_Oe6.scaffolds.fa.txt.csv", header = T) 
Oe6_microbes_k21_s10k<-read.csv("Oe6_scaled_10k/microbes_k21_s10k_tbp10k_Oe6.scaffolds.fa.csv", header = T)
Oe6_fungi_k31_s1k <-read.csv("fungi_k31__s1000_Oe6.scaffolds.fa.txt.csv", header = T)
Oe6_fungi_k51_s1k <-read.csv("fungi_k51__s1000_Oe6.scaffolds.fa.txt.csv", head = T)

parse_species_names<-function(sbt_gather_output, jgi_species_key){
  # grepl for "AssemblyScaffolds.fasta.gz", which is in all JGI genome file names
  jgi_species<-subset(sbt_gather_output, grepl("AssemblyScaffolds.fasta.gz", name)) 
  jgi_merged<-merge(jgi_species, jgi_species_key, by.x = "name", by.y = "file_name")
  # remove the first column, which is the old name
  jgi_merged<-jgi_merged[,2:5]
  # grepl for white space, which is in the names of GenBank and RefSeq genomes
  other_species<-subset(sbt_gather_output, grepl(" ", name))
  # bind columns together, and return dataframe
  rbind(other_species, jgi_merged)
}

Oe6_fungi_k21_s10k_parsed <- parse_species_names(Oe6_fungi_k21_s10k, jgi_names_key)
Oe6_microbes_k21_s10k_parsed <- parse_species_names(Oe6_microbes_k21_s10k, jgi_names_key)
Oe6_fungi_k31_s1k_parsed <- parse_species_names(Oe6_fungi_k31_s1k, jgi_names_key)
Oe6_fungi_k51_s1k_parsed <- parse_species_names(Oe6_fungi_k51_s1k, jgi_names_key)

write.csv(Oe6_fungi_k21_s10k_parsed, "Oe6_scaled_10k/fungi_k21_s10k_Oe6.scaffolds.fa_parsed.csv", row.names=F)
write.csv(Oe6_microbes_k21_s10k_parsed, "Oe6_scaled_10k/microbes_k21_s10k_tbp10k_Oe6.scaffolds.fa_parsed.csv", row.names=F)
write.csv(Oe6_fungi_k31_s1k_parsed, "Oe6_scaled_1000/fungi_k31__s1000_Oe6.scaffolds.fa_parsed.csv", row.names = F)
write.csv(Oe6_fungi_k51_s1k_parsed, "Oe6_scaled_1000/fungi_k51__s1000_Oe6.scaffolds.fa_parsed.csv", row.names = F)

library(ggplot2)
library(scales)
ggplot(Oe6_fungi_k51_s1k_parsed, aes(intersect_bp)) + ggtitle("k51 scaled 1000 Intersect Base Pairs") + geom_histogram() + scale_x_continuous(labels = comma) +stat_bin(aes(y=..count.., label=..count..), geom="text", vjust=-.5) 


ggplot(Oe6_fungi_k31_s1k_parsed, aes(intersect_bp)) + ggtitle("k31 scaled 1000 Intersect Base Pairs") + geom_histogram() + scale_x_continuous(labels = comma) +stat_bin(aes(y=..count.., label=..count..), geom="text", vjust=-.5) 



