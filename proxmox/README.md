
## Proxmox 
This directory documents the Proxmox system configuration, VM allocations, user permissions, and related infrastructure details.

### Hardware 
I'd like to expand or add more Proxmox nodes in the future. 

- **Host:** ThinkCentre Neo 50q Gen 4 Tiny (Intel)
- **Hypervisor:** Proxmox VE 8.4.0
- **Host FQDN:** pve.angs.dev
- **IP Address:** 192.168.1.10/24
- **Gateway:** 192.168.1.254
- **Bridge:** vmbr0
- **DNS:** 1.1.1.1

### `angusMintDev` (Linux Mint Cinnamon)
- Purpose: GUI desktop for testing and dev
- OS: Linux Mint 22 Cinnamon
- CPU: 2 cores
- RAM: 4 GB
- Disk: 30 GB
- Notes: QEMU agent enabled, Mint Cinnamon installed from ISO

### `k8s-master` (Ubuntu Server)
- Purpose: Kubernetes master node
- OS: Ubuntu Server 24.04.2
- CPU: 2 cores
- RAM: 2 GB
- Disk: 20 GB
- Notes: QEMU agent enabled, static IP config, OpenSSH installed

### `k8s-node-1` (Ubuntu Server)
- Purpose: Kubernetes worker node used alongside k8s-master for deployment and cluster practice
- OS: Ubuntu Server 24.04.2
- CPU: 2 cores
- RAM: 2 GB
- Disk: 20 GB
- Notes: QEMU agent enabled, static IP config, OpenSSH installed

---

##  Proxmox Setup

- Local storage: `local-lvm` for disk images, `local` for ISO templates
- Bridge: `vmbr0` connected to home LAN
- Permissions:
  - `angus@pam` has PVEAdmin role
  - `root@pam` reserved for emergency/system access
- ISOs uploaded to `/var/lib/vz/template/iso/`
