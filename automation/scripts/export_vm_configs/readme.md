
## export_vm_configs.sh 
Exports current vm configs to `/root/homelab/vms/<vm-name>`


## Steps 
1)  1st Create a path on proxmox host where script will live

`mkdir -p /root/homelab/automation/scripts/export_vm_configs.sh`

- This creates
```bash
/root/
  └── homelab/
        └── automation/
              └── scripts/
```
2) Nano add the script
`nano /root/homelab/automation/scripts/export_vm_configs.sh`

3) Make executable
`chmod +x /root/homelab/automation/scripts/export_vm_configs.sh`

4) execute script
`root@pve:~# /root/homelab/automation/scripts/export_vm_configs.sh`
```bash
Starting export of Proxmox VM configs...
Processing VM ID: 100
Exporting to: /root/homelab/vms/k8s-master/config.qm
Processing VM ID: 101
Exporting to: /root/homelab/vms/angusMintDev/config.qm
Processing VM ID: 102
Exporting to: /root/homelab/vms/k8s-node1/config.qm
Processing VM ID: 103
Exporting to: /root/homelab/vms/k8s-node2/config.qm
Done exporting all VM configs.
root@pve:~#
```

- Run `ls /root/homelab/vms/` to see folders
- Cat to view `cat /root/homelab/vms/angusMintDev/config.qm`
