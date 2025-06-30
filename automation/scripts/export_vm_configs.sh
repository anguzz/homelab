#!/bin/bash

CONFIG_DIR="/root/homelab/vms"

echo "Starting export of Proxmox VM configs..."

for vmid in $(qm list | awk 'NR>1 {print $1}'); do
    echo "Processing VM ID: $vmid"
    
    vmname=$(qm config "$vmid" | grep -i '^name:' | awk '{print $2}')
    
    if [ -z "$vmname" ]; then
        echo "Warning: Could not get VM name for ID $vmid. Skipping."
        continue
    fi

    export_path="$CONFIG_DIR/$vmname"
    mkdir -p "$export_path"

    echo "Exporting to: $export_path/config.qm"
    qm config "$vmid" > "$export_path/config.qm"
done

echo "Done exporting all VM configs."
