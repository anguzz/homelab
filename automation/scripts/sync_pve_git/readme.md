# sync_vm_configs_git 
This script syncs pve configs to github to `proxmox/pveperf.md` and `proxmox/pveperf_history.md`

1) Make executable
- `chmod +x /root/homelab/automation/scripts/sync_pve_git/sync_pve_git.sh`



2) Add alias to run scripts with persistence to export and push to github in one go.
- `echo "alias syncpve='/root/homelab/automation/scripts/sync_pve_git/sync_pve_git.sh'" >> ~/.bashrc`
- `source ~/.bashrc`
- now I can run `syncpve` 

3) Optionally run manually 
- `/root/homelab/automation/scripts/sync_pve_git/sync_pve_git.sh`