In my further attempt to ID things that are not olive in these samples, I am trying sourmash SBT_gather "using microbes.sbt.json". 

CSV listing what is in the SBT (NB SBT stands for sequence bloom tree)

https://s3-us-west-1.amazonaws.com/spacegraphcats.ucdavis.edu/sra-bacteria-wgs-360k.categories.csv.gz

Actual file containing the SBT signatures

http://spacegraphcats.ucdavis.edu.s3.amazonaws.com/2017-01-18-microbial-wgs-sigs.tar.gz

Outline
* Unmount AWS instance with data. 
* Create new AWS instance. 
* download sourmash, SBT signatures, etc. 
* Mount drive 
* Run Sourmash on reads that did not align to the olive reference genome (~18% of the original fastq files). 

Commence!

```
sudo apt-get update && \
sudo apt-get -y install screen git curl gcc make g++ python-dev unzip \
        default-jre pkg-config libncurses5-dev r-base-core r-cran-gplots \
        python-matplotlib python-pip python-virtualenv sysstat fastqc \
        trimmomatic bowtie samtools blast2 wget bowtie2 openjdk-8-jre \
        hmmer ruby
```
        
Install khmer 

NB must source the environment to use khmer
```
cd ~
python2.7 -m virtualenv khmerEnv
source khmerEnv/bin/activate
pip2 install khmer
source khmerEnv/bin/activate
nosetests khmer --attr '!known_failing,!huge'
pip2 install khmer[tests]
nosetests khmer --attr '!known_failing,!huge'
```

check that trim-low-abund.py is functional with `trim-low-abund.py`

Install sourmash
```
cd ~
python2.7 -m virtualenv sourmashEnv2
source sourmashEnv2/bin/activate
git clone https://github.com/dib-lab/sourmash.git
cd sourmash
make install
source sourmashEnv2/bin/activate
```

Install from source code
```
cd ~/sourmashEvn2
pip install -U setuptools
git clone https://github.com/dib-lab/khmer.git
cd khmer
make install
```

install numpy
```
deactivate
pip install numpy 
source sourmashEnv2/bin/activate
```

Download SBT signatures 
```
mkdir sourmash_SBTs
wget http://spacegraphcats.ucdavis.edu.s3.amazonaws.com/microbe-sbt-k21-2016-11-27.tar.gz
wget http://spacegraphcats.ucdavis.edu.s3.amazonaws.com/microbe-sbt-k31-2016-11-27.tar.gz
wget http://spacegraphcats.ucdavis.edu.s3.amazonaws.com/microbe-sbt-k51-2016-11-27.tar.gz
tar -xzvf microbe-sbt-k21-2016-11-27.tar.gz
tar -xzvf microbe-sbt-k31-2016-11-27.tar.gz
tar -xzvf microbe-sbt-k51-2016-11-27.tar.gz
```

mount the volume with data on it
```
lsblk
sudo mount /dev/xvdf1 /mnt/
```

Trim low abundance k-mers using khmer
https://khmer.readthedocs.io/en/v2.0/user/scripts.html
```
mkdir trim-low-abund
cd trim-low-abund
ln -s ../*qc.fq.gz .
trim-low-abund.py -k 21 -C 3 -M 3e10 --variable-coverage --gzip *qc.fq.gz
```

Compute signatures on fastq files
```
mkdir sourmash_signatures
cd sourmash_signatures
ln -s ../trim-low-abund/*abundtrim .
for infile in *abundtrim
    do
        sourmash compute -k 21,31,51 -o sourmash_compute_sigs_${infile} --track-abundance --scaled 10000 ${infile}
done
```

Rename files
```
mv sourmash_compute_sigs_unaligned_SRR926282qc.fq.gz.abundtrim unaligned_SRR926282qc.fq.sig
mv sourmash_compute_sigs_unaligned_SRR926283qc.fq.gz.abundtrim unaligned_SRR926283qc.fq.sig
mv sourmash_compute_sigs_unaligned_SRR926284qc.fq.gz.abundtrim unaligned_SRR926284qc.fq.sig
mv sourmash_compute_sigs_unaligned_SRR926285qc.fq.gz.abundtrim unaligned_SRR926285qc.fq.sig
mv sourmash_compute_sigs_unaligned_SRR926286qc.fq.gz.abundtrim unaligned_SRR926286qc.fq.sig
mv sourmash_compute_sigs_unaligned_SRR926287qc.fq.gz.abundtrim unaligned_SRR926287qc.fq.sig
```

Run SBT gather on sourmash signatures from fastq files, against signature databases downloaded above
```
for k_size in 21 31 51
 do
   for sig in <path to sig files>
     do
        for infile in sourmash_compute_sigs*
          do
            sourmash sbt_gather -k ${k_size} ${infile} ${sig} --threshold=0.001 -o k${k_size}_${sig}_${infile}.txt
          done 
      done
done
```

Alternate:
```
mkdir sourmash_sbt_gather
cd sourmash_sbt_gather
ln -s ../sourmash_signatures/*sig .
```
```
for infile in *.sig
  do
    sourmash sbt_gather -k 31 ~/sourmash_SBTs/microbes.k31.sbt.json ${infile} --threshold=0.001 -o microbesk31_${infile}.txt
 done
 ```
 ```
for infile in *.sig
  do
    sourmash sbt_gather -k 51 ~/sourmash_SBTs/microbes.k51.sbt.json ${infile} --threshold=0.001 -o microbesk51_${infile}.txt
 done
```
```
for infile in *.sig
  do
    sourmash sbt_gather -k 21 ~/sourmash_SBTs/microbes.sbt.json ${infile} --threshold=0.001 -o microbesk21_${infile}.txt
 done
 ```
 
Install and load dropbox
```
deactivate # exit sourmashEnv2
cd ~
wget -O dropbox.tar.gz "http://www.dropbox.com/download/?plat=lnx.x86_64"
tar -xvzf dropbox.tar.gz
~/.dropbox-dist/dropboxd &
```
