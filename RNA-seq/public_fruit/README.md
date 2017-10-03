### Data

#### PRJEB4992

Data from Cruz et al. 2016 (DOI: 10.1186/s13742-016-0134-5) olive reference genome paper. One mature olive RNA-seq run, paired-end, 80 million reads. Farga varietal.

Relevant run:

+ ERR1346597

#### PRJNA342541

Data from Goldental-Cohen et al. 2017 (DOI: 10.1186/s12870-017-1035-1). From ENA: Ethephon induced oxidative stress in the olive leaf but not in fruit abscission zone enable development of a selective abscission compound. Manzanillo varietal. "The fruit abscission zone 3 (FAZ3), located between the fruit and the pedicel, was found to be the active AZ in mature fruits and is sensitive to ethephon, whereas FAZ2, between the pedicel and the rachis, is the flower active AZ as well as functioning as the most ethephon induced fruit AZ. Olive fruit abscission can occur at three different locations: peduncle-branch (FAZ1), pedicel rachis (FAZ2) and fruit-pedicel (FAZ3). Mature olive fruit abscission occurs mainly in FAZ3, to a lesser degree in FAZ2 and rarely in FAZ1. The leaf and fruit AZs sampled for transcriptome profiling were excised by hand to approximately 1 mm thick from each side of the AZ region. Tissues were removed from the tree, immediately excised and frozen in liquid nitrogen. AZ enriched tissues were used to prepare six cDNA libraries from total RNA of the three analyzed AZs (LAZ, FAZ2 and FAZ3) of ‘Manzanillo’ before and 5 days after ethephon treatment, using Illumina’s TruSeq RNA library preparation kit according to the manufacturer’s instructions. Each cDNA library consisted of RNA from about 70 AZs sampled from different fruits or leaves, and was sequenced on Illumina HiSeq 2000."


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
