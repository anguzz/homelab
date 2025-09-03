# Homelab Network Overview

This directory documents the layout, addressing, and security of my homelab network.

## IP Scheme

### Proxmox Hosts
- **PVE1 (Lenovo ThinkCentre Neo 50q Gen 4 Tiny)**
  - Hostname: `pve.angs.dev`
  - IP: `192.168.1.10/24`
  - Gateway: `192.168.1.254` (AT&T Router)
  - DNS: `1.1.1.1`, `8.8.8.8`

- **PVE2 (Dell Optiplex Micro 7010)** 
  - Hostname: `pve2.angs.dev`
  - IP: `192.168.1.13/24`
  - Gateway: `192.168.1.254` (AT&T Router)
  - DNS: `1.1.1.1`, `8.8.8.8`

- **PVE3 (Dell Optiplex Micro 3070)**
  - Hostname: `pve3.angs.dev`
  - IP: `192.168.1.12/24`
  - Gateway: `192.168.1.254` (AT&T Router)
  - DNS: `1.1.1.1`, `8.8.8.8`

- **PBS (Dell Optiplex Micro 3070)**
  - Hostname: `pbs.angs.dev`
  - IP: `192.168.1.11/24`
  - Gateway: `192.168.1.254` (AT&T Router)
  - DNS: `1.1.1.1`, `8.8.8.8` 
  - previously PVE2 but repurposed to PBS


- **Raspberry PI display**
  - Hostname: `angus-pi`
  - IP: `192.168.1.125` *(DHCP)*
  - Gateway: `192.168.1.254` (AT&T Router)
  - DNS: `1.1.1.1`, `8.8.8.8`


## Switching

- **Netgear GS108PE (8-port Smart Managed Plus)**
  - Currently provides switching between Proxmox nodes and AT&T router
  - Ports:
    - Port 1: AT&T Router uplink
    - Port 2: PVE1 (Lenovo)
    - Port 3: PVE2 (Dell)
    - Port 4: PVE3 (Dell)
    - Remaining ports: spare for lab devices / future expansion
  - Supports VLANs (planned future use once Palo Alto PA-220 is deployed)

## Network Bridge (Proxmox)

- **vmbr0**: Primary bridge tied to the physical NIC  
- Provides LAN access to all VMs and containers  


