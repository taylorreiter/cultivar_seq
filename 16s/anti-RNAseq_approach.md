# 16s rRNA approach

RNAseq might be computationally intensive, and difficult to gather respectable results before March 10. As an alternate, try analyzing 16s rRNA data first.


2 phyllosphere fruit samples, 454 sequencing of fungal diversity through universal fungal primers ITS3-ITS4 to amplify the ITS2 region of the ribosomal DNA.

* note that leaf 16s rRNA data show variation both by region and by cultivar. 

#### From the authors:

##### Identification of Fungal Species
In order to confirm the accuracy of taxonomic assignments, sequences associated with each OTU within each identified fungal genus, were extracted and introduced in ElimDupes (http:// hcv.lanl.gov/content/sequence/ELIMDUPES/elimdupes.html) to detect multiple identical sequences and determine their frequency. Unique representative sequences defined as sequence types (STs), i.e. distinct and reproducible ITS2 sequences recovered in this study, were than manually blasted to identify the closest available reference sequences in the complete NCBI nucleotide collection (http://blast.ncbi.nlm.nih.gov/Blast). Furthermore, ITS2 sequences of the most abundant fungal genera according to the QIIME taxonomic assignments (Aureobasidium spp., Colletotrichum spp., Cladosporium spp., Pseudocercospora spp., and Devriesia spp.) were phylogenetically analyzed. STs were analyzed along with genetically closely related reference sequences of the same genus to determine their phylogenetic collocation and enable their iden- tification with the highest possible level of accuracy. Before analysis, validated panels of refer- ence ITS2 sequences of Colletotrichum acutatum s.l. [32–34], C. boninense s.l. [35], Pseudocercospora spp. [36], Devriesia spp. [37], Cladosporium spp. [38] and Aureobasidium spp. [39] were analyzed with the software ElimDupes to delete multiple identical sequences. Some identical reference sequences were included in the panel because they were representative of different species. When none of the above-validated reference sequences was identical to sequences identified in the present study, eventual more closely related sequences were identi- fied by BLAST analyses. Despite being low abundant, a similar analysis was also performed for the genus Spilocaea in light of its relevance as olive fungal pathogen [2]. In this case, reference sequences were downloaded from GenBank because of the lack of a validated panel of reference sequences.
For each genus, STs identified in the present study and reference sequences were aligned using MUSCLE and introduced to MEGA for phylogenetic analysis with the Maximum Likeli- hood method using the Tamura-Nei model [30]. Analyses were performed with 1000 bootstrap replications.


*Abdelfattah A, Li Destri Nicosia MG, Cacciola SO, Droby S, Schena L (2015) Metabarcoding Analysis of Fungal Diversity in the Phyllosphere and Carposphere of Olive (Olea europaea). PLOS ONE 10(7): e0131069. doi: 10.1371/journal.pone.0131069*

# Idea

Reclassify data from this study by fungal species. With defined proportion of fungal species, and relative to absolute count, define "gene potential" of fruit microbiome based on species present. Search for genes that have proteins that are important in flavor development and report on their potential abundance (i.e. how many organisms contain the genes). 

Then, analyze RNA-seq samples and determine percent of sample that is fungal. Determine if genes identified above are represented. 
