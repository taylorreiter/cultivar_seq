## Run KRAKEN on samples. 
### Use MiniDB, a fungal DB, and fungal/archaea/bacterial/viral/protist DB

#### Install KRAKEN

Instructions followed from: http://angus.readthedocs.io/en/2016/kraken_species_identification.html
```
cd ~
sudo apt-get -y update
sudo apt-get -y install bioperl ruby build-essential curl git python-setuptools wget
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
export PATH="$HOME/.linuxbrew/bin:$PATH"
export PATH="$HOME/.linuxbrew/bin:$PATH"
brew tap homebrew/science
brew install kraken
```

#### Install miniKRAKEN database

MiniKraken DB (2.7 GB): A pre-built 4 GB database constructed from complete bacterial, archaeal, and viral genomes in RefSeq (as of Dec. 8, 2014). 
This can be used by users without the computational resources needed to build a Kraken database.

```
cd $HOME
curl https://ccb.jhu.edu/software/kraken/dl/minikraken.tgz | tar zxvf -
export KRAKEN_DEFAULT_DB=$HOME/minikraken_20141208
export KRAKEN_NUM_THREADS=$(getconf _NPROCESSORS_ONLN)
```

#### Run KRAKEN minikraken

```
mkdir kraken
cd /mnt/work/hisat/unaligned/kraken
ln -s /mnt/work/hisat/unaligned/*qc.fq.gz .
```

```
for infile in *qc.fq.gz
    do
        kraken --preload --db ~/minikraken_20141208 --fastq-input --gzip-compressed ${infile} > ${infile}_kraken.out
done
```

Translate the files in to something more readable: 
```
for infile in *qc.fq.gz
   do
        kraken-translate --db ~/minikraken_20141208 ${infile}_kraken.out > ${infile}_labels
done
```

Translate them in an other way:
STILL NEED TO DO THIS
```
kraken-report kraken.out > kraken.tab**
```

move files
```
mkdir minikraken_run
for infile in *kraken.out; do mv $infile minikraken_run/$infile; done
for infile in *labels; do mv $infile minikraken_run/$infile; done
```

#### Make fungus database

per http://www.opiniomics.org/building-a-kraken-database-with-new-ftp-structure-and-no-gi-numbers/

install dependency that is required to build kraken databases. Note that a specific version of jellyfish is required for the version of kraken that we have installed. 
```
brew install jellyfish-1.1
brew link --force jellyfish-1.1
```

```
git clone https://github.com/mw55309/Kraken_db_install_scripts.git
mkdir downloads
cd downloads
perl ~/Kraken_db_install_scripts/download_fungi.pl
```

```
kraken-build --download-taxonomy --db kraken_fungi_080416
```

build fungal database (upgrade to mn m4.2xlarge with 32 gb ram)
jellyfish hash -- '161607432'

```
kraken-build --build --db kraken_fungi_080416
```

for each branch add all .fna to the directory (here, only fungi, but loop would incorporate the other possibilities)
```
for dir in fungi; do
        for fna in `ls $dir/*.fna`; do
                kraken-build --add-to-library $fna --db kraken_fungi_080416
        done
done
```

```
cd /mnt/work/hisat/unaligned
for infile in *qc.fq.gz
    do
        kraken --preload --db ~/Kraken_db_install_scripts/downloads/kraken_fungi_080416 --fastq-input --gzip-compressed ${infile} > ${infile}_kraken.out
done
```

#### Repeat, but for an extended version of the database that include fungus, archaea, bacteria, protists, and viral. 

```
perl ~/Kraken_db_install_scripts/download_fungi.pl
perl ~/Kraken_db_install_scripts/download_bacteria.pl
perl ~/Kraken_db_install_scripts/download_archaea.pl
perl ~/Kraken_db_install_scripts/download_protozoa.pl
perl ~/Kraken_db_install_scripts/download_viral.pl
```

```
kraken-build --download-taxonomy --db kraken_bvfpa_080416
```

```
for dir in fungi protozoa archaea viral bacteria; do
        for fna in `ls $dir/*.fna`; do
                kraken-build --add-to-library $fna --db kraken_bvfpa_080416
        done
done
```


build fungal, archaea, viral, protist, bacterial database
jellyfish hash -- '161607432'
```
kraken-build --build --db kraken_bvfpa_080416
```

#### run on unaligned fastq reads

