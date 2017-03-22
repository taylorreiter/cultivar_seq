## PRJEB4992

Data from Cruz et al. 2016 olive reference genome paper. One mature olive RNA-seq run, paired-end, 80 million reads.

Workflow: Pre-processing
1. Dowload fastq file
2. Fastqc
3. Split reads
4. Trimmomatic

Eel Pond

5. Interleave sequences
6. Digital normalization
7. split reads
8. Assemble with trinity
9. Evaluate assembly
    1. Transrate
    2. Busco
10. Annotate transcriptome with dammit
11. Salmon
12. Use HISAT to map reads back to transcriptome
    1. Index Trinity transcriptome
12. Circos to visualize gene coverage and orientation 
    1. https://2016-metagenomics-sio.readthedocs.io/en/latest/circos_tutorial.html#visualizing-gene-coverage-and-orientation

 
HISAT & Unaligned Reads

5. Align to olive reference genome with HISAT
    1. Indexed in previous analysis steps
    2. Output unaligned reads into a fastq file. Output orphaned reads separately from pairs that did not map.
6. Trim low abundance k-mers in unaligned reads
7. Assemble with Trinity
8. Evaluate assembly
    1. Transrate
    2. Busco fungi, bacteria, archaea (consider going in to subbranches of fungi with busco)
9. Annotate transcriptome with dammit
10. Salmon
11. Use HISAT (or BWA, but probably HISAT) to map back to transcriptome 
    1. Index new transcriptome from unaligned reads
12. Circos to visualize gene coverage and orientation 

Sourmash

7. From trimmed low abundance kmer reads from unaligned HISAT reads, compute sourmash signatures at `--scaled 500`
8. SBT_gather
    1. Against whole microbe database
    2. Against fungal database
