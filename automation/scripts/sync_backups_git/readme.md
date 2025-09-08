
# sync\_backups\_git

This script exports **Proxmox backup job configs** to GitHub, saving them as:

* `proxmox/backup_jobs.json` (latest snapshot)
* `proxmox/backup_jobs_history.json` (historical log of all exports)

---

## Setup

1. **Make executable**

```bash
chmod +x /root/homelab/automation/scripts/sync_backups_git/sync_backups_git.sh
```

2. **Add alias** for quick runs

```bash
echo "alias syncbackups='/root/homelab/automation/scripts/sync_backups_git/sync_backups_git.sh'" >> ~/.bashrc
source ~/.bashrc
```

Now you can run:

```bash
syncbackups
```

3. **Optionally run manually**

```bash
/root/homelab/automation/scripts/sync_backups_git/sync_backups_git.sh
```

