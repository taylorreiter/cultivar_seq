### Download data

If not already installed, install the SRA toolkit and disable the cache.

```
wget http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.8.1-3/sratoolkit.2.8.1-3-ubuntu64.tar.gz
tar -xzf sratoolkit.current-ubuntu64.tar.gz
export PATH=$PATH:/directory/sratoolkit.2.8.1-3-ubuntu64/bin
```

```
./vdb-config --interactive-mode 'textual'
6
Y 
```
Download paired-end fastq. Note that trinity requires some `--defline-seq` magic for functional assembly. 
```
cd /mnt/work
mkdir paired

for accession in ERR1346597
do
~/sratoolkit.2.8.1-3-ubuntu64/bin/fastq-dump.2.8.1-3 --defline-seq '@$sn[_$rn]/$ri' ${accession} --gzip
done 
```

### Quality control

```
fastqc .
```

Trim the reads
```
```
