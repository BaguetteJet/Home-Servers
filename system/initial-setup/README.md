# Initial Setup

Following guide: [Ubuntu Server: Getting started with a Linux Server](https://youtu.be/2Btkx9toufg?si=N1MSE7QlsCTECE61)

## OS Install

Flash [Ubuntu Server 24.04 LTS](https://ubuntu.com/download/server) onto usb stick

Plug usb stick into machine and enter boot menu

Select install Ubuntu Server

Continue...

### Netwrok connections

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

### Storage configuration

I chose to dual booting with Windows 11 so I created a new partition though Windows formatted as EXT4

Custom storage layout > select partition

Continue...

Install OpenSSH to run headless

Don't select snap packages

Reboot now

## Automatic updates

See [how to setup automatic updates](../../maintenance/README.md)
