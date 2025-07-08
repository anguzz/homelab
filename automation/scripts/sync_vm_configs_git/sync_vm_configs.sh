#!/bin/bash

REPO_DIR="/root/homelab"
VMS_DIR="$REPO_DIR/vms"

echo " Exporting and syncing Proxmox VM configs..."

for vmid in $(qm list | awk 'NR>1 {print $1}'); do
    echo " Processing VM ID: $vmid"

    vmname=$(qm config "$vmid" | grep -i '^name:' | awk '{print $2}')
    [ -z "$vmname" ] && echo "  Could not get name for VM ID $vmid. Skipping." && continue

    vm_path="$VMS_DIR/$vmname"
    mkdir -p "$vm_path"

    config_file="$vm_path/config.qm"
    markdown_file="$vm_path/README.md"
    qm config "$vmid" > "$config_file"

    memory=$(grep '^memory:' "$config_file" | awk '{print $2}')
    balloon=$(grep '^balloon:' "$config_file" | awk '{print $2}')
    cpu_type=$(grep '^cpu:' "$config_file" | awk '{print $2}')
    sockets=$(grep '^sockets:' "$config_file" | awk '{print $2}')
    cores=$(grep '^cores:' "$config_file" | awk '{print $2}')
    cpulimit=$(grep '^cpulimit:' "$config_file" | awk '{print $2}')
    cpuunits=$(grep '^cpuunits:' "$config_file" | awk '{print $2}')

    iso=$(grep '^ide2:' "$config_file" | cut -d',' -f1 | cut -d':' -f2)
    bootdisk=$(grep '^bootdisk:' "$config_file" | awk '{print $2}')
    bootorder=$(grep '^boot:' "$config_file" | awk '{print $2}')
    disk=$(grep '^scsi0:' "$config_file" | grep -o 'size=[^,]*' | cut -d= -f2)

    bridge=$(grep '^net0:' "$config_file" | grep -o 'bridge=[^,]*' | cut -d= -f2)
    vlan=$(grep '^net0:' "$config_file" | grep -o 'tag=[^,]*' | cut -d= -f2)
    mac=$(grep '^net0:' "$config_file" | cut -d',' -f1 | cut -d'=' -f2)
    model=$(grep '^net0:' "$config_file" | cut -d'=' -f1 | awk '{print $2}')

    agent=$(grep '^agent:' "$config_file" | awk '{print $2}')
    numa=$(grep '^numa:' "$config_file" | awk '{print $2}')
    ostype=$(grep '^ostype:' "$config_file" | awk '{print $2}')
    onboot=$(grep '^onboot:' "$config_file" | awk '{print $2}')
    protection=$(grep '^protection:' "$config_file" | awk '{print $2}')
    tags=$(grep '^tags:' "$config_file" | awk '{print $2}')
    bios=$(grep '^bios:' "$config_file" | awk '{print $2}')
    machine=$(grep '^machine:' "$config_file" | awk '{print $2}')
    hotplug=$(grep '^hotplug:' "$config_file" | cut -d' ' -f2-)
    hugepages=$(grep '^hugepages:' "$config_file" | awk '{print $2}')
    kvm=$(grep '^kvm:' "$config_file" | awk '{print $2}')

    # usb config
    pci=$(grep '^hostpci' "$config_file" | awk '{print $2}' | paste -sd '; ' -)
    usb=$(grep '^usb' "$config_file" | awk '{print $2}' | paste -sd '; ' -)

    node=$(hostname)

    # readme.md
    cat <<EOF > "$markdown_file"
## VM: $vmname

| Setting               | Value                                   |
|------------------------|-----------------------------------------|
| **VM ID**              | $vmid                                  |
| **Name**               | $vmname                                |
| **OS Type**            | ${ostype:-N/A}                         |
| **Node**               | $node                                  |
| **Onboot**             | ${onboot:-no}                          |
| **Tags**               | ${tags:-none}                          |
| **Protection**         | ${protection:-no}                      |
| **Memory**             | ${memory:-N/A} MB                      |
| **Ballooning**         | ${balloon:-N/A} MB                     |
| **Sockets**            | ${sockets:-1}                          |
| **Cores**              | ${cores:-1}                            |
| **CPU Type**           | ${cpu_type:-default}                   |
| **CPU Limit**          | ${cpulimit:-unlimited}                 |
| **CPU Units**          | ${cpuunits:-1024}                      |
| **NUMA**               | ${numa:-disabled}                      |
| **KVM Enabled**        | ${kvm:-yes}                            |
| **Hotplug**            | ${hotplug:-disk,network,usb}          |
| **Hugepages**          | ${hugepages:-none}                     |
| **BIOS**               | ${bios:-seabios}                       |
| **Machine Type**       | ${machine:-i440fx}                     |
| **Boot Device**        | ${bootdisk:-N/A}                       |
| **Boot Order**         | ${bootorder:-N/A}                      |
| **Disk Size**          | ${disk:-N/A}                           |
| **ISO Attached**       | ${iso:-none}                           |
| **Network Bridge**     | ${bridge:-vmbr0}                       |
| **MAC Address**        | ${mac:-N/A}                            |
| **NIC Model**          | ${model:-virtio}                       |
| **VLAN Tag**           | ${vlan:-none}                          |
| **QEMU Guest Agent**   | ${agent:-disabled}                     |
| **PCI Passthrough**    | ${pci:-none}                           |
| **USB Devices**        | ${usb:-none}                           |
EOF

    echo " Synced: $vmname → config.qm + README.md"
done

echo " Committing to GitHub..."

cd "$REPO_DIR"
git add .
git commit -m "Sync: Exported all VM configs and metadata on $(date)" || echo "No changes to commit."
git push

echo " Git sync complete."
