# Homelab To-Do List
Just some stuff I want to do and have been thinking about.


## IoT Enterprise LTSC Jump Box Tasks

### System Hardening & Optimization
- [x] Setup Google Chrome RDP
- [x] Enable Dynamic Resolution
- [ ] Configure Tailscale
- [ ] Apply GPO / registry tweaks to disable telemetry
- [ ] Strip remaining unnecessary services via `services.msc`
- [ ] Schedule snapshot rotation or backups
- [ ] Set up monitoring or restart watchdog for Parsec
- [ ] Create backup image or template for quick redeployment

## Next Steps / General Homelab TODO

### Proxmox & Virtualization
- [ ] Explore other options Proxmox has to integrate with GitHub for this repo.
- [ ] Make `vms/` folder dynamically managed, explore stuff like `qm list`, `qm config`, or `proxmox-backup-client` to auto-generate per-VM config folders
- [ ] Configure daily snapshot jobs or PBS (Proxmox Backup Server)
- [ ] Harden SSH and set up 2FA for Proxmox
- [ ] Explore exposing Proxmox via pve.angs.dev securely through Cloudflare Tunnels (long term)

### Kubernetes
- [ ] Set up kubeadm on `k8s-master`
- [ ] Prepare Kubernetes Worker Nodes for Testing
- [ ] Look into container runtimes (like Containerd??)
- [ ] Join worker nodes to the `k8s-master` using `kubeadm join`

###  Dev & Software
- [x] See if I can passthrough a physical wireless NIC to angusMintDev to use for [Wi-Fi probe/sniffing](https://github.com/anguzz/wifi-pnl-probing) (7/2/25)
- [ ] Configure flox and pull [charliettaylor](https://hub.flox.dev/charliettaylor/default) flox config from floxhub on angusMintDev

### Media server VM
- [ ] procure/purchase a NAS  
- [ ] research jellyfin vm setup


