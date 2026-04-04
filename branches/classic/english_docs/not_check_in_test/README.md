# 🧪 Not Check In Test — Improvements Under Validation

This folder contains files and scripts **not yet integrated** into the main project.  
They need to be tested and validated before being moved to production folders (`sources/`, `auto_deploy/`, `tuto_config/`).

---

## 📁 Folder Contents

### 🐳 `docker_compose_extras.yml`
Additional containers ready to be added to the main docker-compose:

| Container    | Role                                                         | Port  | Status     |
|--------------|--------------------------------------------------------------|-------|------------|
| Portainer    | Docker container management via WebUI                        | 9000  | ✅ Integrated |
| Watchtower   | Automatic Docker image updates + notifications               | —     | Testing    |
| Uptime Kuma  | Service availability monitoring with alerts                  | 3001  | Testing    |
| Lidarr       | Automated music management (Sonarr/Radarr equivalent)        | 8686  | Testing    |
| Readarr      | Automated ebook management                                   | 8787  | Testing    |
| Recyclarr    | TRaSH Guides quality profile synchronization                 | —     | Testing    |

---

### 🩺 `healthchecks_to_add.yml`
Healthcheck blocks for existing containers.  
**✅ Integrated** into the main docker-compose (v1.3.4).

---

### 🔑 `.env.example`
Template for the `.env` file with all variables needed for deployment.  
Users simply copy this file and fill in their own values.  
Intended to be versioned in the repository (unlike the actual `.env` which should never be committed).

---

### 🔄 `restore_hub.sh`
Interactive configuration restoration script:
- Lists available backups with their sizes
- Numbered selection menu
- Confirmation prompt before overwriting
- Stops containers → extracts archive → restarts

Complements the existing `save_hub.sh` script in `auto_deploy/`.

---

### 🔄 `update_hub.sh`
Automatic container update script:
- Performs a preventive backup before any changes
- Downloads the latest Docker images (`docker compose pull`)
- Redeploys containers with new versions
- Cleans up unused old images
- Displays final container status

---

### ❓ `README_FAQ.md`
FAQ and troubleshooting guide covering common issues:
- VPN / Gluetun (connection, port forwarding)
- Plex (network discovery, files, claim token)
- qBittorrent (password, speed)
- Prowlarr / Indexers (Cloudflare, synchronization)
- Bazarr / Subtitles
- Tautulli (Plex connection)
- Docker (restart, logs, disk space)
- Permissions and network

---

### 📊 `README_MERMAID_DIAGRAM.md`
Mermaid diagram of the complete multimedia hub workflow, including Tautulli.  
Rendered natively by GitHub in Markdown files.  
Intended to replace the current static image in the main README.

---

## 🗂️ Version History (not_check_in_test)

### **v0.1.0 — 2026‑03‑26**
- Created `not_check_in_test` folder
- Added `docker_compose_extras.yml`: Portainer, Watchtower, Uptime Kuma, Lidarr, Readarr, Recyclarr
- Added `healthchecks_to_add.yml`: healthchecks for Plex, Tautulli, Sonarr, Radarr, Bazarr, Prowlarr
- Added `.env.example`: environment variables template
- Added `restore_hub.sh`: interactive restoration script
- Added `update_hub.sh`: update script with preventive backup
- Added `README_FAQ.md`: complete FAQ and troubleshooting
- Added `README_MERMAID_DIAGRAM.md`: Mermaid diagram of the workflow with Tautulli

---

## 📌 Validation Process

1. Test each file on a development environment
2. Verify compatibility with the main docker-compose
3. Once validated, move the file to the appropriate folder
4. Update the main README and version history
