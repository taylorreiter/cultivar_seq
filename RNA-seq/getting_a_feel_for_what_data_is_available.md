# Computational Pilot Study

Many good (ish) fruit RNA-seq datasets. Use Eel Pond Protocol to determine the microbiology of contaminating fungus in the samples. Determine differential expression of fungal genes, see if this is different in different samples, determine what genes are there that could effect flavor. 

Requires that flavors are well defined in different varietals--seems to be the case well enough for correlation.

Cruz at al RNA-seq (four fruits)
+ Illumina 2016 oligoDT
+ https://www.ncbi.nlm.nih.gov/sra/ERX1477590[accn]

OR that flavors are well defined from oils that come from olives during different stages of development.
+ https://www.ncbi.nlm.nih.gov/sra/SRX211305[accn]
+ https://www.ncbi.nlm.nih.gov/sra/SRX211306[accn]
+ Illumina 2015

Other 
+ Raw RNA sequencing data of several cultivated crops and their wild relatives and close outgroups in order to make comparative analyses of the effect of domestication on genome evolution in different crop species
+https://www.ncbi.nlm.nih.gov/sra/SRX1967854[accn] (domesticated)
+https://www.ncbi.nlm.nih.gov/sra/SRX1967855[accn] (wild)
+ Illumina 2016, paired-end RT PCR

Other 2
+ We have chosen to analyze the transcriptome of fruits at selected stages, 100 and 130 days after flowering (DAF), through RNA-seq approaches, to identify the transcripts and their corresponding expression patterns involved in the main phenotypic change in “Leucocarpa” cv, an olive variety characterized by a switch-off in skin colour at full ripeness, and “Cassanese” cv, used as control plant.
+https://www.ncbi.nlm.nih.gov/sra/SRX700302[accn]
+ Illumina 2015

Other 3
+ Transcriptome Sequencing of 5 Olive Cultivars
+The SNP analysis used the DNA samples of five olive genotypes (Siyah Salamuralık, Yun Celebi, Yuvarlak Celebi, Hirhali Celebi and Halhali 3) that originated from different locations in Turkey. Total RNA was extracted using the RNeasy Plant Mini Kit (QIAGEN, CA, USA, Cat. Number: 74903). The poly (A) mRNA was purified from the total RNA using the Oligotex mRNA Midi Prep Kit (QIAGEN, Cat Number: 70022) followed by repurification using the mRNA-Seq-8 Sample Prep Kit (Illumina Inc. San Diego, USA, Cat. No: # RS-100-0801). The poly-A containing mRNA was purified from 2 µg total RNA using oligo(dT) magnetic beads and fragmented into 200–500 bp pieces using divalent cations at 94°C for 5 min. The cleaved RNA fragments were copied into first strand cDNA using SuperScript II reverse transcriptase (Life Technologies, Inc.). After the second strand cDNA synthesis, the fragments were end-repaired and a-tailed and the indexed adapters were ligated. The products were purified and enriched by PCR to create the final cDNA library. These pooled libraries were sequenced at the DNA Link, Inc. in Seoul, South Korea using an Illumina GAIIx (Illumina Inc., San Diego, CA, USA). The raw sequencing data were transformed by base calling into sequence data (i.e., raw data or raw reads) stored in FASTQ format. Next, we used cutadapt (https://code.google.com/p/cutadapt/) to remove any reads that were contaminated with an Illumina adapter. Then, the low-quality score regions and reads shorter than 70 bp were removed using our in-house script. In addition, a comprehensive ribosomal RNA database, the SILVA DATABASE (DB), containing regularly updated, high-quality sequences of eukaryotic rRNAs was incorporated into the cleaning pipeline to remove ribosomal RNA sequences. Reads that mapped to SILVA DB sequences were assumed to be ribosomal RNA and were removed. The resulting non-mapped reads were then considered to be mRNA. These cleaned mRNA reads were assembled using ABySS tools. The assembled contigs were reassembled using the de novo assembly tool Newbler version 2.3 (GS de novo assembler, Roche Applied Sciences). The cleaned mRNA reads (reads that did not map to SILVA DB sequences) were then mapped to Newbler’s output contigs, which were used as reference sequences.
+https://www.ncbi.nlm.nih.gov/sra/SRX318162[accn]
+ single, iillumina 2013

Other 4
+ olive fruit transcriptome; no mention of rRNA depletion or polyA enrichment
+ https://www.ncbi.nlm.nih.gov/sra/SRX215662[accn]
+ 454...

THESE WILL PRODUCE CORRELATION, NOT CAUSATION, BUT MAY ACT AS STRONG PILOT DATA
