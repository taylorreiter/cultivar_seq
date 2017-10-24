Obtain reference genome
```
# olea
wget http://denovo.cnag.cat/genomes/olive/download/Oe6/Oe6.scaffolds.fa.gz

# Aureobasidium pollulans var. Santander
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/678/115/GCA_001678115.1_ASM167811v1/GCA_001678115.1_ASM167811v1_genomic.fna.gz

# Aureobasidium pollulans var. pullulans EX-150
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/721/785/GCA_000721785.1_Aureobasidium_pullulans_var._pullulans_EXF-150_assembly_version_1.0/GCA_000721785.1_Aureobasidium_pullulans_var._pullulans_EXF-150_assembly_version_1.0_genomic.fna.gz
```

Nucmer santander var
```
nucmer --mum Oe6.scaffolds.fa GCA_001678115.1_ASM167811v1_genomic.fna -p Oe6-APvarSan

nucmer --mum Oe6.scaffolds.fa GCA_000721785.1_Aureobasidium_pullulans_var._pullulans_EXF-150_assembly_version_1.0_genomic.fna -p Oe6-APvarEx
```
```
for infile in *delta
do
  j=$(basename $infile .delta)
  delta-filter -l 500 -q ${infile} > ${j}_filter.delta
  show-coords -c -l -L 500 -r -T ${j}_filter.delta | gzip > ${j}_filter_coords.txt.gz
done
```
