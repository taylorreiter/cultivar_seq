Becuase the olive reference genome appeared to be a hot mess, use other well-loved reference genomes as a control to see which fungal species, if any, are identified by `sbt_gather`.

Download data, stream to khmer's `trim-low-abund` and calculate signature with `sourmash compute`

```
source ~/sourmashEnv2/bin/activate

cd /mnt/work
mkdir other_ref_genomes
cd other_ref_genomes

# for URL in
# ftp://ftp.ensemblgenomes.org/pub/plants/release-35/fasta/hordeum_vulgare/dna/Hordeum_vulgare.ASM32608v1.dna.toplevel.fa.gz #ftp://ftp.ensemblgenomes.org/pub/plants/release-35/fasta/physcomitrella_patens/dna/Physcomitrella_patens.ASM242v1.dna.toplevel.fa.gz
# do
#  NAME=$(url=$URL; echo "${url##*/}")
#  echo $NAME
#  curl $URL | sourmash compute - -k 21,31,51 --scaled 1000 -o $NAME_abundtrim_s1000.sig
# done

curl ftp://ftp.ensemblgenomes.org/pub/plants/release-35/fasta/arabidopsis_thaliana/dna/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa.gz | gunzip | sourmash compute - -k 21,31,51 --scaled 1000 -o Arabidopsis_thaliana.TAIR10.dna.toplevel.fa.gz_abundtrim_s1000.sig

curl ftp://ftp.ensemblgenomes.org/pub/plants/release-35/fasta/oryza_sativa/dna/Oryza_sativa.IRGSP-1.0.dna.toplevel.fa.gz | gunzip | sourmash compute - -k 21,31,51 --scaled 1000 -o Oryza_sativa.IRGSP-1.0.dna.toplevel.fa.gz_abundtrim_s1000.sig

curl ftp://ftp.ensemblgenomes.org/pub/plants/release-35/fasta/physcomitrella_patens/dna/Physcomitrella_patens.ASM242v1.dna.toplevel.fa.gz | gunzip | sourmash compute - -k 21,31,51 --scaled 1000 -o Physcomitrella_patens.ASM242v1.dna.toplevel.fa.gz_abundtrim_s1000.sig
```

Run `sourmash sbt_gather` on each of the samples. Use -k 21 and a threshold of 50kb. Run in parallel.
```
source ~/sourmashEnv2/bin/activate

sourmash sbt_gather -k 21 ~/sourmash_SBTs/fungal_k21_s1000/fungal_k21_s1000.sbt.json Oryza_sativa.IRGSP-1.0.dna.toplevel.fa.gz_abundtrim_s1000.sig --threshold-bp=50000 -o fungi_k21_Oryza_sativa.IRGSP-1.0.dna.toplevel_s1000_.txt
 
sourmash sbt_gather -k 21 ~/sourmash_SBTs/fungal_k21_s1000/fungal_k21_s1000.sbt.json Arabidopsis_thaliana.TAIR10.dna.toplevel.fa.gz_abundtrim_s1000.sig --threshold-bp=50000 -o fungi_k21_Arabidopsis_thaliana.TAIR10.dna.toplevel_s1000_.txt

sourmash sbt_gather -k 21 ~/sourmash_SBTs/fungal_k21_s1000/fungal_k21_s1000.sbt.json Physcomitrella_patens.ASM242v1.dna.toplevel.fa.gz_abundtrim_s1000.sig --threshold-bp=50000 -o fungi_k21_Physcomitrella_patens.ASM242v1.dna.toplevel_s1000_.txt
