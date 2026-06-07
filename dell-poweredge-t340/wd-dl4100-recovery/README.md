# WD DL4100 RAID Data Recovery

WD My Cloud DL4100 NAS device has failed due to the Intel Atom C2000 flaw known as AVR54. The NAS contained 4x 2TB HDD drives running linux based RAID 10 configuraion. 

I wanted 

## 1. Prepare For Recovery

Using Dell PowerEdge T340 

Insert 4x HDDs into available bays

You must set the PERC controller to HBA mode or set each disk to Non-RAID before booting to avoid the controller overwriting mdadm metadata or causing disks to be unavailable in Ubuntu Server.

- Press F2 during boot to enter BIOS

- System Setup > Device Settings > RAID Controller (PERC H730P) > Physical Disk Management

- For each drive select Operation > Convert to Non-RAID

- Each drive should show Status Non-RAID

Install Ubuntu Server OS on device or run temporarily from a flashed USB

Boot into Ubuntu Server

## 2. Raw Drive Info
Information about available drives and their partitions
```bash
lsblk
```
Ensure all 4x HDDs are available

*sample output:*

```
ubuntu-server@ubuntu-server:~$ lsblk
NAME      MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
loop0       7:0    0 156.1M  1 loop  /rofs
loop1       7:1    0 138.1M  1 loop
loop2       7:2    0 661.9M  1 loop
loop3       7:3    0 254.6M  1 loop
loop4       7:4    0 156.1M  1 loop  /media/minimal
loop5       7:5    0 138.1M  1 loop  /media/full
loop6       7:6    0  73.9M  1 loop  /snap/core22/2045
loop7       7:7    0  49.3M  1 loop  /snap/snapd/24792
loop8       7:8    0  20.3M  1 loop  /snap/subiquity/6806
sda         8:0    0   1.8T  0 disk
├─sda1      8:1    0     2G  0 part
│ └─md127   9:127  0     2G  0 raid1
├─sda2      8:2    0   1.8T  0 part
│ └─md126   9:126  0   3.6T  0 raid10
├─sda3      8:3    0     1G  0 part
└─sda4      8:4    0     1G  0 part
sdb        8:16    0   1.8T  0 disk
├─sdb1     8:17    0     2G  0 part
│ └─md127  9:127   0     2G  0 raid1
├─sdb2     8:18    0   1.8T  0 part
│ └─md126  9:126   0   3.6T  0 raid10
├─sdb3     8:19    0     1G  0 part
└─sdb4     8:20    0     1G  0 part
sdc        8:32    0   1.8T  0 disk
├─sdc1     8:33    0     2G  0 part
│ └─md127  9:127   0     2G  0 raid1
├─sdc2     8:34    0   1.8T  0 part
│ └─md126  9:126   0   3.6T  0 raid10
├─sdc3     8:35    0     1G  0 part
└─sdc4     8:36    0     1G  0 part
sdd        8:48    0   1.8T  0 disk
├─sdd1     8:49    0     2G  0 part
│ └─md127  9:127   0     2G  0 raid1
├─sdd2     8:50    0   1.8T  0 part
│ └─md126  9:126   0   3.6T  0 raid10
├─sdd3     8:51    0     1G  0 part
└─sdd4     8:52    0     1G  0 part
sde        8:64    1  14.5G  0 disk
├─sde1     8:65    1   3.1G  0 part  /cdrom
├─sde2     8:66    1     5M  0 part
├─sde3     8:67    1   300K  0 part
└─sde4     8:68    1  11.4G  0 part  /var/crash
                                     /var/log
sr0        11:0    1  1024M  0 rom
ubuntu-server@ubuntu-server:~$
```

see above ```sda```, ```sdb```, ```sdc```, ```sdd``` are the 4x HDDs

Each disk contains

| Partition | Size | Purpose | RAID |
|---|---|---|---|
| 1 | 2GB | WD OS/firmware | ```md127``` RAID 0 |
| **2** | **1.8TB** | **User Data** | ```md126```  RAID 10 | 
| 3 | 1GB | Swap | |
| 4 | 1GB | Config/logs | |

## 3. Verify Arrays
See if the kernel can automatically detects array partitions
```bash
cat /proc/mdstat
```
Look for `[UUUU]` on md126 and that all 4 drives healthy

*sample output:*

```
cat /proc/mdstat
Personalities : [raid10] [raid1] [raid0] [raid6] [raid5] [raid4]
md126 : active raid10 sde2[3] sdd2[2] sdb2[0] sdc2[1]
      3898637824 blocks super 1.0 128K chunks 2 near-copies [4/4] [UUUU]
      bitmap: 0/8 pages [0KB], 262144KB chunk

md127 : active (auto-read-only) raid1 sdd1[2] sdb1[0] sdc1[1] sde1[3]
      2097088 blocks [4/4] [UUUU]
      bitmap: 0/128 pages [0KB], 8KB chunk

unused devices: <none>
```

## 3 Access Data

Create mount point
```bash
sudo mkdir -p /mnt/wd
```

Mount to folder
```bash
sudo mount /dev/md126 /mnt/wd
```

Access folder
```bash
cd /mnt/wd
ls
```

Copy files to recovery drive or USB

## Permanent Mount

Save array unique signature to mdadm config
```bash
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
```
*sample output:*
```
ARRAY /dev/md/127_0 metadata=0.90 UUID=1e3c8fa9:5177dadf:ac7893b6:9eeb5b59
ARRAY /dev/md/1_0 metadata=1.0 UUID=60d755e1:4bfcc598:fa5c905d:398869d3 
```

Note that here the ```md126``` array is actually ```1_0```

Rebuild initramfs to read this config during the early boot process
```bash
sudo update-initramfs -u
```

Get the array's UUID
```bash
sudo blkid /dev/md/1_0
```

Add UUID to ```/etc/fstab```
```bash
UUID="<array-uuid>" /mnt/wd ext4 defaults,nofail 0 2
```

RAID array should mount on reboot now

## Notes
- Drive slot order doesn't matter as mdadm uses metadata UUIDs, but it is good practice to still lable drives.
- `nofail` in fstab prevents boot hang if array is offline
- Power down fully before moving drives