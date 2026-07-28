# Qualys Community Edition Setup

Qualys Community Edition is being used as part of my general home lab for vulnerability management.

I originally wanted to integrate it with Microsoft Entra ID using SAML SSO and SCIM provisioning, but those features require additional licensing. Because of that, Qualys is currently separate from my Entra cloud lab.

---

## Sign up

Sign up here:

```text
https://www.qualys.com/community-edition/confirm
```

Fill out the registration form.

Qualys sends an email with the initial login information.

After receiving the email:

1. Log in.
2. Reset the temporary password.
3. Open the Qualys portal.

```text
https://qualysguard.qg3.apps.qualys.com/
```

---

# Setup scanning

Open the Qualys portal:

```text
https://qualysguard.qg3.apps.qualys.com/portal-front/home/
```

Navigate to:

```text
Modules
> Sensor Management
> Cloud Agent
> Agent Management
> New Key
```

Create a new activation key.

```text
Title: home-lab
```

Select the following modules:

```text
GAV
Global Asset View

VM
Vulnerability Management
```

Community Edition currently gives me 16 VM activations.

Generate the activation key and download the appropriate agent for the operating system.

> Do not include the Customer ID, Activation ID, or complete activation commands in a public repository.

---

# Linux installation

Use the package that matches the Linux distribution.

```text
Ubuntu / Debian / Linux Mint: .deb
RHEL / Rocky / AlmaLinux:     .rpm
```

Linux Mint uses the `.deb` package.

## Debian, Ubuntu, or Linux Mint

From the download directory:

```bash
sudo dpkg --install QualysCloudAgent.deb
```

Activate the agent:

```bash
sudo /usr/local/qualys/cloud-agent/bin/qualys-cloud-agent.sh \
  ActivationId="<ACTIVATION_ID>" \
  CustomerId="<CUSTOMER_ID>" \
  ServerUri="https://qagpublic.qg3.apps.qualys.com/CloudAgent/"
```

Installation output:

```text
Selecting previously unselected package qualys-cloud-agent.
Preparing to unpack QualysCloudAgent.deb ...
Unpacking qualys-cloud-agent ...
Setting up qualys-cloud-agent ...
Created symlink:
  /etc/systemd/system/multi-user.target.wants/qualys-cloud-agent.service
  → /usr/lib/systemd/system/qualys-cloud-agent.service
```

## RPM-based Linux

From the download directory:

```bash
sudo rpm -ivh QualysCloudAgent.rpm
```

Activate the agent:

```bash
sudo /usr/local/qualys/cloud-agent/bin/qualys-cloud-agent.sh \
  ActivationId="<ACTIVATION_ID>" \
  CustomerId="<CUSTOMER_ID>" \
  ServerUri="https://qagpublic.qg3.apps.qualys.com/CloudAgent/"
```

---

# Verify the Linux agent

Run:

```bash
sudo systemctl status qualys-cloud-agent
```

The Linux Mint VM showed:

```text
qualys-cloud-agent.service - Qualys cloud agent daemon

Loaded: loaded
Enabled: enabled
Active: active (running)
```

You can also run:

```bash
sudo systemctl is-enabled qualys-cloud-agent
sudo systemctl is-active qualys-cloud-agent
```

Expected output:

```text
enabled
active
```

To review recent agent logs:

```bash
sudo journalctl \
  -u qualys-cloud-agent \
  --since "30 minutes ago"
```

---

# Windows installation

Download:

```text
Windows
.exe (x86_64)
```

Open Command Prompt or PowerShell as administrator in the download directory.

Run:

```powershell
.\QualysCloudAgent.exe `
    CustomerId="{<CUSTOMER_ID>}" `
    ActivationId="{<ACTIVATION_ID>}" `
    WebServiceUri="https://qagpublic.qg3.apps.qualys.com/CloudAgent/"
```

Successful installation output:

```text
Successfully installed Qualys Windows Cloud Agent.
```

To verify the service:

```powershell
Get-Service |
    Where-Object DisplayName -Like "*Qualys*"
```

The Qualys service should show as running.

---

# Verify the agents in Qualys

Navigate to:

```text
Modules
> Sensor Management
> Cloud Agent
> Agent Management
> Agents
```

Both devices should eventually appear in the agent list.

Check for:

```text
Agent status
Last checked in
Provision status
VM activation
Manifest version
Last VM scan
```

The Linux service running locally confirms that the agent started, but the agent still needs to:

```text
Register with Qualys
> Download its configuration
> Download the VM manifest
> Collect inventory
> Upload the results
> Process vulnerability findings
```

---

# Run an on-demand scan

Cloud Agents normally collect and upload vulnerability information automatically, so a separate scanner appliance scan is not required.

I manually triggered an on-demand scan to force another collection cycle.

Navigate to:

```text
Modules
> Sensor Management
> Cloud Agent
> Agent Management
> Agents
```

Select the device and choose:

```text
Quick Actions
> Run On-Demand Scan
```

The on-demand scan does not always make findings appear immediately. Qualys still has to process the inventory and vulnerability data after the agent uploads it.

---

# View vulnerability findings

Check the VM or VMDR module:

```text
Modules
> Vulnerability Management
> Vulnerabilities
```

You can also locate the device through Global Asset View:

```text
Modules
> Global AssetView
> Assets
> Select the device
> Vulnerabilities
```

Search by hostname to locate the Windows or Linux system.

---

# Current status

Qualys Cloud Agents are installed on:

```text
1 Windows system
1 Linux Mint system
```

The Linux Cloud Agent service is enabled and running.

The Windows installation completed successfully.

I also manually triggered an on-demand scan for the devices.

I am currently waiting for both systems to complete their initial inventory uploads and begin displaying vulnerability findings in Qualys.

No separate scanner appliance scan should be required for the Cloud Agents. The main things to verify are:

```
Agent is active
VM module is activated
VM manifest has downloaded
Agent recently checked in
Initial VM scan completed
```
