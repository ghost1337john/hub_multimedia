> 🧪 **Branch under development — Do not use in production**
>
> This `windows` branch is currently in the development and testing phase.
> It is not yet ready for real use. Please use the [`classic`](https://github.com/ghost1337john/hub_multimedia/tree/classic) or [`auto-deploy`](https://github.com/ghost1337john/hub_multimedia/tree/auto-deploy) branch in the meantime.

---

# 🪟 Windows Installation

## Prerequisites

- **Windows 10/11** (Pro, Enterprise, or Home with WSL2)
- **Docker Desktop** installed with the **WSL2** backend
  - Download: https://www.docker.com/products/docker-desktop/
- **8 GB RAM** minimum (16 GB recommended for Plex + VPN)
- Active Internet connection
- A **ProtonVPN** account with a subscription that supports port forwarding

---

## Quick Installation

### Option 1: Double-click the .bat file (recommended)

1. Clone the repository or download the `windows_project_test/` folder
2. Double-click **`install_hub_windows.bat`**
3. Accept the administrator elevation prompt
4. Follow the interactive wizard

### Option 2: From PowerShell

```powershell
Set-ExecutionPolicy Bypass -Scope Process
.\windows_project_test\install_hub_windows.ps1
```

### Option 3: Create a real .exe

To convert the script into a standalone `.exe` executable:

```powershell
Install-Module ps2exe -Scope CurrentUser
Invoke-ps2exe .\windows_project_test\install_hub_windows.ps1 .\install_hub.exe
```

Then double-click `install_hub.exe` to launch the installation.

---

## What the Script Does

| Step | Description |
|------|-------------|
| 1 | Checks that Docker Desktop is installed and running |
| 2 | Configures installation directories (interactive) |
| 3 | Configures the VPN connection (WireGuard or OpenVPN) |
| 4 | Generates the `.env` file with your settings |
| 5 | Generates a Windows-adapted `docker-compose.yml` |
| 6 | Validates the docker-compose configuration |
| 7 | Deploys all 12 containers |

---

## Differences from the Linux Version

| Element | Linux | Windows |
|---------|-------|---------|
| VPN Device | `/dev/net/tun` mounted manually | Handled by Docker Desktop/WSL2 |
| Volume paths | `/app/...` | `C:/hub_multimedia/app/...` |
| Plex network | `network_mode: host` | Port mapping (32400) |
| Timezone | `/etc/localtime` mounted | `TZ` environment variable |
| Permissions | `chown` PUID/PGID | Handled by Docker Desktop/WSL2 |
| Script | Bash | PowerShell |

---

## File Structure After Installation

```
C:\hub_multimedia\
├── app\
│   ├── gluetun\config\
│   ├── qbittorrent\config\
│   ├── prowlarr\config\
│   ├── sonarr\config\
│   ├── radarr\config\
│   ├── bazarr\config\
│   ├── seerr\config\
│   ├── flaresolverr\config\
│   ├── cleanuparr\config\
│   ├── tautulli\config\
│   ├── plex\config\
│   └── portainer\config\
├── data\
│   ├── films\
│   ├── series\
│   └── qbittorrent\downloads\
├── data2\
└── docker\
    ├── docker-compose.yml
    └── .env
```

---

## Service Access

| Service | URL |
|---------|-----|
| Plex | http://localhost:32400/web |
| Sonarr | http://localhost:8989 |
| Radarr | http://localhost:7878 |
| Bazarr | http://localhost:6767 |
| Seerr | http://localhost:5055 |
| Prowlarr | http://localhost:9696 |
| qBittorrent | http://localhost:8080 |
| FlareSolverr | http://localhost:8191 |
| Tautulli | http://localhost:8181 |
| Cleanuparr | http://localhost:11011 |
| Portainer | http://localhost:9000 |

---

## Useful Commands

### Check container status
```powershell
cd C:\hub_multimedia\docker
docker compose ps
```

### Restart the stack
```powershell
cd C:\hub_multimedia\docker
docker compose down
docker compose up -d
```

### View service logs
```powershell
docker logs gluetun
docker logs plex
```

### Verify VPN connection
```powershell
docker exec gluetun wget -qO- https://ipinfo.io
```

---

## Troubleshooting

### Docker Desktop is not detected
- Make sure Docker Desktop is installed and running (icon in the system tray)
- Enable WSL2 backend: Docker Desktop → Settings → General → Use the WSL 2 based engine

### Gluetun won't connect to VPN
- Check the logs: `docker logs gluetun`
- Verify credentials in `C:\hub_multimedia\docker\.env`
- For WireGuard: verify that the private key is correct
- For OpenVPN: verify that `+pmp` is appended to the username

### qBittorrent / Prowlarr are inaccessible
These services go through Gluetun. If the VPN is down, they are inaccessible.
```powershell
docker restart gluetun
```

### Plex can't see media files
- Check the paths in `docker-compose.yml`
- In Plex, add libraries pointing to `/movies` or `/series` (paths inside the container)
