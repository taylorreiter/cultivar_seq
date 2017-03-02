# Plan of attack for computational pilot study 

NB named as such to differentiate from the non-computational pilot study I'm currently working on

## Why this is interesting/relevant

There are a few (~30) olive fruit transcriptomes in NCBI/SRA. These have been analyzed for olive fruit biology. Most have been polyA purified (can pick up on fungal, but not on bacterial).
There seems to be one set of samples where I could re-analyze the RNA-seq data for microbial **and** fungal content. I could annotate this with dammit & SAMSA, and then create a network of gene expression in each sample highlighting which transcripts originate from bacteria, which originate from fungus, and which originate from tree (or, at the very least, eukaryote vs prokaryote). 
This could illustrate how microbial communities contribute to gene expression in olive fruit.

+ One study compared the domesticated olive transcriptome to the wild olive transcriptome. 
  1. PolyA purification.
  2. Potential: fungal identification
+ One study sampled from olive fruit from different cultivars at 100 or 130 days after flowering to track development of certain compounds (anthocyanins; color)
  1. Pooled samples
  2. **No mention of PolyA purification!**
  3. Start here -- additionally, quantification of flavanoid & anthocyanin (these are metabolites, they do not contribute directly to flavor, but who knows if they interact with enzymes or metabolites in the flavor-forming process).
  4. Possible issue -- bacterial cells may not be lysed.
  5. **Decision** Begin with this data

|  Sample	          |  Raw reads	|Used reads	|Assembled transcripts|N50	|Mapped reads|
|-------------------|-------------|-----------|---------------------|-----|------------|
|Leucocarpa 100 DAF | 28,700,100	|23,687,921	|22,959               |754	|84.07%      |
|Leucocarpa 130 DAF | 28,121,963	|23,122,308	|26,203               |829	|84.15%      |
|Cassanese 100 DAF	| 28,550,901	|23,394,526	|22,709               |767	|83.82%      |
|Cassanese 130 DAF	| 57,106,631	|48,153,012	|31,485               |972	|85.49%      |
+ One study sequenced the transcriptome of different olive tissues to help construct the reference genome, and produced a transcriptome of an un-ripe fruit as well as a ripe fruit.
+ One study sequenced the transcriptome from 5 different cultivars
  1. PolyA purification.
  2. **Decision** Begin with this data as well
+ One study sequenced **miRNA** from ripe and unripe fruit in bearing and non-bearing years (!!!!!) 
  1. Single end Illumina Genome analyzer, ~500 mb per sample (~15M reads), 6 samples. Size fractionation (will this pick up on bacterial?)
  2. Study accession -- SRP017596
  3. SRA accessions: SRR636243, SRR636244, SRR636245, SRR636246, SRR636247, SRR636248. Only UR and RF can be used (n = 2). Other samples are leaves. And then pooled and size selected from 18-30 nt... 
  4. http://www.ebi.ac.uk/ena/data/view/PRJNA184000
  5. https://www.ncbi.nlm.nih.gov/sra/SRX211306[accn]
  6. Would be great if tree, fungal, and bacterial mRNA could all be annotated. 
  7. **Decision** This data is probably not relevant
