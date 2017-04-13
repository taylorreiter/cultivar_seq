Run `sourmash sbt_gather` on the quality controlled olive fruit reads. 

Here, quality controlled is defined as trimmomatic and khmer `trim-low-abund -v`. 

```
cd mnt/work/
mkdir sourmash
cd sourmash
mkdir signatures
```

Link in abundance trimmed reads
