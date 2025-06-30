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

