# 🚀 Automatic Installation of the Multimedia Hub via Autoscript

This script allows you to deploy the entire multimedia hub on a **Debian 13 (Trixie)** server with a single command.

---

## 🧩 Prerequisites

- A server or VM running **Debian 13**
- **Root** or **sudo** access
- An active internet connection
- A **ProtonVPN** account with a valid WireGuard key

For WireGuard, go to the Downloads section and create a new WireGuard configuration. Select Router, no filtering, and "NAT‑PMP (Port Forwarding)". Deselect VPN Accelerator. When you click Create, a window will display the configuration. Copy the PrivateKey.

- NAS shares mounted in `/data` and `/data2` (via fstab)
- Minimum configuration:
  - CPU: 4 cores
  - RAM: 8 GB
  - Storage: 64 GB SSD
- Recommended configuration (comfortable):
  - CPU: 6 cores
  - RAM: 16 GB
  - Storage: 128 GB SSD

> 💡 **Note on Plex**: without hardware transcoding (GPU), each transcoded stream can consume 1–2 CPU cores.  
> With **Direct Play** (no transcoding), 4 cores / 8 GB is sufficient.  
> With **transcoding** for 2–3 simultaneous users, plan for 6 cores / 16 GB or a compatible GPU (Intel QuickSync, NVIDIA).

---

## 📁 Contents of the `auto_deploy/` Folder

| File | Description |
|------|-------------|
| `autoscript_install_hub_on_debian.sh` | Complete installation and deployment script |
| `save_hub.sh` | Container configuration backup script |

---

## 🛠️ Installation Steps

### 1. Clone the repository on the server

```bash
git clone --branch classic --single-branch https://github.com/ghost1337john/hub_multimedia.git
cd hub_multimedia
```

### 2. Create the `.env` file

Before running the script, create the `.env` file in the `sources/` folder:

```bash
nano sources/.env
```

Expected content:

```
PUID=1000
PGID=1000
TZ=Europe/Paris
MEDIA_DIR=/data
OPENVPN_USER=your_user+pmp
OPENVPN_PASSWORD=your_password
WIREGUARD_PRIVATE_KEY=your_private_key
SERVER_COUNTRIES=Spain,Portugal
```

> 💡 **How to retrieve PUID and PGID?** Run the `id` command in your terminal. The value after `uid=` is your **PUID** and the value after `gid=` is your **PGID**.
> ```bash
> id
> # uid=1000(plex) gid=1000(plex) → PUID=1000, PGID=1000
> ```

> ⚠️ The `.env` file is **mandatory**. Without it, the script will stop with an error.

### 3. Run the installation script

```bash
sudo bash auto_deploy/autoscript_install_hub_on_debian.sh
```

---

## 📋 What the Script Does

1. Checks root permissions
2. Updates the system (`apt update && upgrade`)
3. Installs Docker and Docker Compose (if not present)
4. Creates the configuration directory structure (`/app/*/config`)
5. Creates data directories (`/data`, `/data2`)
6. Assigns permissions to user PUID/PGID 1000
7. Copies `docker-compose.yml` and `.env` to `/opt/hub_multimedia`
8. Validates the docker-compose file
9. Launches all containers
10. Displays container status and access URLs

---

## 🌐 Service Access After Installation

The script automatically displays URLs with the server IP:

| Service       | Port  |
|---------------|-------|
| Plex          | 32400 |
| Sonarr        | 8989  |
| Radarr        | 7878  |
| Bazarr        | 6767  |
| Seerr         | 5055  |
| Prowlarr      | 9696  |
| qBittorrent   | 8080  |
| FlareSolverr  | 8191  |
| Tautulli      | 8181  |
| Cleanuparr    | 11011 |

---

## 💾 Configuration Backup

Once services are configured via their WebUI, use the backup script:

```bash
sudo bash auto_deploy/save_hub.sh
```

This script:
- Gracefully stops containers
- Archives configurations of all 11 services + docker-compose and .env
- Restarts containers
- Keeps the **5 most recent backups** (automatic rotation)

Archives are stored in `/opt/backups/hub_multimedia/`.

---

## ⚠️ Important Notes

- qBittorrent, Prowlarr, and FlareSolverr go through the VPN (**Gluetun**). If the VPN doesn't start, these services will be inaccessible.
- Plex runs in `network_mode: host` for network discovery.
- NAS mounts (`/data`, `/data2`) must be configured in **fstab** before running the script.
