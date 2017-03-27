Set up instance for sourmash, and download and install sourmash and dependencies. 

```
sudo apt-get update && \
sudo apt-get -y install screen git curl gcc make g++ python-dev unzip \
        default-jre pkg-config libncurses5-dev r-base-core r-cran-gplots \
        python-matplotlib python-pip python-virtualenv sysstat wget 

```
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

Install khmer from source code
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


