## VM: k8s-node-1
| Setting          | Value                                                  |
|------------------|--------------------------------------------------------|
| **VM ID**        | 100                                                    |
| **Name**         | k8s-master                                             |
| **OS Type**      | Linux (l26)                                            |
| **ISO Image**    | ubuntu-24.04.2-live-server-amd64.iso                  |
| **Boot Order**   | CD-ROM (IDE2), Disk (SCSI0)                            |
| **Disk**         | 20GB (SCSI, local-lvm, IOThread=on)                    |
| **SCSI Controller** | VirtIO SCSI single                                  |
| **Memory**       | 2048 MB                                                |
| **CPU**          | 1 socket, 2 cores (x86-64-v2-AES)                      |
| **NUMA**         | Disabled (0)                                           |
| **Network**      | VirtIO, bridge=vmbr0, firewall=enabled (net0)         |
| **QEMU Agent**   | Enabled (agent=1)                                      |
| **Node**         | pve                                                    |