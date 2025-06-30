# Home Lab 
Home lab documentation repository. This repo tracks the setup, configuration, and automation of my home infrastructure, including hardware, virtual machines, networking, automations, and general notes and future directions I'd like to take it.



## Repo Structure

```bash
homelab/
├── README.md                    # Project overview
├── Notes/                       # Brain dump 
├── proxmox/                     # Proxmox system config 
│   ├── README.md
├── vms/                         # vm-configurations
│   ├── <vm-name>/               # Each VM has its own folder (e.g., angusMintDev, k8s-master, etc.)
├── network/                     # Network configs
│   ├── README.md
├── automation/                  # Scripts and IaC
│   ├── README.md
│   ├── tools/                   # tools like terrform, ansible, etc
│   └── scripts/
```


##  Next steps / TODO

- Explore other options proxmox has to integare with github for this repo.
- Make vms/ folder dynamically managed, explore stuff like `qm list`, `qm config`, or `proxmox-backup-client` to auto-generate per-VM config folders
- Set up kubeadm on `k8s-master`
- Configure daily snapshot jobs or PBS (Proxmox Backup Server)
- Harden SSH and set up 2FA for Proxmox
- Explore exposing Proxmox via pve.angs.dev securely through cloudflare tunels or similar (long term)
- See if I can passthrough a physical wireless NIC to angusMintDev to use for [Wi-Fi probe/sniffing](https://github.com/anguzz/wifi-pnl-probing)
- Configure flox and pull [charliettaylor](https://hub.flox.dev/charliettaylor/default) flox config from floxhub on angusMintDev

