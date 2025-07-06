# Homelab To-Do List
Just some stuff I want to do and have been thinking about.


### Proxmox configuration
- [ ] Configure daily snapshot jobs or PBS (Proxmox Backup Server) 
- [ ] Explore other options Proxmox has to integrate with GitHub for this repo.
- [ ] Make `vms/` folder dynamically managed, explore stuff like `qm list`, `qm config`, or `proxmox-backup-client` to auto-generate per-VM config folders
- [ ] Harden SSH and set up 2FA for Proxmox
- [ ] Explore exposing Proxmox via pve.angs.dev securely through Cloudflare Tunnels or similar (long term)

### IoT LTSC Jump Box 
- [x] Setup Google Chrome RDP
- [x] Enable Dynamic Resolution
- [ ] Configure Tailscale
- [ ] Apply GPO / registry tweaks to disable telemetry
- [ ] Strip remaining unnecessary services via `services.msc`
- [ ] Schedule snapshot rotation or backups
- [ ] Set up monitoring or restart watchdog for Parsec
- [ ] Create backup image or template for quick redeployment

### Kubernetes lab 
- [ ] Set up kubeadm on `k8s-master`
- [ ] Prepare Kubernetes Worker Nodes for Testing
- [ ] Look into container runtimes (like Containerd??)
- [ ] Join worker nodes to the `k8s-master` using `kubeadm join`

###  Dev & Software lab
- [x] See if I can passthrough a physical wireless NIC to angusMintDev to use for [Wi-Fi probe/sniffing](https://github.com/anguzz/wifi-pnl-probing) (7/2/25)
- [ ] Configure flox and pull [charliettaylor](https://hub.flox.dev/charliettaylor/default) flox config from floxhub on angusMintDev

### Media server setup
- [ ] procure/purchase a NAS  
- [ ] research jellyfin vm setup

###  EDR Testing lab  
- [ ] setup win10 IoT, CPU: 2–4 cores, RAM: 4–8 GB, Disk: 40+ GB
- [ ] Snapshot clean state before testing
- [ ] Research EDR to install (possibly older versions of CrowdStrike, SentinelOne, Defender, Sophos)
- [ ] Setup Procmon & Sysinternals
- [ ] Try bypass: direct syscall, manual stubs, remap `ntdll.dll`
- [ ] Continue to read up on EDR internals, evasion methods
- [ ] Write summary of EDR behavior/version

### Automation
- [ ] merge  `export_vm_configs` and `sync_vm_configs_git` into one script
- [ ] expand config export to include more fields

