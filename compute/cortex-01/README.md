# Cortex-01 Bare-Metal Host (Compute Node)

## Hardware Profile
* **Host Model:** HP 1000 Laptop
* **Processor Architecture:** Intel® Core™ i5-3230M (2 Cores / 4 Threads, 2.60 GHz base clock, scaling up to 3.20 GHz via Intel Turbo Boost).
* **Intelligent Power & Frequency Governor:** Managed by the Linux `intel_pstate` scaling governor to achieve extreme energy efficiency: maintaining quiescent idle draw while scaling instantaneously to peak Turbo Boost clocks during concurrent webhook spikes and headless RPA execution.
* **Operating System:** Debian GNU/Linux 12 (Bookworm) Minimal (Headless, zero GUI overhead)
* **Compute Resources:** ~12 GiB RAM, 120 GiB solid-state storage (SSD)
* **Local IP:** `192.168.7.29`

## Runtime Topology & Hyper-Automation Stack

All production services run containerized within the Docker isolated bridge network `factory_default`:

* **n8n Community Edition:** Core orchestrator coordinating business logic and identity lifecycle workflows (`n8n.ph3digital.com.br`).
* **PostgreSQL 16:** Relational transactional ledger & concurrency lock engine enforcing advisory locks.
* **FastAPI Mock ERP:** Corporate licensing simulation microservice providing idempotent revocation endpoints.
* **Browserless RPA:** Headless Chromium automation engine for programmatic browser execution, synthetic interaction testing, and resilient web scraping.
* **Cloudflare Tunnel (`cloudflared`):** Secure Zero Trust edge ingress without exposed inbound NAT ports.
