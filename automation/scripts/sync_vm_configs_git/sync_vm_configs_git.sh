#!/bin/bash

REPO_DIR="/root/homelab"
VMS_DIR="$REPO_DIR/vms"

echo " Syncing Proxmox VM configs to GitHub..."

for vmid in $(qm list | awk 'NR>1 {print $1}'); do
    vmname=$(qm config "$vmid" | grep -i '^name:' | awk '{print $2}')
    vm_path="$VMS_DIR/$vmname"

    # check folder exist
    mkdir -p "$vm_path"

    # exports current configs
    config_file="$vm_path/config.qm"
    qm config "$vmid" > "$config_file"

    # generate markdown 
    markdown_file="$vm_path/README.md"
    memory=$(grep '^memory:' "$config_file" | awk '{print $2}')
    cpu=$(grep '^cpu:' "$config_file" | awk '{print $2}')
    sockets=$(grep '^sockets:' "$config_file" | awk '{print $2}')
    cores=$(grep '^cores:' "$config_file" | awk '{print $2}')
    iso=$(grep '^ide2:' "$config_file" | cut -d',' -f1 | cut -d':' -f2)
    disk=$(grep '^scsi0:' "$config_file" | grep -o 'size=[^,]*' | cut -d= -f2)
    bridge=$(grep '^net0:' "$config_file" | grep -o 'bridge=[^,]*' | cut -d= -f2)
    agent=$(grep '^agent:' "$config_file" | awk '{print $2}')
    numa=$(grep '^numa:' "$config_file" | awk '{print $2}')
    ostype=$(grep '^ostype:' "$config_file" | awk '{print $2}')
    node=$(hostname)

    cat <<EOF > "$markdown_file"
## VM: $vmname

| Setting          | Value                            |
|------------------|----------------------------------|
| **VM ID**        | $vmid                            |
| **Name**         | $vmname                          |
| **OS Type**      | $ostype                          |
| **ISO Image**    | $iso                             |
| **Boot Order**   | CD-ROM (IDE2), Disk (SCSI0)      |
| **Disk**         | $disk (SCSI, local-lvm)          |
| **SCSI Controller** | VirtIO SCSI single            |
| **Memory**       | ${memory} MB                     |
| **CPU**          | $sockets socket(s), $cores core(s) ($cpu) |
| **NUMA**         | $numa                            |
| **Network**      | VirtIO, bridge=$bridge           |
| **QEMU Agent**   | Enabled (agent=$agent)           |
| **Node**         | $node                            |
EOF

    echo " Synced: $vmname → config.qm + README.md"
done

echo " Committing to GitHub..."

cd "$REPO_DIR"
git add .
git commit -m "Sync: Exported all VM configs and README.md files on $(date)" || echo " No changes to commit."
git push

echo " Git sync complete"
