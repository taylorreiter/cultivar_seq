### Data

#### PRJEB4992

Data from Cruz et al. 2016 olive reference genome paper. One mature olive RNA-seq run, paired-end, 80 million reads. Farga varietal.

Relevant run:

+ ERR1346597

#### PRJNA342541

Data from unknown. From ENA: Ethephon induced oxidative stress in the olive leaf but not in fruit abscission zone enable development of a selective abscission compound. Manzanillo varietal.

Relevant runs:

+ SRR4236909 *FAZ2-0*
+ SRR4236910 *FAZ2-5*
+ SRR4236911 *FAZ3-0*
+ SRR4236912 *FAZ3-5*

#### PRJNA260808

Data from Iaria et al. 2017. Leucocarpa varietal and Cassanese varietal.  From ENA: We have chosen to analyze the transcriptome of fruits at selected stages, 100 and 130 days after flowering (DAF), through RNA-seq approaches, to identify the transcripts and their corresponding expression patterns involved in the main phenotypic change in “Leucocarpa” cv, an olive variety characterized by a switch-off in skin colour at full ripeness, and “Cassanese” cv, used as control plant.

+ SRR1574719 *Leuc100*
+ SRR1574772 *Leuc130*
+ SRR1573503 *Cass100* 
+ SRR1574328 *Cass130*

House paired-end and single-end data in separate folders to make processing easier. 

### Workflow:  

**Paired-end Pre-processing**

1. Dowload fastq file
2. Fastqc
3. Split reads
4. Trimmomatic
5. Interleave paired-end sequences

**Single-end Pre-processing**

1. Download fastq files
2. fastqc
3. multiqc
4. Trimmomatic
5. ... meet up with eelpond

**Eel Pond**

6. Digital normalization
7. Split paired end reads
8. Concatenate with single-end reads
9. Assemble with trinity
10. Evaluate assembly
    1. Transrate
    2. Busco
11. Annotate transcriptome with dammit
12. Salmon
13. Use HISAT to map reads back to transcriptome
    1. Index Trinity transcriptome
14. Circos to visualize gene coverage and orientation 
    1. https://2016-metagenomics-sio.readthedocs.io/en/latest/circos_tutorial.html#visualizing-gene-coverage-and-orientation

 
**HISAT & Unaligned Reads**

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

**Sourmash**

7. From trimmed low abundance kmer reads from unaligned HISAT reads, compute sourmash signatures at `--scaled 500`
8. SBT_gather
    1. Against whole microbe database
    2. Against fungal database
