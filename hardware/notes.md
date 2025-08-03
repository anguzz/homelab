#  Hardware

---

##  **Primary Proxmox Host**

- **Model:** [ThinkCentre Neo 50q Gen 4 Tiny (Intel)](https://www.lenovo.com/us/en/p/desktops/thinkcentre/thinkcentre-neo-series/thinkcentre-neo-50q-gen-4-tiny-intel/len102c0033)
- **CPU:** 13th Gen Intel Core i5-13420H (4P + 4E Cores, up to 4.6GHz)
- **RAM:** 32GB DDR4-3200MT/s (SODIMM) *(originally 16GB, added another stick)*
- **Primary Storage (NVMe):** Samsung 970 PRO 512GB NVMe M.2  
  - Model: `MZ-V7P512`  
  - Interface: PCIe Gen3 x4 NVMe  
  - NAND: V-NAND MLC  
  - Rated Power: DC 3.3V ⎓ 2.9A
- **Hypervisor:** Proxmox VE 8.4.0
- **Host FQDN:** `pve.angs.dev`
- **IP Address:** `192.168.1.10/24`
- **Gateway:** `192.168.1.254`
- **Bridge:** `vmbr0`
- **DNS:** `1.1.1.1`
- **Power Consumption:** ~65W max (Idle ~10–15W)

---

##  **Proxmox Node 2**
- **Model:** Dell OptiPlex 3050
- **Status:** Needs setup, need larger drive & RAM 

---

##  **Firewall**
- **Model:** SonicWall TZ400
- **Status:** Currently testing setup

---

##  **UPS**
- **Model:** CyberPower 1000VA AVR
- **Status:** In use

---

##  **Wireless Access Point**
- **Model:** Ubiquiti UniFi AP AC LR
- **Status:** Needs setup & testing

