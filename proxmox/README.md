
## Proxmox 
This directory documents the Proxmox system configuration, VM allocations, user permissions, and related infrastructure details.

### Hardware 

- **PVE1:** [ThinkCentre Neo 50q Gen 4 Tiny (Intel)](https://www.lenovo.com/us/en/p/desktops/thinkcentre/thinkcentre-neo-series/thinkcentre-neo-50q-gen-4-tiny-intel/len102c0033)
- **CPU**: 13th Generation Intel Core i5-13420H Processor (4 Performance + 4 Efficiency Cores, up to 4.6GHz)
- **RAM**: 32GBs DDR4-3200MT/s (SODIMM) *(originally 16gbs but added another stick)*
- **Primary Storage (NVMe):** Samsung 970 PRO 512GB NVMe M.2  
  - Model: `MZ-V7P512`  
  - Interface: PCIe Gen3 x4 NVMe  
  - NAND: V-NAND MLC  
  - Rated Power: DC 3.3V ⎓ 2.9A-
- **Hypervisor:** Proxmox VE 8.4.0
- **Host FQDN:** pve.angs.dev
- **IP Address:** 192.168.1.10/24
- **Gateway:** 192.168.1.254
- **Bridge:** vmbr0
- **DNS:** 1.1.1.1
- **Power consumption**: ~65W max (typical idle ~10–15W) 

---

### **PVE2 – Dell Optiplex Micro 7010**
- **CPU**: 13th Gen Intel Core i5-13500T (20 threads, base 3.4 GHz, efficiency + performance hybrid architecture)
- **RAM**: 16 GB DDR4-3200 MT/s SO-DIMM (1 × 16 GB; 1 slot free, max 64 GB supported)
- **Primary Storage**: 
  - Model:  Micron 2450 NVMe 256 GB M.2 SSD
  - Interface: PCIe Gen3 x4 NVMe
  - Rated Capacity: 256 GB (usable ~238.5 GB)
- **Hypervisor:** Proxmox VE 8.x
- **Host FQDN:** `pve2.angs.dev`
- **IP Address:** 192.168.1.13/24
- **Gateway:** 192.168.1.254
- **Bridge:** vmbr0
- **DNS:** 1.1.1.1, 8.8.8.8
- **Power consumption**: ~50–55 W under full load, ~12 W idle
---

### **PVE3 – Dell Optiplex Micro 3070**
- **CPU**: Intel Core i5-7500T (4 cores / 4 threads, base 2.7 GHz, turbo up to 3.3 GHz, 35 W TDP)
- **RAM**: 16 GB DDR4-2400 MT/s SO-DIMM (2 × 8 GB, Hynix HMA81GS6AFR8N-UH, 1.2 V, dual-channel)
- **Primary Storage**: 
 - SATA SSD: Micron 1100 SATA 256 GB (usable ~238.5 GB)
 - NVMe SSD: SK Hynix HFS256GEJ4X113N 256 GB (PCIe Gen3 x4 NVMe, usable ~238.5 GB)
- **Hypervisor:** Proxmox VE 8.x
- **Host FQDN:** `pve3.angs.dev`
- **IP Address:** 192.168.1.12/24
- **Gateway:** 192.168.1.254
- **Bridge:** vmbr0
- **DNS:** 1.1.1.1, 8.8.8.8
- **Power consumption**:  ~40–45 W under full load, ~10–15 W when idle

---

### **PBS – Dell Optiplex Micro 3070**
- **CPU**: Intel Core i5-7500T (4 cores / 4 threads, base 2.7 GHz, turbo up to 3.3 GHz, 35 W TDP)
- **RAM**: 8 GB DDR4-2667 MT/s SO-DIMM (configured at 2400 MT/s; 1 slot populated, 1 free; max 32 GB supported)
- **Primary Storage**: VisionTek DLX4 1 TB NVMe SSD
    - Model: Visiontek 1TB DLX4
    - Interface: PCIe Gen3 x4 NVMe
    - Usable Capacity: ~931.5 GB
- **Service Role:** Proxmox Backup Server  
- **Host FQDN:** `pbs.angs.dev`
- **IP Address:** 192.168.1.11/24
- **Gateway:** 192.168.1.254
- **Bridge:** vmbr0
- **DNS:** 1.1.1.1, 8.8.8.8
- **Note:** Previously used as PVE2, repurposed to PBS
- **Power consumption**:  ~40–45 W under full load, ~10–15 W idle

---

### **Raspberry Pi Display Node**
- **Model:** Raspberry Pi *(fill in exact model)*
- **Host FQDN:** `angus-pi`
- **IP Address:** 192.168.1.125 (DHCP)
- **Gateway:** 192.168.1.254
- **DNS:** 1.1.1.1, 8.8.8.8
- - **Power consumption**: ~3–6 W under normal load  (board + LCD)


### **Networking**
- **Switch:** Netgear GS108PEv3 (8-Port Gigabit, 4 × PoE)  
  - **Base Power Draw:** ~3–5 W (no PoE load)  
  - **PoE Budget:** 53 W total (up to 15.4 W per PoE port, 4 ports)  
  - **Max Draw:** ~58 W (switch + full PoE load)  
  - **Notes:** Currently used for homelab interconnect; actual draw closer to base unless PoE devices are attached.


- **Firewall – Palo Alto PA-220** (Not online currently)
  - **Model:** Palo Alto Networks PA-220
  - **Throughput:** ~500 Mbps firewall / ~150–200 Mbps threat prevention / ~100 Mbps IPSec VPN
  - **Concurrent Sessions:** up to 64,000
  - **Power Supply:** External 12 V DC adapter
  - **Power Consumption:** ~12–15 W idle, ~18–20 W typical, up to ~25 W max
  - **Notes:** Fanless, silent, branch-office NGFW appliance

---

### **CyberPower UPS**

- **Model:** CyberPower 1000VA AVR (CP1000AVRLCD or equivalent)

- **Capacity:** 1000VA / 600W

- **Efficienty:** ~90–95% (adds ~5–10 W overhead to total load)

- **Lab load:** ~110–130 W (PVE nodes + networking + Pi)

- **Battery runtime:** ~20–25 minutes at 100 W load (less at higher draw)

- **Notes:** Provides surge protection, AVR (automatic voltage regulation), and ~5–10 W self-consumption.

---
