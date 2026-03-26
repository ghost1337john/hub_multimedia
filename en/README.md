⚠️ Disclaimer — Liability
The author of this project cannot be held responsible for its use.
Each user is fully responsible for ensuring that their usage complies with the laws in force in their country, particularly regarding copyright law.

This project solely provides a technical infrastructure intended for managing legally obtained content.
Any use aimed at downloading, sharing, or accessing copyrighted works without authorization is strictly prohibited and is done at the user's own risk.

# 🎬 Automated Multimedia Hub

This project is exclusively intended for managing multimedia content.
It does not in any way aim to encourage, facilitate, or circumvent copyright protection mechanisms.

🧩 Overview
This multimedia hub offers a complete, automated, and secure ecosystem based on Docker (or Portainer).
It allows the management of organization, retrieval, subtitles, user requests, and network security via VPN.

The goal: to provide a modern, secure, clean, and centralized infrastructure for your personal multimedia libraries.
---

## 🧩 Included Services

### 🔐 Gluetun — VPN + Firewall
Ensures network security by encapsulating sensitive services in a VPN tunnel.

### 🧲 qBittorrent — Secure Downloads
Operates exclusively through Gluetun to guarantee protected traffic.
(Usage must comply with applicable laws and be limited to content you own the rights to.)

### 🧭 Prowlarr — Indexer Manager
Centralizes and synchronizes indexers for Radarr and Sonarr.

### 📺 Sonarr — Automated TV Series
Manages the search, import, and organization of TV series.

### 🎬 Radarr — Automated Movies
Same functionality as Sonarr, but for movies.

### 💬 Bazarr — Automatic Subtitles
Downloads and manages subtitles for Radarr and Sonarr.

### ⭐ Seerr — User Request Interface
Allows users to request movies and TV series already available or to be imported.

### 📺 Plex — Media Server
Centralizes, organizes, and streams your movies, series, and music on all your devices (TV, mobile, browser).

### 📊 Tautulli — Plex Monitoring & Statistics
Provides a comprehensive dashboard to monitor Plex activity, media usage, playback history, and alerts.

### 🛡️ FlareSolverr — Cloudflare Bypass
Proxy allowing Prowlarr to access protected indexers.

### 🐳 Portainer — Container Management WebUI
Graphical interface to manage, monitor, and administer all Docker containers from a browser.

### 🧹 Cleanuparr — Automated Cleanup
New module enabling:
- cleanup of completed synchronizations
- removal of imported torrents
- management of orphaned files
- clean synchronization with Radarr/Sonarr

# 📝 Note on Service Configuration
To keep this project simple, scalable, and independent of individual preferences, I will not detail the specific configuration of each service (Sonarr, Radarr, Prowlarr, qBittorrent, etc.).
Each user is free to adapt the ecosystem to their needs and can easily find complete guides by searching online for the configuration of each tool.

## 🔗 Workflow Diagram

<img width="1104" height="976" alt="Gemini_Generated_Image_6wk7c16wk7c16wk7" src="https://github.com/user-attachments/assets/22c30f5e-73c1-4058-818d-5de3192acc97" />

# 🗂️ Version History

See the [`CHANGELOG.md`](CHANGELOG.md) file for the complete version history.
