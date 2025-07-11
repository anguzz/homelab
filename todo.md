# Homelab To-Do List
Just some stuff I want to do and have been thinking about.


### Proxmox configuration
- [ ] Configure daily snapshot jobs or PBS (Proxmox Backup Server) once I procure NAS
- [ ] Export a backup to cold storage 
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
- [ ] procure/purchase storage to be used as NAS (maybe [Seagate Iron wolf](https://www.amazon.com/Seagate-IronWolf-Internal-Hard-Drive/dp/B09NHV3CK9?crid=2PHIQEP2OC6AD&dib=eyJ2IjoiMSJ9.oAqMhjaWQ2Ix7G5kzr9PCfd9w-zV-cDDPVJ5kPV4llipxSU54XbOUn9INYg_VDSfBn8JUGjwncGX81zvladRnhigb0CQEOMz619D7q-wT-QsMbwoh3TM_iJ04hjhgB6-UXSKpxg926hdhcbeb-aT-9vQe-8idlze_J7jlRTVvMNsebDXA_cdAwfkj6wsecWXtBBnyx6XGCrqDS1gkmir__oNW3kKkUSTY2iy9tJmHCg.L5uFm6KlC78g0lNbJ8o27xUoh3eBCgRQzrptctfRGnw&dib_tag=se&keywords=seagate%2Bironwolf&qid=1751849651&sprefix=%2Caps%2C482&sr=8-1&ufe=app_do%3Aamzn1.fos.9fe8cbfa-bf43-43d1-a707-3f4e65a4b666&th=1) or  [WD red plus ](https://www.amazon.com/Red-4TB-NAS-Hard-Drive/dp/B00EHBERSE) 4-10tbs
- [ ] research jellyfin vm setup

###  EDR Testing lab  
- [ ] setup win10 IoT, CPU: 2–4 cores, RAM: 4–8 GB, Disk: 40+ GB
- [ ] Snapshot clean state before testing
- [ ] Research EDR to install (possibly older versions of CrowdStrike, SentinelOne, Defender, Sophos)
- [ ] Setup Procmon & Sysinternals
- [ ] Try bypass: direct syscall, manual stubs, remap `ntdll.dll`
- [ ] Continue to read up on EDR internals, evasion methods
- [ ] Write summary of EDR behavior/version

### OpenVAS Dedicated Scanner VM
- [ ] setup Debian 12vm, 2-4 cores, 4-8gbs, 40+ gbs disk
- [ ] install OpenVAS, run a scan.


### Automation
- [x] merge  `export_vm_configs` and `sync_vm_configs_git` into one script
- [x] expand config export to include more fields

