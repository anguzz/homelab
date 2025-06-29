# Homelab Network Overview

This directory documents the layout, addressing, and security of my homelab's network.

## IP Scheme

- **Subnet:** 192.168.1.0/24
- **Gateway:** 192.168.1.254 (AT&T Router)
- **DNS:** 1.1.1.1 / 8.8.8.8

## Network Bridge (Proxmox)

- **vmbr0**: Main bridge tied to physical NIC
- Used by all VMs for LAN access

## Planned Segmentation

Test creation of separate VLANs for seperate resources?
  - Management (Proxmox UI, SSH)
  - Lab VMs (Kubernetes, test VMs)


## current VM IP Assignments

| VM Name         | IP Address     | Interface | Notes                      |
|----------------|----------------|-----------|----------------------------|
| pve.angs.dev    | 192.168.1.10   | vmbr0     | Proxmox host               |
| k8s-master      | 192.168.1.100  | ens18     | Static IP, manual setup    |
| k8s-node-1      | 192.168.1.101  | ens18     | Static IP, manual setup    |
| mint-desktop    | DHCP           | ens18     | Dynamically assigned       |