# Dell PowerEdge T340

*Machine 02 - 30 May 2026*

The Dell PowerEdge T340 is a robust, enterprise-grade tower server designed for high availability, massive storage capacity, and continuous uptime.

https://www.dell.com/support/product-details/en-ie/product/poweredge-t340/

## Hardware

| Component | Description | Specification |
| :--- | :--- | :--- |
| **Processor (CPU)** | Intel Xeon E-2224 | 4 Cores, 4 Threads @ 3.40 GHz - 71W TDP |
| **Graphics (iGPU)** | | basic video output via motherboard |
| **Memory (RAM)** | 16GB DDR4 ECC | 2x 8GB @ 2666MHz UDIMM (2/4 slots used) |
| **Storage** | . . . | 8x 3.5" Drive Bays |
| **RAID Controller** | Dell PERC H730P | 2GB cache |
| **Network Controller** | NetXtreme BCM5720 | 2x ethernet ports |
| **Remote Management** | iDRAC9 Basic | 1x dedicated ethernet port |
| **Power Supply** | Platinum | 1x 495W (1/2 slots used) |

## Bay Configuration

| Slot | Description | Size | Type | Configuration |
| :---: | :--- | :---: | :---: | :--- |
| **0** | Intenso Performance 2.5" SSD | 1TB | SSD | Non-RAID (Host OS / Boot) |
| **1** | | | | |
| **2** | Hitachi Ultrastar 7K2 (`HNWHH`) | 1TB | HDD | |
| **3** | Hitachi Ultrastar 7K2 (`HNWHH`) | 1TB | HDD | |
| **4** | Western Digital RED (`WD20EFRX`) | 2TB | HDD | RAID 10 (Storage Pool) |
| **5** | Western Digital RED (`WD20EFRX`) | 2TB | HDD | RAID 10 (Storage Pool) |
| **6** | Western Digital RED (`WD20EFRX`) | 2TB | HDD | RAID 10 (Storage Pool) |
| **7** | Western Digital RED (`WD20EFRX`) | 2TB | HDD | RAID 10 (Storage Pool) |

## Software

## Future Plans

* [X] Replace OS HDDs with SSD
* [X] Remaining 6x bay caddies
* [ ] Second 495W PSU
* [ ] RAM upgrade to 32GB
* [ ] bay slots 1-3

