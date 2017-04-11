Install SSUsearch. Use to find 16s rDNA and ITS sequences as another way to find "who's there" in the olive fruit samples. 

Begin by creating a tool bin and putting it in the path
```
cd ~
mkdir ~/tool_bin
export PATH=$HOME/tool_bin:$PATH
```
Install dependencies and export to bin
```
wget http://eddylab.org/software/hmmer3/3.1b2/hmmer-3.1b2-linux-intel-x86_64.tar.gz 
tar -xzvf hmmer-3.1b2-linux-intel-x86_64.tar.gz
cp hmmer-3.1b2-linux-intel-x86_64/binaries/hmmsearch ~/tool_bin

wget http://www.mothur.org/w/images/8/88/Mothur.cen_64.zip -O mothur.zip
unzip mothur.zip
cp mothur/mothur ~/tool_bin

wget http://athyra.oxli.org/~gjr/public2/misc/Clustering.tar.gz
tar -xzvf Clustering.tar.gz
```
Install SSUsearch inside of a python environment
```
cd ~
python2.7 -m virtualenv SSUsearchEnv
source SSUsearchEnv/bin/activate
git clone https://github.com/dib-lab/SSUsearch.git
source SSUsearchEnv/bin/activate
```

Install python dependencies
```
pip install screed nbrewer2mpl
pip install numpy
pip install biom-format 
pip install matplotlib
pip install scipy pandas
```

Install the database files SSUsearch needs
```
wget https://s3.amazonaws.com/ssusearchdb/SSUsearch_db.tgz
tar -xzvf SSUsearch_db.tgz
```
