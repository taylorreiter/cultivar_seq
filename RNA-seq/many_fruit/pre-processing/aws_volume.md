Make a new volume for data.

Start instance

```
lsblk
```

Note that the volumen needs to be formatted. Make sure the right disk is specified here, or all data will be overwritten.
```
sudo mkfs.ext4 /dev/xvdf 
```
```
lsblk
```
Mount the disk
```
sudo mount /dev/xvdf /mnt/
```
