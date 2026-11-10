# Cortex-01 Bare-Metal Host (Compute Node)

## Hardware Profile
* **Host Model:** HP 1000 Laptop
* **Operating System:** Debian GNU/Linux 12 (Bookworm) Minimal
* **Compute Resources:** ~12 GiB RAM, Dual-Core 64-bit CPU, 120 GiB SSD
* **Local IP:** `192.168.7.29`

## Runtime Topology
All production services run containerized within the Docker isolated bridge network `factory_default`:
* **n8n Community Edition:** Orchestration engine (`n8n.ph3digital.com.br`)
* **PostgreSQL 16:** Relational transactional ledger & concurrency lock engine
* **FastAPI Mock ERP:** Corporate licensing simulation microservice
* **Cloudflare Tunnel (`cloudflared`):** Secure Zero Trust edge ingress without open inbound NAT ports
