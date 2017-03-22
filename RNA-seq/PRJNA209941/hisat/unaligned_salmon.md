Quantify read counts with Salmon

Note this was performed on all reads, not just on the unaligned reads. 
```
cd /mnt/work/hisat/unaligned
mkdir -p quant
cd quant
ln -s /mnt/work/hisat/unaligned/assembly/trinity_out_dir/Trinity.fasta .
```
Index transcriptome
```
salmon index --index cultivar-seq-unaligned --transcripts Trinity.fasta --type quasi
```

Link to qc'd reads
```
ln -s ../quality/*qc.fq.gz .
```  
Run Salmon
```
for file in *qc.fq.gz
  do
    salmon quant -i nema -p 2 -l IU -r <(gunzip -c ${file}) -o ${file}quant
done
```
