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
- [x] Apply GPO / registry tweaks to disable telemetry (used `automation\scripts\windows\disableTelemetry.ps1`)
- [x] Strip remaining unnecessary services via `services.msc`
- [ ] Schedule snapshot rotation or backups
- [ ] Create backup image or template for quick redeployment 


###  Dev & Software lab
- [x] See if I can passthrough a physical wireless NIC to angusMintDev to use for [Wi-Fi probe/sniffing](https://github.com/anguzz/wifi-pnl-probing) (7/2/25)
- [x] Configure flox and pull [charliettaylor](https://hub.flox.dev/charliettaylor/default) flox config from floxhub on angusMintDev
- [ ] Continue next steps on mint_setup.sh including bookmark setup, theme setup, panel + desktop adding apps


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


### config export automations 
- [x] merge  `export_vm_configs` and `sync_vm_configs_git` into one script
- [x] expand config export to include more fields

### Infrastructure-as-Code Kubernetes Lab Setup (via automation-vm)
- [x] Set up `automation-vm` (Ubuntu 24.04, 2 cores, 4GB RAM, 32GB disk)
- [x] Install Terraform, Ansible, Git, and SSH keys on `automation-vm`

####  Prepare Cloud-Init Templates for Proxmox (One-time setup)
- [ ] Choose an image (prob `ubuntu-22.04-server-cloudimg-amd64.img`)
- [ ] Create a new VM in Proxmox using this cloud image
  - Set disk bus to `VirtIO`
  - Add a second CD-ROM drive of type `cloud-init`
  - Enable QEMU Guest Agent
- [ ] Boot the VM and install:
  - `cloud-init`
  - `qemu-guest-agent`
- [ ] Shutdown and convert the VM into a **template**
- [ ] Note the name (e.g., `ubuntu-cloud-template`) for Terraform use
- [ ] Repeat this process to create a `mint-dev-template` for dev tools

####  VM Provisioning and Cluster Setup via Terraform + Ansible
- [ ] Create Terraform config (`main.tf`) to provision `k8s-master`, `k8s-node-1`, and `k8s-node-2` using Proxmox API and clone the cloud-init template
- [ ] Inject SSH keys via cloud-init and assign static IPs to each VM
- [ ] Build Ansible inventory and playbook to install container runtime, kubeadm, and kubelet
- [ ] Use `kubeadm init` on `k8s-master` and capture join token
- [ ] Use `kubeadm join` on workers via Ansible
- [ ] Validate cluster with `kubectl get nodes`
- [ ] Optional: Add Kubernetes dashboard and more features


### Rack + Network Hardware
- [ ] Rack homelab gear  
    - Mount **Tecmojo 6U Network Rack, 10 inch Mini Server Rack with 2 Side Translucent Panels & 2 Top Handles, 7.87 inch Deep, White**  
    - Install/secure Proxmox nodes + accessories  
    - Cable manage power + networking  

- [ ] Setup Netdata Cloud for Proxmox monitoring  
    - Install Netdata on each Proxmox node: `apt update && apt install netdata -y`  
    - Create account at https://app.netdata.cloud  
    - Run claim command from Netdata Cloud on each node  
    - Open app.netdata.cloud on Samsung tablet for live homelab dashboard  

- [ ] Setup network hardware  
    - Configure **Palo Alto PA-220 firewall** for lab subnet  
    - Deploy **Netgear GS108PE 8-port Gigabit Smart Managed Plus switch**  
    - Connect firewall, switch, and Proxmox nodes to rack layout
