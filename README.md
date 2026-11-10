# Edge Lab Infrastructure (IaC & Bare-Metal Platform)

<p align="center">
  <img src="https://img.shields.io/badge/RouterOS-7.23.7_Long--Term-blue?style=for-the-badge&logo=mikrotik&logoColor=white" alt="MikroTik RouterOS" />
  <img src="https://img.shields.io/badge/Cisco_IOS--XE-16.6.4-1BA0D7?style=for-the-badge&logo=cisco&logoColor=white" alt="Cisco IOS-XE" />
  <img src="https://img.shields.io/badge/Host-Debian_12_Bare--Metal-A80030?style=for-the-badge&logo=debian&logoColor=white" alt="Debian Linux" />
  <img src="https://img.shields.io/badge/Containerization-Docker_Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker" />
  <img src="https://img.shields.io/badge/Ingress-Cloudflare_Zero_Trust-F38020?style=for-the-badge&logo=cloudflare&logoColor=white" alt="Cloudflare" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="MIT License" />
</p>

---

## 🏛 Executive Overview

This repository maintains the **Infrastructure as Code (IaC), configuration templates, and operational runbooks** for the **Edge Lab**—a hybrid bare-metal and cloud testing environment engineered by **Philipe Oliveira da Silveira**.

Operating under a strict **Constraint-Driven Engineering** philosophy, the Edge Lab leverages enterprise legacy hardware and local virtualization to simulate real-world networking topologies, zero-trust perimeter security, distributed ledger systems, and automated identity governance (such as the [IAM-HR Platform](https://github.com/PhilipeOliveiraS/iam-hr-offboarding-platform)).

---

## 🌐 Network & Topology Blueprint

```text
[ Residential WAN / Gateway (192.168.7.1/24) ]
│
├── [ Admin Workstation: Pop!_OS Laptop (192.168.7.58) ]
│
├── [ Core Router: MikroTik RB3011UiAS-RM (WAN: 192.168.7.59) ]
│         │
│         └── LAN Bridge: 192.168.88.1/24 (Ports ether2–ether10)
│                   │
│                   └── [ Cisco ISR 4331 Site A (Gi0/0/1: 192.168.88.2) ]
│                             (DNAT via RB3011: TCP 2222 -> Port 22)
│
└── [ Compute Node: Cortex-01 Bare-Metal (Debian 12: 192.168.7.29) ]
          │
          └── Cloudflare Zero Trust Tunnel Ingress (Zero Open Ports)
```

---

## 🗂 Repository Structure

* `network/mikrotik/`: Sanitized RouterOS configuration exports (`.rsc`), WAN administrative access rules, and DNAT forwarding policies for edge equipment.
* `network/cisco/`: IOS-XE baseline startup configs, VTY SSH access-lists, interface management, and hardware triage documentation for ISR 4331 Site A & Site B.
* `compute/cortex-01/`: Bare-metal server deployment runbooks, Docker Compose production templates (`factory_default`), and Cloudflare Tunnel ingress configurations.
* `docs/topology/`: Architectural diagrams and physical rack interconnect specifications.

---

## 🔒 Security & Privacy Policy

All configuration files in this repository are **strictly sanitized blueprints**:
* Private credentials, cryptographic secrets, and password hashes have been stripped.
* Hardware identifiers (MAC addresses, serial numbers) and sensitive identifiers have been replaced with standard RFC-compliant documentation values.
* Ingress into the environment is governed by Cloudflare Zero Trust Tunnels without public inbound port forwarding.

---

## 👨‍💻 Maintainer & Engineering Contact

* **Platform Architect:** Philipe Oliveira da Silveira
* **Email:** [philipeoliveira1984@gmail.com](mailto:philipeoliveira1984@gmail.com)
* **LinkedIn:** [linkedin.com/in/philipeoliveiras](https://www.linkedin.com/in/philipeoliveiras/)
* **GitHub:** [github.com/PhilipeOliveiraS](https://github.com/PhilipeOliveiraS)
