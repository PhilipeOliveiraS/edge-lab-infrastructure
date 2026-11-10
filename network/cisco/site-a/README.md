# Cisco ISR 4331 — Site A (Edge Router)

## Platform Specifications
* **Chassis:** Cisco ISR4331/K9
* **Software:** Cisco IOS XE Software, Version 16.06.04 (`Everest`)
* **Uplink:** `GigabitEthernet0/0/1` (DHCP via MikroTik LAN Bridge, DHCP reservation `192.168.88.2`)

## Administration & Cryptographic Profile
* Administrative access restricted via VTY access-class `ADMIN-SSH` allowing only `192.168.7.58`.
* SSHv2 enabled with legacy cryptographic suite requirements:
  ```bash
  ssh -p 2222 -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-rsa philipe@192.168.7.59
  ```
* HTTP and HTTPS management servers administratively disabled.
