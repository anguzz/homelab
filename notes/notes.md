# Proxmox Notes 

## Proxmox Cheatsheet 
This page presents a list of commonly used commands for proxmox.

https://sweworld.net/cheatsheets/proxmox/

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
-----------------------------------------------------------

## NUMA (Non-Uniform Memory Access)
- advanced memory management feature for multi-socket systems, tries to optimize memory patterns associated with memory and cpus
- not really needed for single socket devices, or using small vms that don't need performance tuning
- it generally helps performance on multi socket cpus and larger memory pools
-----------------------------------------------------------

## VM config sync automation
I would make it a habit to run a git pull before syncing the vm configs so that we stay up to date on any changes I make on the documenation before pushing config syncs.

```bash
cd /root/homelab
git pull --rebase
exportncommit
```

If i do need to sync to the main origin after making changes elsewhere and there's no other changes just run
```bash
git fetch origin
git reset --hard origin/main
git clean -fd
```
This will discard local changes and untracked files, mainly incase I just incase I ran a `syncvm` or `syncpve` pre-emptively. 
-----------------------------------------------------------

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

- *note, I tried to do the methods above with my PVE admin, but since its a hardware mod I need `Sys.Modify` minimum added to my pve admin, I just quickly swapped to root to make the change due to simplicity.*

-----------------------------------------------------------

## Changing Display Resolution – Windows IoT VM
- After setting up RDP, I noticed I couldn't change the display resolution in Windows settings on my Windows IoT box.

#### Steps to Enable Dynamic Resolution
1)  ensure  [VirtIO drivers ISO](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.271-1/) is mounted to the VM.
2) Run `virtio-win-guest-tools.exe` from the mounted ISO (this installs QEMU guest agent and VirtIO GPU drivers).
3) In Proxmox, go to:
- Hardware > Display > Edit
- Select VirtIO-GPU as the graphic card
- Set memory to 64–128 MiB
4) Reboot the VM.
5) Resolution should now be changeable in Windows.


-----------------------------------------------------------


## Flox setup 

how I installed and activated a flox environment on my system using a remote environment from FloxHub.

1. Install Flox

Download the `.deb` package for the latest stable release:
`curl -Lo flox.deb https://downloads.flox.dev/by-env/stable/deb/flox-1.5.1.x86_64-linux.deb`

2. Install the package 

`sudo dpkg -i ~/Downloads/flox-1.5.1.x86_64-linux.deb`

3. pull the enviroment 
`flox pull charliettaylor/default`

4. activate the enviroment 

`flox activate`

- or to activate and check for updates

`flox activate -r charliettaylor/default`

5. exit  and close the enviroment enwhen necessary with `exit` then use step 4 when wanting to use again.

