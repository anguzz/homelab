#  Homelab + SonicWall Cutover Setup (Work in Progress)

##  Physical Network Topology

```
[Ethernet Wall Drop]
        │
   [2-Port Unmanaged Switch]
      ├── [Desktop PC]
      └── [SonicWall TZ Firewall (X1 = WAN)]

[SonicWall TZ Firewall]
   - X1: Connected to 2-port switch (for WAN via home network)
   - X0: LAN subnet (192.168.168.0/24)
      ├── [Proxmox Host → vmbr0 via DHCP]
      └── [Desktop (Direct for Firewall Admin)]
```

---

##  Devices and Current Status

###  Desktop
- Connected to home LAN via switch
- Also connected to **SonicWall LAN port (X0)** via second Ethernet
- Can access SonicWall at `https://192.168.168.168`

###  Proxmox Host
- Connected to SonicWall X0 port
- Received IP via:
  ```bash
  dhclient vmbr0
  ```
- Got: `192.168.168.105/24` 

BUT:
-  No internet (can't ping 8.8.8.8)
-  No inbound access (can't access Proxmox UI from desktop)

---

##  What’s Working
- SonicWall DHCP (X0 LAN) is assigning IPs.
- Firewall web UI accessible directly via LAN port from desktop.
- Proxmox successfully joins SonicWall LAN when `dhclient vmbr0` is used.

---

##  What’s Not Working

###  Proxmox outbound access
- `ping 8.8.8.8` fails
- Likely missing:
  - Default gateway on Proxmox (`ip route`)
  - Or NAT/outbound rule on SonicWall

###  Inbound access to Proxmox
- From desktop on same switch/home LAN
- Desktop may be on `192.168.1.x` — different subnet from `192.168.168.x`
- No routing in place between home LAN and SonicWall LAN

---

##  TODO 

###  1. Test to see if this fixes Proxmox Internet Access
On Proxmox:
```bash
ip route add default via 192.168.168.168
ping 8.8.8.8
```

If that works, update it permanently in `/etc/network/interfaces`.

###  2. Ensure SonicWall NAT & Outbound Rules Exist
In SonicWall GUI:
- Go to **Network > NAT Policies**:
  - Ensure there’s a NAT policy for LAN → WAN (typically auto-created)
- Go to **Firewall > Access Rules > LAN → WAN**:
  - Ensure there's an **Allow** rule for outbound internet

###  3. Fix Inbound Access (Desktop → Proxmox Web UI)
Currently:
- Desktop is on `192.168.1.x` (home LAN)
- Proxmox is on `192.168.168.x` (SonicWall LAN)

 Options:
1. Temporarily connect desktop to SonicWall X0 port
   - Or assign it a static IP in `192.168.168.x`
   - Then access: `https://192.168.168.105:8006`

2. OR add a static route on home router:
   - Route `192.168.168.0/24` via SonicWall's WAN IP (if routable)
   - Not ideal without double-NAT config

---

##  Optional Future Clean-up
- Assign Proxmox a **static IP** via `/etc/network/interfaces` or SonicWall DHCP reservation
- Add LAN firewall rules to allow Proxmox → Internet and local desktop → Proxmox access
- Optionally isolate Proxmox VLAN/subnet for security