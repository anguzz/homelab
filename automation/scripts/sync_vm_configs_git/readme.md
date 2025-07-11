# sync_vm_configs_git
This script syncs VM configs to github

### GitHub Setup (One-Time)
Note to self: Set up GitHub before building or running automation scripts. 
I added Git later and ran into out-of-sync folders,and conflicting branches,


1. **Generate a GitHub Token:**
   - Go to: https://github.com/settings/tokens
   - Generate a **Classic** or **Fine-grained** token
   - Minimum scope required: `public_repo` (or `repo` for private repos)
   - Copy it, this is your Git password for pushes

2. **Clone your repository locally:**
   ```bash
   git clone https://github.com/anguzz/homelab.git /root/homelab
   cd /root/homelab
   git branch

3. **Authenticate Git CLI (if prompted during push):** 
When pushing for the first time, Git may prompt for credentials. paste your GitHub token when asked for the password


# 1st time setup(before cloning repo)
1) create  path (1st time)

- `mkdir -p /root/homelab/automation/scripts/sync_vm_configs_git`

2) nano in and add script and save
- `nano /root/homelab/automation/scripts/sync_vm_configs_git/sync_vm_configs_git.sh`

3) Make executable
- `chmod +x /root/homelab/automation/scripts/sync_vm_configs_git/sync_vm_configs.sh`

3) Run script
- `/root/homelab/automation/scripts/sync_vm_configs_git/sync_vm_configs_git.sh`

4) Optional: Add alias to run scripts with persistence to export and push to github in one go.
- `echo "alias syncvm='/root/homelab/automation/scripts/sync_vm_configs_git/sync_vm_configs.sh'" >> ~/.bashrc`
- `source ~/.bashrc`


5) Now run `syncvm` for sync on configs.


#### warning: ensure proxmox vm name matches our vms name on github at `/anguzz/homelab/tree/main/vms` otherwise it will create the directory and export it.

### Demo 
When working properly it should look like this. 
![image](https://github.com/user-attachments/assets/f1c196c8-749d-4052-9c0b-cb54127e34f7)



