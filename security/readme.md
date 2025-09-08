# Security

The homelab includes multiple layers of security and detection controls:

- **Deception & Detection**: Canarytokens, honeyfiles, and fake credentials are deployed across Windows, Linux, and Proxmox hosts to detect unauthorized access attempts.

- **Monitoring**: Netdata dashboards and log collection are configured on Proxmox nodes and VMs for system visibility.

- **Vulnerability Management**: Regular scans are performed with OpenVAS to identify and remediate weaknesses in the homelab subnet.

- **Hardening**:
  - Baseline security applied to hypervisors and VMs (SSH key-only login, local firewall rules, updated packages).
  - Disabled telemetry, error reporting, and unnecessary services; applied OS-specific lockdowns.
  - MFA enabled for remote access.

---

**Note:**  
This section is intentionally high-level. Specific token locations, configs, and alerting details are omitted for security. Documenting too much detail would reduce the effectiveness of these controls, but I still wanted to highlight them here as part of my homelab.

