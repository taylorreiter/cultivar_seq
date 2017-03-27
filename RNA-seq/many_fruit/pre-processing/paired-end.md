### Download data

If not already installed, install the SRA toolkit and disable the cache.

```
wget http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.8.1-3/sratoolkit.2.8.1-3-ubuntu64.tar.gz
tar -xzf sratoolkit.2.8.1-3-ubuntu64.tar.gz
export PATH=$PATH:~/sratoolkit.2.8.1-3-ubuntu64/bin
```

```
cd ~/sratoolkit.2.8.1-3-ubuntu64/bin
./vdb-config --interactive-mode 'textual'
6
Y 
```
Download paired-end fastq. Note that trinity requires some `--defline-seq` magic for functional assembly. 
```
cd /mnt/
mkdir work
cd /mnt/work
mkdir paired
cd paired
mkdir raw_data
cd raw_data

for accession in ERR1346597
do
~/sratoolkit.2.8.1-3-ubuntu64/bin/fastq-dump.2.8.1-3 --defline-seq '@$sn[_$rn]/$ri' --split-files ${accession} --gzip 
done 
```

Split the reads with khmer
```
split-paired-reads.py -1 ERR1346597_R1.fastq.gz -2 ERR1346597_R2.fastq.gz --gzip ERR1346597.fastq.gz
```


### Quality control

```
fastqc *gz
```

Trim the reads

Make a directory and link in raw data
```
cd /mnt/work/paired
mkdir quality
ln -s ../raw_data/*.fastq.gz .
```
Download adapter file
```
wget https://github.com/taylorreiter/olive_public_seq/blob/master/RNA-seq/many_fruit/pre-processing/illumina-adapters-PE-SE.fa
```

Trim
```
for filename in *_R1*
do
     # first, make the base by removing fastq.gz
     base=$(basename $filename .fastq.gz)
     echo $base

     # now, construct the R2 filename by replacing R1 with R2
     baseR2=${base/_R1./_R2.}
     echo $baseR2

     # finally, run Trimmomatic 
     TrimmomaticPE ${base}.fastq.gz ${baseR2}.fastq.gz \
        ${base}.qc.fq.gz s1_se \
        ${baseR2}.qc.fq.gz s2_se \
        ILLUMINACLIP:illumina-adapters-PE-SE.fa:2:40:15 \
        LEADING:2 TRAILING:2 \
        SLIDINGWINDOW:4:2 \
        MINLEN:25

     # save the orphans
     gzip -9c s1_se s2_se >> orphans.qc.fq.gz
     rm -f s1_se s2_se
done
```

Re-run FastQC
```
fastqc *.gz
```

Make trimmed reads read-only
```
chmod u-w /mnt/work/paired/quality/*.qc.fq.gz
```

### Format

Interleave the sequences
```
for filename in *_R1*.qc.fq.gz
do
     # first, make the base by removing .extract.fastq.gz
     base=$(basename $filename .qc.fq.gz)
     echo $base

     # now, construct the R2 filename by replacing R1 with R2
     baseR2=${base/_R1/_R2}
     echo $baseR2

     # construct the output filename
     output=${base/_R1/}.pe.qc.fq.gz

     (interleave-reads.py ${base}.qc.fq.gz ${baseR2}.qc.fq.gz | \
         gzip > $output)
done
```
Make these sequences read only as well
```
chmod u-w *.pe.qc.fq.gz orphans.qc.fq.gz
```
