# ADR 0002: MikroTik & Cisco Hybrid Edge Fabric

## Status
Accepted

## Context
Enterprise operational environments rarely feature homogeneous single-vendor networking. Production platforms frequently interface between modern programmable edge gateways and enterprise routing equipment requiring specialized cryptographic and management protocols.

The Edge Lab incorporates both a **MikroTik RB3011UiAS-RM** (running RouterOS 7.23.7 Long-term) and **Cisco ISR 4331** modular enterprise routers (running Cisco IOS XE 16.06.04 Everest). 

We required a structured networking architecture that:
1. Provides clean subnet segmentation between the residential uplink (`192.168.7.0/24`) and the internal lab infrastructure (`192.168.88.0/24`).
2. Implements secure out-of-band management for downstream enterprise appliances without exposing broad access.
3. Segregates operational routing (Site A) from appliances undergoing hardware diagnostics (Site B).

## Decision
We establish a hybrid edge routing hierarchy with strict role separation:

1. **MikroTik RB3011 as Core Router and Gateway Aggregator:**
   * Serves as the L3 perimeter and DHCP server for the lab LAN bridge (`192.168.88.1/24`).
   * Hardened input firewall chains dropping all unauthenticated WAN ingress while permitting strictly filtered management traffic (WinBox 8291 and SSH 22) from the authorized administrative workstation (`192.168.7.58/32`).
   * Provides Destination NAT (DNAT) translation mapping external port TCP `2222` to internal SSH port `22` on Cisco Site A (`192.168.88.2`).

2. **Cisco ISR 4331 Site A as Dedicated Enterprise Edge Router:**
   * Uplinked to the RB3011 LAN bridge via `GigabitEthernet0/0/1` with static DHCP reservation.
   * VTY remote management locked down using a strict standard access-list (`ADMIN-SSH`) permitting access only from the administrative workstation (`192.168.7.58`).
   * HTTP and HTTPS embedded servers disabled to eliminate legacy web interface vulnerabilities.

3. **Cisco ISR 4331 Site B Isolation:**
   * Held in standby isolation for power supply unit (PSU) and boot sequence triage, preventing unverified electrical or topology interactions with active fabric.

## Consequences
### Positive
* **Defense-in-Depth:** Management traffic must navigate both the MikroTik stateful input filter and the Cisco IOS-XE VTY access-class.
* **Realistic Multi-Vendor Modeling:** Provides hands-on testing for mixed RouterOS / Cisco IOS-XE topologies and legacy SSH cryptographic negotiation (`diffie-hellman-group14-sha1`, `ssh-rsa`).
* **Controlled Access Forwarding:** DNAT on TCP 2222 avoids port conflicts while keeping internal addressing deterministic.

### Negative / Trade-offs
* **Dual Administrative Overhead:** Requires maintaining separate CLI workflows and configuration syntax across RouterOS scripting (`.rsc`) and Cisco IOS-XE (`.cfg`).
