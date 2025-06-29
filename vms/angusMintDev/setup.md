## VM: angustMintDev

| Setting             | Value                                               |
| ------------------- | --------------------------------------------------- |
| **VM ID**           | 101                                                 |
| **Name**            | angus-mint-dev                                      |
| **Guest OS**        | Linux (Mint 22 Cinnamon)                            |
| **Kernel Version**  | 6.x - 2.6 Kernel                                     |
| **ISO Image**       | `linuxmint-22-cinnamon-64bit.iso`                   |
| **Boot Order**      | CD-ROM (IDE2), Disk (SCSI0)                         |
| **Disk**            | 30GB (SCSI, local-lvm, IOThread enabled)           |
| **SCSI Controller** | VirtIO SCSI single                                  |
| **Memory**          | 4096 MB (4 GB)                                      |
| **CPU**             | 1 socket, 2 cores (`x86-64-v2-AES`)                 |
| **NUMA**            | Disabled                                            |
| **Network**         | VirtIO (paravirtualized), bridge: `vmbr0`          |
| **Firewall**        | Enabled                                             |
| **QEMU Agent**      | Enabled (`agent=1`)                                 |
| **BIOS**            | Default (SeaBIOS)                                   |