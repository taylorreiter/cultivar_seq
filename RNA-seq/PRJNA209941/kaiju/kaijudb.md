Kraken was buggy. I was not able to get kraken to work for the bacterial, fungal, archaea, viral, protist database. 
Tried kaiju instead. Kaiju eventually worked correctly, but be weary!!! 
It takes a lot of ram to build, needs as much ram as the size of the .fmi database file to run it on files, and requires a lot of extra hard drive space to write files during the database building process. 

Install kaiju
```
cd ~
git clone https://github.com/bioinformatics-centre/kaiju.git
cd kaiju/src
make
```
Because the `-e` option required so much space, first tried a smaller database to make sure I could get kaiju working.
```
cd /mnt/work
mkdir kaijudb_p
cd kaijudb_p
~/kaiju/bin/makeDB.sh -p
```
Build was successful, test on one fastq file
```
gunzip unaligned_SRR926282qc.fq.gz
~/kaiju/bin/kaiju -t /mnt/work/kaijudb_p/nodes.dmp -f /mnt/work/kaijudb_p/kaiju_db.fmi -i /mnt/work/hisat/unaligned/unaligned_SRR926282qc.fq 
```

Sucessful, make a database with bacteria, archaea, viruses, and eukaryotes

DB made on 3/16/17
```
cd ~
mkdir kaijudb_e
cd kaijudb_e
~/kaiju/bin/makeDB.sh -e
```
This requires a rediculous amount of free space on the volume.

Test kaiju on real read
```
gunzip unaligned_SRR926282qc.fq.gz
~/kaiju/bin/kaiju -t ~/kaijudb_e/kaijudb_e/nodes.dmp -f ~/kaijudb_e/kaijudb_e/kaiju_db_nr_euk.fmi -i /mnt/work/hisat/unaligned/unaligned_SRR926282qc.fq -v -o kaiju_e_test
```

Test suceeded, rename file to match the output of the loop
```
mv kaiju_e_test kaijudb_e_unaligned_SRR926282qc.fq.gz.out
```

Remove dummy files used to build kaijudb
```
rm -rf ...
```

Loop for kaiju
```
for infile in *gz
    do
        ~/kaiju/bin/kaiju -t ~/kaijudb_e/kaijudb_e/nodes.dmp -f ~/kaijudb_e/kaijudb_e/kaiju_db_nr_euk.fmi -i <(gunzip -c ${infile})> -v -o kaijudb_e_${infile}.out
done
```

Add taxon names to kaijudv_e_out file
```
addTaxonNames -t nodes.dmp -n names.dmp -i kaiju.out -o kaiju.names.out
```

Make kaiju summary report
```
kaijuReport -t nodes.dmp -n names.dmp -i kaiju.out -r genus -o kaiju.out.summary
```

Convert files to be krona compatible
```
kaiju2krona -t nodes.dmp -n names.dmp -i kaiju.out -o kaiju.out.krona
```

Install krona
```
wget https://github.com/marbl/Krona/releases/download/v2.7/KronaTools-2.7.tar
tar xzf KronaTools-2.7.tar.gz
cd KronaTools-2.7.tar.gz
./install.pl
updateTaxonomy.sh
updateAccessions.sh
```


Run krona on kaiju output
```
ktImportText -o kaiju.out.html kaiju.out.krona
```



