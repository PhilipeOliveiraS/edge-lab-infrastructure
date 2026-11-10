# ADR 0003: Cloudflare Zero Trust Perimeter Ingress

## Status
Accepted

## Context
Exposing local containerized services (such as the n8n orchestration console, webhook endpoints, or web-based dashboards) to the public internet traditionally requires configuring Dynamic DNS (DDNS), exposing inbound port forwardings on the residential gateway, or maintaining complex reverse proxy configurations with manual TLS certificate rotation.

Inbound port forwarding introduces significant security liabilities:
* Port scanners and automated bot traffic probe residential IP addresses.
* Inbound ports expose internal subnet topology if perimeter software contains zero-day vulnerabilities.
* Residential dynamic public IPs introduce fragility and downtime during provider IP changes.

## Decision
We enforce a **Zero Open Inbound Ports** ingress policy across the entire Edge Lab perimeter by utilizing **Cloudflare Zero Trust Tunnels (`cloudflared`)**.

Implementation details:
1. **Outbound Tunnel Connection:** The `cloudflared` daemon runs on the host, establishing secure, multiplexed outbound connections (QUIC / HTTP/2) to the nearest Cloudflare edge locations.
2. **Layer-7 Edge Protection:** All public traffic to `*.ph3digital.com.br` passes through Cloudflare edge proxying with active Web Application Firewall (WAF) rate-limiting rules (e.g., 5 requests / 10s for API actions).
3. **Internal Routing:** Cloudflare routes authenticated traffic through the tunnel directly to internal container endpoints (e.g., `http://127.0.0.1:3001` or container name) without exposing intermediate ports to the local network or internet.

## Consequences
### Positive
* **Total Inbound Attack Surface Elimination:** Zero inbound NAT/firewall rules required on the residential ONT or MikroTik router.
* **Automated TLS & DDoS Mitigation:** Automatic TLS termination at the Cloudflare edge with global DDoS protection and rate limiting.
* **Carrier-Grade NAT (CGNAT) Resilient:** Operates transparently regardless of dynamic IP rotation or ISP CGNAT boundaries.

### Negative / Trade-offs
* **External SaaS Dependency:** Ingress accessibility depends on Cloudflare network availability and tunnel health.
* **Payload Size Constraints:** Edge proxy imposes standard Cloudflare free-tier payload limits (e.g., 100MB HTTP POST bodies), which is well above API operational payloads.
