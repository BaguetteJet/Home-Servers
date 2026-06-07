# Ubuntu Server OS

Following guide: [Ubuntu Server: Getting started with a Linux Server](https://youtu.be/2Btkx9toufg?si=N1MSE7QlsCTECE61)

Flash [Ubuntu Server 24.04 LTS](https://ubuntu.com/download/server) onto usb stick

Plug USB stick into machine and enter boot menu

Select install Ubuntu Server

Continue...

## Netwrok connections

Select network adapter > edit IPv4

Change Automatic DHCP to Manual

```
Subnet:             192.168.1.0/24
Address:            192.168.1.222
Gateway:            192.168.1.1
Name servers:       8.8.8.8, 8.8.4.4
Search domains:
```

Continue...

## Storage configuration

### Machine 01 - Optiplex 5080
Dual boot with Windows 11 so I created a new partition though Windows formatted as EXT4

(X) Custom storage layout

### Machine 02 - Poweredge T340

(X) Use an entire disk

[ ] Set up this disk as an LVM group

Continue...

## Open SSH

Install OpenSSH to run headless

Don't select snap packages

Reboot now

## Automatic updates

See [how to setup automatic updates](../../maintenance/README.md)

## Running OS from USB

Continue as far as storage configuration

Stop and press ```Ctrl``` + ```Alt``` + ```F2``` to open shell
