To classify which microbes may be present in the samples, run kaiju on the quality trimmed reads. Use the reads that have been trimmed by trimmomatic and khmer trim-low-abund to do this. 

Note to self, consider running this a second time with reads that are trimmed with trim-low-abund without specifying `--variable-coverage` to see how the output changes. 

First, set up files
```
cd /mnt/work/
mkdir kaiju
cd kaiju
mkdir trim-low-abund-v
cd trim-low-abund-v
```

link in quality trimmed reads. Do this from the `/mnt/work/sourmash/trim-low-abund` directory, because cleaned, interleaved reads are already present there.
```
ln -s /mnt/work/sourmash/trim-low-abund-v/*abundtrim.fq.gz .
```

Run kaiju!
```
for infile in *.gz
    do
        ~/kaiju/bin/kaiju -t ~/kaijudb_e/nodes.dmp -f ~/kaijudb_e/kaiju_db_nr_euk.fmi -i ${infile} -v -o kaijudb_e_${infile}.out
 done
 ```
 
 Then added taxonomy to kaiju names
```
for infile in *out
    do
        ~/kaiju/bin/addTaxonNames -t ~/kaijudb_e/nodes.dmp -n ~/kaijudb_e/names.dmp -i ${infile} -o ${infile}.names
done
```

Then made kaiju summary report
```
for infile in *out
    do
        ~/kaiju/bin/kaijuReport -t  ~/kaijudb_e/nodes.dmp -n  ~/kaijudb_e/names.dmp -i ${infile} -r genus -o ${infile}.summary
done
```

Converted files to be krona compatible
```
for infile in *out
    do
        ~/kaiju/bin/kaiju2krona -t  ~/kaijudb_e/nodes.dmp -n ~/kaijudb_e/names.dmp -i ${infile} -o ${infile}.krona
done
```

Ran krona on kaiju output
```
for infile in *krona
    do 
        ktImportText -o ${infile}.html ${infile}
done
```


Then, run the whole thing over again, but this time on reads that have been trimmed with `trim-low-abund` without specifying variable coverage.
Although variable coverage may be important for RNA-seq and low coverage classification, it may not be as important for identifying organisms. 

```
cd /mnt/work/kaiju/
mkdir trim-low-abund-no-v
cd trim-low-abund-no-v
```
