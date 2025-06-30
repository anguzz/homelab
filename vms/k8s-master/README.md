## VM: k8s-master

| Setting          | Value                            |
|------------------|----------------------------------|
| **VM ID**        | 100                            |
| **Name**         | k8s-master                          |
| **OS Type**      | l26                          |
| **ISO Image**    |  local                             |
| **Boot Order**   | CD-ROM (IDE2), Disk (SCSI0)      |
| **Disk**         | 20G (SCSI, local-lvm)          |
| **SCSI Controller** | VirtIO SCSI single            |
| **Memory**       | 2048 MB                     |
| **CPU**          | 1 socket(s), 2 core(s) (x86-64-v2-AES) |
| **NUMA**         | 0                            |
| **Network**      | VirtIO, bridge=vmbr0           |
| **QEMU Agent**   | Enabled (agent=1)           |
| **Node**         | pve                            |
