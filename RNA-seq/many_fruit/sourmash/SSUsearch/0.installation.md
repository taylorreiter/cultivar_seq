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

sudo apt-get install mothur

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
cd ~/SSUsearch
wget https://s3.amazonaws.com/ssusearchdb/SSUsearch_db.tgz
tar -xzvf SSUsearch_db.tgz
```

Now install anaconda in order to run Jupyter notebook on the instance

http://www.datasciencebytes.com/bytes/2015/12/18/using-jupyter-notebooks-securely-on-remote-linux-machines/
```
wget https://3230d63b5fc54e62148e-c95ac804525aac4b6dba79b00b39d1d3.ssl.cf1.rackcdn.com/Anaconda2-2.4.1-Linux-x86_64.sh
bash Anaconda2-2.4.1-Linux-x86_64.sh
source ~/.bashrc
```

Start jupyer notebook
```
tmux
jupyter notebook --no-browser
# run from your local machine
ssh -i /path/to/ssh/key -NL 8157:localhost:8888 ubuntu@your-remote-machine-public-dns
```
Then, point browser to `http://localhost:8157` and see jupyter notebook!

To sync notebooks:
```
while true; do \
 rsync -avz --include='*.ipynb' --exclude='*' tmpaws:/path/to/notebooks/ /path/to/local/dir/; \
 sleep 30; \
done
```

Download SSUsearch trial dataset as a test run for bugs in the code
```
wget https://s3.amazonaws.com/ssusearchdb/test.tgz 
tar -xzvf ssusearch-test.tgz
```

Worked properly. Noted that test files were in fasta format, not fastq format. Convert fastq files to fastq after quality filtering with fastx-toolkit
```
sudo apt-get install fastx-toolkit
cd ssusearch-trial
fastq_to_fasta -i unaligned_SRR926286qc.fq > unaligned_SRR926286qc.fa
```
