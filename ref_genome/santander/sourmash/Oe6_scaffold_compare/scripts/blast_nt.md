# blasting contigs with low sourmash compare values

From a blank ubuntu instance,
```
sudo apt-get update && sudo apt-get -y install python ncbi-blast+
```
Download the nt database
```
wget 'ftp://ftp.ncbi.nlm.nih.gov/blast/db/nt.*.tar.gz'
cat nt.*.tar.gz | tar -zxvi -f - -C .
```
Tar files to be transfered to ubuntu
```
tar -czvf suspicious_scaffolds.tar.gz suspicious_scaffolds
```
From ubuntu:
```
tar xf suspicious_contigs.tar.gz
```

BLAST!
```
for infile in *fa
do
blastn -query $infile -db ~/nt_db/nt -outfmt 11 -out ~/blast_out/${infile}.asn
done
```
(transfer .asn files back to local computer)
Convert blast format to tabular
```
for infile in *asn
do
  outfile=$(basename $infile .asn)
  blast_formatter -archive $infile -outfmt 6 -out tab/${outfile}.tab
  blast_formatter -archive $infile -outfmt 0 -out pairwise/${outfile}.pw
done

for infile in *asn
do
  outfile=$(basename $infile .asn)
  blast_formatter -archive $infile -outfmt 5 -out xml/${outfile}.xml
done
```
