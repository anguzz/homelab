## VM: win10-ltsc-jumpbox

| Setting          | Value                            |
|------------------|----------------------------------|
| **VM ID**        | 104                            |
| **Name**         | win10-ltsc-jumpbox                          |
| **OS Type**      | win11                          |
| **ISO Image**    |  local                             |
| **Boot Order**   | CD-ROM (IDE2), Disk (SCSI0)      |
| **Disk**         | 30G (SCSI, local-lvm)          |
| **SCSI Controller** | VirtIO SCSI single            |
| **Memory**       | 4096 MB                     |
| **CPU**          | 1 socket(s), 2 core(s) (x86-64-v2-AES) |
| **NUMA**         | 0                            |
| **Network**      | VirtIO, bridge=vmbr0           |
| **QEMU Agent**   | Enabled (agent=1)           |
| **Node**         | pve                            |
