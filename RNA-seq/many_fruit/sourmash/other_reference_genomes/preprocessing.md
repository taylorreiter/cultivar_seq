Becuase the olive reference genome appeared to be a hot mess, use other well-loved reference genomes as a control to see which fungal species, if any, are identified by `sbt_gather`.

Download data, stream to khmer's `trim-low-abund` and calculate signature with `sourmash compute`

```
source ~/sourmashEnv2/bin/activate

cd /mnt/work
mkdir other_ref_genomes
cd other_ref_genomes

for URL in ftp://ftp.ensemblgenomes.org/pub/plants/release-35/fasta/arabidopsis_thaliana/dna/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa.gz ftp://ftp.ensemblgenomes.org/pub/plants/release-35/fasta/zea_mays/dna/Zea_mays.AGPv4.dna.toplevel.fa.gz ftp://ftp.ensemblgenomes.org/pub/plants/release-35/fasta/oryza_sativa/dna/Oryza_sativa.IRGSP-1.0.dna.toplevel.fa.gz ftp://ftp.ensemblgenomes.org/pub/plants/release-35/fasta/hordeum_vulgare/dna/Hordeum_vulgare.ASM32608v1.dna.toplevel.fa.gz ftp://ftp.ensemblgenomes.org/pub/plants/release-35/fasta/physcomitrella_patens/dna/Physcomitrella_patens.ASM242v1.dna.toplevel.fa.gz
do
  NAME=$(url=$URL; echo "${url##*/}")
  echo $NAME
  curl $URL | trim-low-abund.py -M 3e9 -o - - | sourmash compute - --scaled 1000 -o $NAME_abundtrim_s1000.sig
done
