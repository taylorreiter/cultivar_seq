Run nucmer on the genomes identified by sourmash in Trinity

```
40.0 kbp      0.0%    0.2%      CZCR01000001.1 Microbotryum lychnidis...
20.0 kbp      0.0%    0.0%      Colsu1_AssemblyScaffolds.fasta.gz
20.0 kbp      0.0%    0.0%      KQ503367.1 Puccinia psidii isolate Au...
10.0 kbp      0.0%    0.0%      KL584824.1 Aureobasidium pullulans va...
10.0 kbp      0.0%    0.0%      Aspfo1_AssemblyScaffolds.fasta.gz
10.0 kbp      0.0%    0.0%      Aspfij1_AssemblyScaffolds.fasta.gz
10.0 kbp      0.0%    0.0%      AADS01001323.1 Phanerochaete chrysosp...
10.0 kbp      0.0%    0.0%      ADAS02000001.1 Puccinia triticina 1-1...
10.0 kbp      0.0%    0.0%      Rhich1_AssemblyScaffolds.fasta.gz
10.0 kbp      0.0%    0.0%      LGLR01000001.1 Stemphylium lycopersic...
10.0 kbp      0.0%    0.0%      Lopma1_AssemblyScaffolds.fasta.gz
10.0 kbp      0.0%    0.0%      LBLN01000001.1 Puccinia arachidis str...
```

link in files from JGI
```
cd /mnt/work/eelpond_oleaRNAseq_sourmash 
mkdir nucmer_trinity
cd nucmer_trinity
for infile in Colsu1_AssemblyScaffolds.fasta.gz Aspfo1_AssemblyScaffolds.fasta.gz Aspfij1_AssemblyScaffolds.fasta.gz Rhich1_AssemblyScaffolds.fasta.gz Lopma1_AssemblyScaffolds.fasta.gz
do
  cp ~/fungal_genomes/JGI_1KFGs/${infile} .
done
```

```
for inline in CZCR01000001.1 KQ503367.1 KL584824.1 AADS01001323.1 ADAS02000001.1 LGLR01000001.1 LBLN01000001.1 
do
  grep -l "${inline}" ~/fungal_sigs/*sig
done

for infile in GCA_900016725.1_MvSl-Chernobyl-1165-2-A2-G1-20141113_genomic.fna.gz GCA_001443065.1_ASM144306v1_genomic.fna.gz GCA_000721775.1_Aureobasidium_pullulans_var._melanogenum_CBS_110374_v1.0_genomic.fna.gz GCA_000167175.1_ASM16717v1_genomic.fna.gz GCA_000151525.2_P_triticina_1_1_V2_genomic.fna.gz GCA_001191545.1_ASM119154v1_genomic.fna.gz GCA_001013415.1_ASM101341v1_genomic.fna.gz
do
  find ~/fungal_genomes/ -name $infile
done


cp /home/ubuntu/fungal_genomes/ncbi-genome-downloads-fungi/genbank/fungi/GCA_900016725.1/GCA_900016725.1_MvSl-Chernobyl-1165-2-A2-G1-20141113_genomic.fna.gz .
cp /home/ubuntu/fungal_genomes/ncbi-genome-downloads-fungi/genbank/fungi/GCA_001443065.1/GCA_001443065.1_ASM144306v1_genomic.fna.gz .
cp /home/ubuntu/fungal_genomes/ncbi-genome-downloads-fungi/genbank/fungi/GCA_000721775.1/GCA_000721775.1_Aureobasidium_pullulans_var._melanogenum_CBS_110374_v1.0_genomic.fna.gz .
cp /home/ubuntu/fungal_genomes/ncbi-genome-downloads-fungi/genbank/fungi/GCA_000167175.1/GCA_000167175.1_ASM16717v1_genomic.fna.gz . 
cp /home/ubuntu/fungal_genomes/ncbi-genome-downloads-fungi/genbank/fungi/GCA_000151525.2/GCA_000151525.2_P_triticina_1_1_V2_genomic.fna.gz .
cp /home/ubuntu/fungal_genomes/ncbi-genome-downloads-fungi/genbank/fungi/GCA_001191545.1/GCA_001191545.1_ASM119154v1_genomic.fna.gz . 
cp /home/ubuntu/fungal_genomes/ncbi-genome-downloads-fungi/genbank/fungi/GCA_001013415.1/GCA_001013415.1_ASM101341v1_genomic.fna.gz .

gunzip *gz

for infile in *fasta
do 
  find $infile -type f -exec sed -i "s/Superscaffold/${infile}/g" {} \;
  find $infile -type f -exec sed -i "s/scaffold/${infile}/g" {} \;
  find $infile -type f -exec sed -i "s/Supercontig/${infile}/g" {} \;
  find $infile -type f -exec sed -i "s/contig/${infile}/g" {} \;
  find $infile -type f -exec sed -i "s/LG/${infile}/g" {} \;
  find $infile -type f -exec sed -i "s/sc_/${infile}_/g" {} \;
  find $infile -type f -exec sed -i "s/c_/${infile}_/g" {} \;
  find $infile -type f -exec sed -i "s/d_/${infile}_/g" {} \;
done


cat * > k31_Trinity_cat.fa
```


```
cd /mnt/work/eelpond_oleaRNAseq_sourmash/nucmer_trinity
~/mummer-4.0.0beta/nucmer -L 500 --mum ../Trinity.fasta k31_Trinity_cat.fa -p k31_concat_vs_Trinity_mum
~/mummer-4.0.0beta/show-coords -l -c k31_concat_vs_Trinity_mum.delta > k31_concat_vs_Trinity_mum.delta.tab
```
