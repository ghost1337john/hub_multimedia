> ⚠️ **Disclaimer — Liability**
>
> The author of this project cannot be held responsible for its use.
> Each user is fully responsible for ensuring that their usage complies with the laws in force in their country, particularly regarding copyright law.
>
> This project solely provides a technical infrastructure intended for managing **legally obtained** content.
> Any use aimed at downloading, sharing, or accessing copyrighted works without authorization is **strictly prohibited** and is done at the user's own risk.

---

# 🎬 Automated Multimedia Hub

> *A complete, secure, and automated Docker ecosystem for your personal multimedia libraries.*

![Docker](https://img.shields.io/badge/Docker-ready-2496ED?logo=docker&logoColor=white)
![Docker Compose](https://img.shields.io/badge/Docker%20Compose-v2-2496ED?logo=docker&logoColor=white)
![Plex](https://img.shields.io/badge/Plex-Media%20Server-E5A00D?logo=plex&logoColor=white)
![VPN](https://img.shields.io/badge/VPN-ProtonVPN-6D4AFF?logo=protonvpn&logoColor=white)
![License](https://img.shields.io/badge/Usage-Personal%20only-green)

This project is exclusively intended for managing multimedia content.
It does not in any way aim to encourage, facilitate, or circumvent copyright protection mechanisms.

---

## 📋 Table of Contents

- [🧩 Overview](#-overview)
- [⚙️ Included Services](#️-included-services)
- [🏗️ Architecture](#️-architecture)
- [🔗 Workflow Diagram](#-workflow-diagram)
- [🚀 Quick Start](#-quick-start)
- [🛠️ Prerequisites](#️-prerequisites)
- [📁 Project Structure](#-project-structure)
- [🌿 Git Strategy](#-git-strategy)
- [📝 Note on Configuration](#-note-on-configuration)
- [❓ FAQ / Troubleshooting](#-faq--troubleshooting)
- [🗂️ Version History](#️-version-history)

---

## 🧩 Overview

This multimedia hub offers a **complete, automated, and secure ecosystem** based on Docker (or Portainer).
It allows the management of organization, retrieval, subtitles, user requests, and network security via VPN.

**The goal:** to provide a modern, secure, clean, and centralized infrastructure for your personal multimedia libraries.

---

## ⚙️ Included Services

| # | Service | Role | Port |
|---|---------|------|------|
| 1 | 🔐 **Gluetun** | VPN + Firewall (ProtonVPN tunnel) | — |
| 2 | 🧲 **qBittorrent** | Secure downloads via VPN | 8080 |
| 3 | 🧭 **Prowlarr** | Centralized indexer manager | 9696 |
| 4 | 📺 **Sonarr** | Automated TV series management | 8989 |
| 5 | 🎬 **Radarr** | Automated movie management | 7878 |
| 6 | 💬 **Bazarr** | Automatic subtitle management | 6767 |
| 7 | ⭐ **Seerr** | User request interface | 5055 |
| 8 | 📺 **Plex** | Media server (streaming) | 32400 |
| 9 | 📊 **Tautulli** | Plex monitoring & statistics | 8181 |
| 10 | 🛡️ **FlareSolverr** | Cloudflare bypass for Prowlarr | 8191 |
| 11 | 🐳 **Portainer** | Container management WebUI | 9000 |
| 12 | 🧹 **Cleanuparr** | Automated download cleanup | 11011 |

> 🔒 **qBittorrent**, **Prowlarr**, and **FlareSolverr** use `network_mode: service:gluetun` — they share the VPN container's network namespace.
>
> **Advantages of this architecture:**
> - **All traffic goes through the VPN**: these services have no direct Internet access — everything is routed through the WireGuard/OpenVPN tunnel.
> - **Automatic kill switch**: if the VPN goes down, these services lose all connectivity — no IP leaks possible.
> - **Simplified local communication**: services sharing the same network namespace communicate via `localhost` (e.g., Prowlarr → FlareSolverr on `localhost:8191`).
> - **Ports exposed via Gluetun**: since these services don't have their own network stack, their ports are declared on the Gluetun container — this is the expected and recommended behavior.

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────┐
│                  MULTIMEDIA HUB                         │
│                                                         │
│  ┌──────────┐    ┌──────────┐    ┌──────────────────┐   │
│  │  Seerr   │───▶│  Radarr  │───▶│                  │   │
│  │ (5055)   │    │  (7878)  │    │   qBittorrent    │   │
│  └──────────┘    └──────────┘    │     (8080)       │   │
│       │          ┌──────────┐    │  via Gluetun VPN │   │
│       └─────────▶│  Sonarr  │───▶│                  │   │
│                  │  (8989)  │    └──────────────────┘   │
│                  └──────────┘             │             │
│                       │                  ▼             │
│              ┌─────────────────┐  ┌──────────────┐     │
│              │    Prowlarr     │  │  FlareSolverr │     │
│              │     (9696)      │  │    (8191)     │     │
│              └─────────────────┘  └──────────────┘     │
│                       │                                 │
│              ┌─────────────────┐                        │
│              │     Bazarr      │                        │
│              │     (6767)      │                        │
│              └─────────────────┘                        │
│                       │                                 │
│              ┌─────────────────┐  ┌──────────────┐     │
│              │      Plex       │  │  Cleanuparr  │     │
│              │    (32400)      │  │   (11011)    │     │
│              └─────────────────┘  └──────────────┘     │
│                       │                                 │
│              ┌─────────────────┐  ┌──────────────┐     │
│              │    Tautulli     │  │  Portainer   │     │
│              │     (8181)      │  │   (9000)     │     │
│              └─────────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────┘
```

---

## 🔗 Workflow Diagram

<img width="1104" height="976" alt="Hub multimedia services workflow diagram" src="https://github.com/user-attachments/assets/22c30f5e-73c1-4058-818d-5de3192acc97" />

---

## 🚀 Quick Start

### 4-Step Installation

```bash
# 1. Clone the repository
git clone https://github.com/ghost1337john/hub_multimedia.git
cd hub_multimedia/sources

# 2. Create and configure the .env file
cp .env.example .env   # then edit with your VPN credentials

# 3. Create required directories
sudo mkdir -p /app/{gluetun,qbittorrent,prowlarr,sonarr,radarr,cleanuparr,bazarr,seerr,flaresolverr,plex,tautulli,portainer}/config
sudo mkdir -p /data/qbittorrent/downloads

# 4. Launch the stack
docker compose up -d
```

> For a complete and detailed installation guide, see [`english_docs/README_HOWTOINSTALL.md`](README_HOWTOINSTALL.md)

---

## 🛠️ Prerequisites

### 🔧 Hardware & System

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| CPU | 4 cores | 6 cores |
| RAM | 8 GB | 16 GB |
| Storage | 64 GB SSD | 128 GB SSD |
| OS | Linux (Debian/Ubuntu) | Debian 13 |

> 💡 Without a GPU, each Plex transcoded stream consumes 1–2 CPU cores.

### 📦 Required Software

- **Docker** (latest stable version)
- **Docker Compose** v2 or higher
- **Git**

### 🔐 VPN & Network

- Active **ProtonVPN** account (port forwarding compatible)
- Valid **WireGuard** key (or OpenVPN credentials)

---

## 📁 Project Structure

```
hub_multimedia/
├── sources/
│   ├── docker_compose.yml      # Main Docker stack
│   └── .env                    # Environment variables (VPN, paths)
├── french_docs/
│   ├── README.md
│   ├── README_HOWTOINSTALL.md
│   ├── README_SOURCES.md
│   └── tuto_config/            # Service configuration tutorials
├── english_docs/
│   ├── README.md               # This file
│   ├── README_HOWTOINSTALL.md
│   └── tuto_config/
├── CHANGELOG.md
└── README.md                   # French root README
```

---

## 🌿 Git Strategy

The repository is organized around one main branch and specialized branches:

- `Project`: full reference branch with all variants.
- `classic`: manual Linux installation variant (without auto-deploy and without Windows).
- `auto-deploy`: automated Debian variant (script + Linux stack).
- `windows`: Windows installation variant.

Recommended merge conventions:

1. Open PRs against the business target branch (not always `Project`).
2. Cross-cutting changes (Docker stack, security, shared docs) should land in `Project` first.
3. Then backport only the needed commits to specialized branches with selective `cherry-pick` to avoid reintroducing removed folders.
4. Avoid merging specialized branches back into `Project` unless explicitly validated.

Example targeted sync:

```bash
git checkout classic
git cherry-pick <commit_sha_from_Project>
```

---

## 📝 Note on Configuration

To keep this project **simple, scalable, and independent** of individual preferences, the specific configuration of each service (Sonarr, Radarr, Prowlarr, qBittorrent, etc.) is not detailed here.

Each user is free to adapt the ecosystem to their needs. Dedicated tutorials are available in the [`english_docs/tuto_config/`](tuto_config/) folder.

---

## ❓ FAQ / Troubleshooting

For a more complete FAQ (detailed guides, common issues, and advanced solutions), see:

- 🇬🇧 Full FAQ (EN) : [`README_FAQ.md`](README_FAQ.md)
- 🇫🇷 FAQ complète (FR) : [`french_docs/README_FAQ.md`](../french_docs/README_FAQ.md)

<details>
<summary>🔴 A container won't start</summary>

```bash
# Check container logs
docker logs <container_name>

# Check the status of all services
docker compose ps
```
</details>

<details>
<summary>🔴 Gluetun / VPN won't connect</summary>

```bash
# Check Gluetun logs
docker logs gluetun

# Check current public IP (should be the VPN's IP)
docker exec gluetun wget -qO- https://api.ipify.org
```

Make sure your WireGuard key and ProtonVPN credentials are correct in the `.env` file.
</details>

<details>
<summary>🔴 qBittorrent / Prowlarr unreachable</summary>

These services route through Gluetun. If they are unreachable, first check that **Gluetun is healthy**.

```bash
docker compose ps gluetun
```
</details>

<details>
<summary>🔴 File permission issues</summary>

```bash
# Check your PUID/PGID
id

# Re-apply permissions
sudo chown -R 1000:1000 /app
sudo chown -R 1000:1000 /data
```

Make sure `PUID` and `PGID` in the `.env` file match your user.
</details>

<details>
<summary>🔵 Update containers</summary>

```bash
docker compose pull
docker compose up -d
```
</details>

<details>
<summary>🔵 Cleanly stop the stack</summary>

```bash
docker compose down
```
</details>

---

## 🗂️ Version History

See the [`CHANGELOG.md`](CHANGELOG.md) file for the complete version history.
