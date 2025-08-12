# Mint setup

Mint setup meant for vms and also workstations


# Run command
- vm
`ansible-playbook -i inventory.ini --limit vms playbook.yml`


- workstation
- `sudo apt update && sudo apt install ansible git -y`
- `git clone https://github.com/anguzz/homelab`
- `cd ansible-mint-setup`
`ansible-playbook -i inventory.ini --limit local playbook.yml --ask-become-pass`
