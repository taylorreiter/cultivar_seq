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
~/kaiju/bin/kaiju -t ~/kaijudb_e/nodes.dmp -f ~/kaijudb_e/kaiju_db_nr_euk.fmi -i /mnt/work/hisat/unaligned/unaligned_SRR926282qc.fq -v -o kaiju_e_test
```

Test suceeded, rename file to match the output of the loop
```
mv kaiju_e_test kaijudb_e_unaligned_SRR926282qc.fq.gz.out
```

Remove dummy files used to build kaijudb
The output of the database build process states:
```
You can delete the folder genomes/ as well as the files taxdump.tar.gz, kaiju_db.faa, kaiju_db.bwt, and kaiju_db.sa
Kaiju only needs the files kaiju_db.fmi, nodes.dmp, and names.dmp.
```

```
cd ~/kaijudb_e/kaijudb_e/
rm -rf genomes/ kaiju_db_nr_euk.bwt kaiju_db_nr_euk.sa kaiju_db_nr_euk.faa taxdump.tar.gz nr.gz prot.accession2taxid prot.accession2taxid.gz
```
Note how much space these files took up!
```
total 167909728
-rw-rw-r-- 1 ubuntu ubuntu 33420490846 Mar 17 02:25 kaiju_db_nr_euk.bwt
-rw-rw-r-- 1 ubuntu ubuntu 35484801934 Mar 17 01:00 kaiju_db_nr_euk.faa
-rw-rw-r-- 1 ubuntu ubuntu 48369697476 Mar 17 02:37 kaiju_db_nr_euk.fmi
-rw-rw-r-- 1 ubuntu ubuntu  9380484230 Mar 17 02:25 kaiju_db_nr_euk.sa
-rw-r--r-- 1 ubuntu ubuntu      837101 Mar 16 23:20 merged.dmp
-rw-r--r-- 1 ubuntu ubuntu   138034822 Mar 16 23:20 names.dmp
-rw-r--r-- 1 ubuntu ubuntu   107384758 Mar 16 23:20 nodes.dmp
-rw-rw-r-- 1 ubuntu ubuntu 27940725654 Mar 16 07:45 nr.gz
-rw-rw-r-- 1 ubuntu ubuntu 14285367259 Mar 16 23:57 prot.accession2taxid
-rw-rw-r-- 1 ubuntu ubuntu  2811685571 Mar 12 08:38 prot.accession2taxid.gz
```

Loop for kaiju
```
for infile in *gz
    do
        ~/kaiju/bin/kaiju -t ~/kaijudb_e/nodes.dmp -f ~/kaijudb_e/kaiju_db_nr_euk.fmi -i <(gunzip -c ${infile})> -v -o kaijudb_e_${infile}.out
    done
```
Move kaiju files
```
mkdir kaiju_e
for infile in *.out 
    do
        mv infile kaiju_e/${infile}
done
```

Add taxon names to kaijudv_e_out file
```
cd kaiju_e
for infile in *out
    do
        ~/kaiju/bin/addTaxonNames -t ~/kaijudb_e/nodes.dmp -n ~/kaijudb_e/names.dmp -i ${infile} -o ${infile}.names
done
```

Make kaiju summary report
```
for infile in *out
    do
        ~/kaiju/bin/kaijuReport -t  ~/kaijudb_e/nodes.dmp -n  ~/kaijudb_e/names.dmp -i ${infile} -r genus -o ${infile}.summary
done
```

Convert files to be krona compatible
```
for infile in *out
    do
        ~/kaiju/bin/kaiju2krona -t  ~/kaijudb_e/nodes.dmp -n ~/kaijudb_e/names.dmp -i ${infile} -o ${infile}.krona
done
```

Install krona
Would not properly download from website on to machine. Downloaded on to personal computer, uploaded unpacked version to Dropbox, and downloaded to my instance.

Linked dropbox, then
```
git clone https://github.com/marbl/Krona.git
cd Krona/KronaTools/
sudo ./install.pl
```
Output
```
Creating links...

Installation complete.

Run ./updateTaxonomy.sh to use scripts that rely on NCBI taxonomy:
   ktClassifyBLAST
   ktGetLCA
   ktGetTaxInfo
   ktImportBLAST
   ktImportTaxonomy
   ktImportMETAREP-BLAST

Run ./updateAccessions.sh to use scripts that get taxonomy IDs from accessions:
   ktClassifyBLAST
   ktGetTaxIDFromAcc
   ktImportBLAST
```
```
./updateTaxonomy.sh
```
Output
```
./updateTaxonomy.sh: line 191: cd: /home/ubuntu/Krona/KronaTools/taxonomy: No such file or directory

Update failed.
   Could not enter '/home/ubuntu/Krona/KronaTools/taxonomy'.
```
```
./updateAccessions.sh
```


Run krona on kaiju output
```
cd /mnt/work/hisat/unaligned/kaiju_e
for infile in *krona
    do 
        ktImportText -o ${infile}.html ${infile}
done
```
Copy to Dropbox
```
for infile in *html; do cp ${infile} ~/Dropbox/cultivar_seq_PRJNA209941/${infile}; done
```



