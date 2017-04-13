If a volume needs to be mounted, use `sudo mount /dev/xvdf /mnt/`

Use `pondenv` khmer to trim reads. 
```
cd /mnt/work/hisat/unaligned
mkdir trim-low-abund
cd trim-low-abund
ln -s ../*qc.fq.gz .
ln -s ../*qc.fq.gz .
trim-low-abund.py -k 21 -C 3 -M 15e9 --variable-coverage --ignore-pairs *.fq
```

Output:
```
read 61769140 reads, 3419718676 bp
wrote 58900670 reads, 3216276377 bp
looked at 32138833 reads twice (1.52 passes)
removed 2868470 reads and trimmed 2483374 reads (8.66%)
trimmed or removed 5.95% of bases (203442299 total)
35969053 reads were high coverage (58.23%);
skipped 25800087 reads/1375642756 bases because of low coverage
fp rate estimated to be 0.002
output in *.abundtrim
```

Compute Sourmash signatures for each file. Compute for *kmer* size 21, 31, and 51, even though the index was only made for 31 right now. Also compute at `--scaled 500` so that down sampling can occur from the individual signature files. 
```
cd /mnt/work/hisat/unaligned
mkdir sourmash_signatures
cd sourmash_signatures
ln -s ../trim-low-abund/*abundtrim .
for infile in *abundtrim
    do
        sourmash compute -k 21,31,51 -o sourmash_compute_sigs_${infile} --track-abundance --scaled 500 ${infile}
done
```
Those file names were quite silly, rename:
```
mv sourmash_compute_sigs_unaligned-pe_ERR1346597_1.qc.fq.abundtrim  unaligned-pe_ERR1346597_1.qc.fq.abundtrim.sig
mv sourmash_compute_sigs_unaligned-pe_ERR1346597_2.qc.fq.abundtrim  unaligned-pe_ERR1346597_2.qc.fq.abundtrim.sig
mv sourmash_compute_sigs_unaligned-se_ERR1346597qc.fq.abundtrim     unaligned-se_ERR1346597qc.fq.abundtrim.sig
mv sourmash_compute_sigs_unaligned_SRR1573503qc.fq.abundtrim        unaligned_SRR1573503qc.fq.abundtrim.sig
mv sourmash_compute_sigs_unaligned_SRR1574328qc.fq.abundtrim        unaligned_SRR1574328qc.fq.abundtrim.sig
mv sourmash_compute_sigs_unaligned_SRR1574719qc.fq.abundtrim        unaligned_SRR1574719qc.fq.abundtrim.sig
mv sourmash_compute_sigs_unaligned_SRR1574772qc.fq.abundtrim        unaligned_SRR1574772qc.fq.abundtrim.sig
mv sourmash_compute_sigs_unaligned_SRR4236909qc.fq.abundtrim        unaligned_SRR4236909qc.fq.abundtrim.sig
mv sourmash_compute_sigs_unaligned_SRR4236910qc.fq.abundtrim        unaligned_SRR4236910qc.fq.abundtrim.sig
mv sourmash_compute_sigs_unaligned_SRR4236911qc.fq.abundtrim        unaligned_SRR4236911qc.fq.abundtrim.sig
mv sourmash_compute_sigs_unaligned_SRR4236912qc.fq.abundtrim        unaligned_SRR4236912qc.fq.abundtrim.sig
```

Use `sbt_gather` to determine what fungi from the 1KFG project are in these samples.

Link in signature files calculated from the unaligned reads produced by hisat: 

```
cd /mnt/work/hisat/unaligned/
mkdir sourmash_sbt_gather
cd sourmash_sbt_gather
ln -s ../sourmash_signatures/*sig .
```
Run sourmash
```
source ~/sourmashEnv2/bin/activate
for infile in *.sig
  do
    sourmash sbt_gather -k 31 ~/sourmash_SBTs/fungal_sigs/KFG_3.27.17.sbt.json ${infile} --threshold=0.001 -o KFG_k31_${infile}.txt
 done
 ```
 
 Repeat, this time using the index that has 1KFG, ref seq, and genbank
 ```
 for infile in *.sig
  do
    sourmash sbt_gather -k 31 ~/sourmash_SBTs/fungal_4.08.17.sbt.json  ${infile} --threshold=0.001 -o fungi_k31_${infile}.txt
 done
 ```
