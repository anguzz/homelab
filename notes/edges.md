| Feature           | Cloudflare Tunnel            | Pangolin (VPS-based)              | Tailscale (VPN mesh)               |
| ----------------- | ---------------------------- | --------------------------------- | ---------------------------------- |
| **Type**          | Reverse proxy (edge network) | Self-hosted reverse proxy edge    | Mesh VPN (peer-to-peer)            |
| **Setup**         | `cloudflared` agent + DNS    | VPS + WireGuard tunnels           | Install Tailscale client           |
| **Traffic Flow**  | User → Cloudflare → homelab  | User → VPS → homelab              | User → direct to homelab (via VPN) |
| **Protocols**     | Mostly HTTP/S                | HTTP, TCP, UDP (flexible)         | Any (full network tunnel)          |
| **Auth**          | Cloudflare Access (optional) | Built-in (SSO, OTP, RBAC)         | Tailscale login (OIDC)             |
| **Public Access** | Yes (internet-facing)        | Yes (internet-facing)             | No (private only unless shared)    |
| **Best For**      | Publishing apps to internet  | Publishing apps with full control | Private access for me/friends     |
