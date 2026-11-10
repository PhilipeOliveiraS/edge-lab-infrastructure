# MikroTik RB3011UiAS-RM (Core Router Blueprint)

## Platform Details
* **Hardware:** MikroTik RB3011UiAS-RM
* **RouterOS Channel:** Long-term (`7.23.7`)
* **Interface Roles:**
  * `ether1`: WAN Uplink (DHCP from Gateway)
  * `ether2`–`ether10`: LAN Bridge (`192.168.88.1/24`, DHCP Pool `.10`–`.254`)

## Operational Hardening
* Insecure management services disabled (Telnet, FTP, HTTP, API).
* Management access (SSH port 22, WinBox port 8291) strictly restricted via firewall input filter to the administrative workstation (`192.168.7.58/32`).
* DNAT policy configured on `ether1` (TCP 2222) forwarding securely to Cisco ISR 4331 Site A (`192.168.88.2:22`).
