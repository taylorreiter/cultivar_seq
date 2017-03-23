### Data

If it hasn't been downloaded, download the SRA Toolkit and disable the cache
```
wget http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.8.1-3/sratoolkit.2.8.1-3-ubuntu64.tar.gz
tar -xzf sratoolkit.current-ubuntu64.tar.gz
export PATH=$PATH:/directory/sratoolkit.2.8.1-3-ubuntu64/bin
```

disable cache
```
./vdb-config --interactive-mode 'textual'
6
Y 
```
then press enter

download files
```
cd /mnt/work/
mkdir single
cd single
mkdir raw_data
cd raw_data
```

Download files

```
for accession in SRR4236909 SRR4236910 SRR4236911 SRR4236912 SRR1574719 SRR1574772 SRR1573503 SRR1574328 
do
  ~/sratoolkit.2.8.1-3-ubuntu64/bin/fastq-dump.2.8.1-3 --defline-seq '@$sn[_$rn]/$ri' ${accession} --gzip
done 
```

### Quality
```
cd /mnt/work/single
mkdir quality
ln -s ../raw_data/*.fastq.gz .
ls
```

Download adapter file

```
wget https://github.com/taylorreiter/olive_public_seq/blob/master/RNA-seq/many_fruit/pre-processing/illumina-adapters-PE-SE.fa
```

Trim the files
```
for filename in SRR4236909.fastq.gz SRR4236910.fastq.gz SRR4236911.fastq.gz SRR4236912.fastq.gz SRR1574719.fastq.gz SRR1574772.fastq.gz SRR1573503.fastq.gz SRR1574328.fastq.gz 
do
     # first, make the base by removing fastq.gz
     base=$(basename $filename .fastq.gz)
     echo $base
     TrimmomaticSE ${base}.fastq.gz ${base}qc.fq.gz ILLUMINACLIP:illumina-adapters-PE-SE.fa:2:40:15 LEADING:2 TRAILING:2 SLIDINGWINDOW:4:2 MINLEN:25
done
```
Make trimmed files read only
```
chmod u-w ${PROJECT}/quality/*qc.fq.gz
```

Consider deleting raw data. 
