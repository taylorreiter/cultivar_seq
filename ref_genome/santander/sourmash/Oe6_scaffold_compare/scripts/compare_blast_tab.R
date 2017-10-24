# read in files in tab format from blasting the suspicous olea contigs against nt

# make a vector of files where file size > 0
    files <- vector()
    for(i in seq(length(list.files(path = "data_out/blast_out/tab/", full.names = TRUE)))){
      file_paths <- list.files(path = "data_out/blast_out/tab/", full.names = TRUE)
      if(file.size(file_paths[i]) == 0) next
      files[i] <- file_paths[i]
    }

# remove NAs from vector
    files <- files[!is.na(files)]

# read files in
    tab <- lapply(files, function(x) read.table(x, header = FALSE, stringsAsFactors = FALSE))
    tab <- do.call("rbind", tab)
    colnames(tab) <- c("qsequid", "sseqid", "pident", "length", "mismatch", "gapopen", 
                       "qstart", "qend", "sstart", "send", "evalue", "bitscore")
          # column name meanings of blast output
          # 1.   qseqid	 query (e.g., gene) sequence id
          # 2.	 sseqid	 subject (e.g., reference genome) sequence id
          # 3.	 pident	 percentage of identical matches
          # 4.	 length	 alignment length
          # 5.	 mismatch	 number of mismatches
          # 6.	 gapopen	 number of gap openings
          # 7.	 qstart	 start of alignment in query
          # 8.	 qend	 end of alignment in query
          # 9.	 sstart	 start of alignment in subject
          # 10.	 send	 end of alignment in subject
          # 11.	 evalue	 expect value
          # 12.	 bitscore	 bit score

library(dplyr)
# create a dataframe that contains contigs that are from olea europaea repeat sequences
    olea_repeats <- filter(tab, sseqid == "gi|12054837|emb|AJ243943.1|" |
                             sseqid == "gi|12054838|emb|AJ243944.1|")

# filter contigs that had the repeats
    olea_repeat_contigs <- unique(olea_repeats$qsequid)
    non_repeats <- filter(tab, (!qsequid %in% olea_repeat_contigs))

# add a column for species name of match

    # isolate accession using regex
    library(stringr)
    nuid <- sapply(X = non_repeats$sseqid, 
                   function(x) str_extract(string = x, pattern = "(?<=gi\\|).*(?=\\|[a-z]{2,3})"))
    non_repeats <- cbind(non_repeats, nuid)
    
    # Query NCBI nucleotide database for metadata associated with nuid
    library(rentrez)
    block <- function(i){
      nuid_species <- entrez_summary(db="nucleotide", id = i)
      Sys.sleep(2) # sleep; don't overwhelm NCBI server
      return(nuid_species)
    }
    # apply to all unique nuids
    nuid_names <- lapply(unique(non_repeats$nuid), block)
    # extract species names from retrieved data
    nuid_unique_names <- sapply(nuid_names, "[[", 3)
    # make a dataframe of nuid and species
    nuid_unique <- as.numeric(as.character(unique(non_repeats$nuid)))
    
    names_w_nuids <- cbind(nuid_unique, nuid_unique_names)
    names_w_nuids <- as.data.frame(names_w_nuids)
    colnames(names_w_nuids) <- c("nuid", "nuid_title")
    
    # merge dataframe with nuid species
    non_repeats <- merge(non_repeats, names_w_nuids, by = "nuid")
    
    

    # sort no repeats by bit score
    tail(non_repeats[order(non_repeats$bitscore), ], n = 15)
    
    # select highest bitscore for each contig
        # Sort by qsequid and bitscore (largest bitscore is last for each qsequid)
        non_repeats <- non_repeats[order(non_repeats$qsequid, non_repeats$bitscore), ]
        
        # Select the last row by id
        non_repeats_bitscore <- non_repeats[!duplicated(non_repeats$qsequid, fromLast=TRUE), ]
  
write.csv(non_repeats_bitscore, file = "data_out/highest_bitscore_suspicious_contigs.csv", quote = FALSE, row.names = FALSE)

# after observing the output CSV, check out other hits on contigs that had high bitscores to determine if the sequence is widely distributed throughout different species, or if it is specific to a specific kingdom/family/etc. 

# Oe6_s09260 matched a homo sapiens BAC
head(non_repeats)
Oe6_s09260 <- filter(non_repeats, qsequid == "Oe6_s09260")
# all return homo sapiens or pan troglodytes, except a handful. The contig is 1265 nucleotides, and the longest match to the human genome was 1245. 
# this is probably human genome. This should probably be removed. 
# UCSC genome browser blat: 1242     1  1245  1245 100.0%     1   +  125180113 125182680   2568


# Oe6_s02989 matched methylobacter sp C1 chromosome
Oe6_s02989 <- filter(non_repeats, qsequid == "Oe6_s02989")
Oe6_s02989
