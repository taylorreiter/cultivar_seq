# Steps to getting started with this project

NB this data will also work for selecting housekeeping genes for qPCR

1. Set up an AWS instance with the appropriate interface, CPU, storage, and RAM.
  1. From the Iaria et al. 2017 paper: "Trinity was run via script using **128 GB of ram, 12 cpu thread** and a minimum assembled contig length to report set to 300 bp."
  2. This was for there four samples. 
  3. IDEA: analyze samples separately, with Eel Pond run on the set of four samples and the set of 5 samples separately.
2. Determine how to pause an instance, resize an instance, and use an external disk.
4. Begin with an m4.xlarge.
  1. Determine how much hard drive storage is in m4.xlarge
  3. From Titus: "Everything but the ram is cheap :). And you don't need the ram for the first few steps. Suggest doing thru end of kmer trimming on an m4.xlarge."
5. Learn to tmux or screen so that computer can be shut when the instance is running.
6. Load in data (Iaria et al. 2017 first)
7. Begin Eel Pond protocol. Run Eel Pond through Salmon
8. Ask if anyone has experience with RNAseq Network graphs

