# Notes
This directory serves as a brain dump for all my notes on random things I learn, find interesting, or just want to throw in here for the sake of throwing in here.

## CIDR notes
-----------------------------------------------------------
CIDR is a method for allocating IP addresses and routing IP packets more efficiently than the old class-based system. It replaces traditional subnet masks like 255.255.255.0 with more compact /xx notation.

example
-  192.168.1.0/24
  - /24 means the first 24 bits are the network portion.
  - Equivalent to subnet mask 255.255.255.0.
  - Provides 256 IP addresses (254 usable hosts).

- Common ranges:
  - /24 → 256 IPs (254 usable)
  - /16 → 65,536 IPs (65,534 usable)
  - /32 → 1 IP (used for single host routes)
-----------------------------------------------------------


## Qemu Agent
Helper daemon that runs inside the VM, allows the Proxmox host to communicate more intelligently with the guest.
- Accurate IP address reporting in the Proxmox GUI
- Graceful shutdown/reboot commands
- Live backup and snapshot coordination
- File system freeze/thaw (for consistent backups)
- Better VM status monitoring

## NUMA (Non-Uniform Memory Access)
- advanced memory management feature for multi-socket systems, tries to optimize memory patterns associated with memory and cpus
- not really needed for single socket devices, or using small vms that don't need performance tuning
- it generally helps performance on multi socket cpus and larger memory pools

## VM config sync automation
I would make it a habit to run a git pull before syncing the vm configs so that we stay up to date on any changes I make on the documenation before pushing config syncs.

`cd /root/homelab`
`git pull --rebase`
`exportncommit`

## Enable VM usb passthrough
- open up proxmox console, type lsusb to spot check the usb you want to add shows up and is recognized by the hardware, in my case I can see the mediaTek Adapater below

```bash
angus@pve:~$ lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 002: ID 0e8d:7612 MediaTek Inc. MT7612U 802.11a/b/g/n/ac Wireless Adapter
Bus 001 Device 003: ID 8087:0026 Intel Corp. AX201 Bluetooth
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

1) Method 1 (gui)

- go to the vm you want to pass it through
-  `angusMintDev` > `hardware` > `add` > `USB device` > `use usb vendor/deviceID` > `0e8d:7612 MediaTek Inc. MT7612U 802.11a/b/g/n/ac Wireless Adapter`
- verify on VM console by opening up shell and typing lsusb, should now show up.

2) Method 2 (qm commands)

- I also found out that you can do this through qm commands using `qm set 101 -usb0 host=0e8d:7612` to set it through the host, basically bypasing the GUI and assigning the device ID directly to the vm ID. 

The opposite of this is `qm set 101 -delete usb0` to remove it. You can verify the changes using `qm config 101`. 

----------------------------- 
- *note, I tried to do the methods above with my PVE admin, but since its a hardware mod I need `Sys.Modify` minimum added to my pve admin, I just quickly swapped to root to make the change due to simplicity.*
