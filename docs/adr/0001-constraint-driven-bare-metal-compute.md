# ADR 0001: Constraint-Driven Bare-Metal Compute Platform

## Status
Accepted

## Context
Deploying full enterprise automation and identity lifecycle stacks—including workflow orchestrators (n8n), transactional relational ledgers (PostgreSQL 16), mock microservices (FastAPI), and AI agent synthesizers—on managed public cloud infrastructure (such as AWS ECS, GCP Cloud Run, or multi-node Kubernetes) incurs substantial recurring operational expenses (FinOps overhead) and abstracts away key physical systems realities.

To support continuous development, deterministic performance verification, and load simulation without monthly cloud compute bills, a local dedicated compute resource was required.

The host hardware available is a repurposed bare-metal node (`HP 1000 Laptop`, dual-core 64-bit x86_64, ~12 GiB RAM, 120 GiB SSD), designated as `Cortex-01`.

## Decision
We deploy the core platform services bare-metal on Debian GNU/Linux 12 (Bookworm Minimal) containerized via Docker Engine and Docker Compose under an isolated bridge network (`factory_default`).

Key implementation aspects:
1. **Host OS:** Minimal headless Debian 12 for maximum kernel stability, predictable memory utilization, and zero GUI footprint.
2. **Network Isolation:** All microservices run in a private container network without binding sensitive ports (such as PostgreSQL 5432 or Mock ERP 8000) directly to public interfaces.
3. **Resource Containment:** Strict containment policies applied to Docker containers to prevent memory starvation on the 12 GiB boundary.
4. **Resilience & Autostart:** Docker containers configured with `restart: unless-stopped` to survive power cycles and maintain high service availability.

## Consequences
### Positive
* **Zero Variable Cloud Cost:** The platform runs 24/7 without cloud hourly runtime costs, NAT gateway bandwidth fees, or egress charges.
* **Deterministic Resource Profiling:** Enforces strict memory and compute hygiene, ensuring that software runtimes (such as IAM-HR) are architected efficiently before cloud migration.
* **Direct Hardware Telemetry:** Enables monitoring of thermal state, physical storage wear, and raw Linux kernel metrics.

### Negative / Trade-offs
* **Compute Ceilings:** Constrained to dual-core x86_64 CPU and 12 GiB RAM, requiring deliberate memory capping and preventing large concurrent worker spikes without horizontal scaling.
* **Single Node Availability:** Hardware maintenance on Cortex-01 temporarily halts local container runtimes.
