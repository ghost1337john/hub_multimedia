# ❓ FAQ & Troubleshooting — Multimedia Hub

---

## 📋 Table of Contents

- [🚀 Quick Diagnostics](#-quick-diagnostics)
- [🔐 VPN / Gluetun](#-vpn--gluetun)
- [📺 Plex](#-plex)
- [🧲 qBittorrent](#-qbittorrent)
- [🧭 Prowlarr / Indexers](#-prowlarr--indexers)
- [🌐 FlareSolverr](#-flaresolverr)
- [📺 Sonarr / TV Series](#-sonarr--tv-series)
- [🎬 Radarr / Movies](#-radarr--movies)
- [💬 Bazarr / Subtitles](#-bazarr--subtitles)
- [🎵 Lidarr / Music](#-lidarr--music)
- [🎬 Seerr / Requests](#-seerr--requests)
- [🧹 Cleanuparr](#-cleanuparr)
- [📊 Tautulli](#-tautulli)
- [🐳 Portainer](#-portainer)
- [🐳 General Docker](#-general-docker)
- [📁 Permissions](#-permissions)
- [🌐 Network](#-network)
- [💾 Backup & Restore](#-backup--restore)
- [🔄 Updating the Hub](#-updating-the-hub)
- [📝 Logs & Advanced Debugging](#-logs--advanced-debugging)

---

## 🚀 Quick Diagnostics

Before looking for a specific problem, run these commands for an overview:

### Check all container status
```bash
cd /opt/hub_multimedia && docker compose ps
```
Healthy containers show `Up (healthy)`. A container showing `unhealthy` or `restarting` indicates a problem.

### Check container resource consumption
```bash
docker stats --no-stream
```

### Check available disk space
```bash
df -h /data /data2 /app
```
> ⚠️ If a disk is more than 95% full, containers may malfunction (write failures, crashes, data corruption).

### Check recent logs of a failing container
```bash
docker logs --tail 50 <container_name>
```

### Test network connectivity between containers
```bash
docker exec sonarr ping -c 2 172.19.0.5
```

---

## 🔐 VPN / Gluetun

### The VPN won't connect
- Check that your WireGuard key is correct in the `.env`
- Verify that your ProtonVPN account supports port forwarding (paid plan required)
- Check the logs: `docker logs gluetun`
- Verify that the device `/dev/net/tun` exists on your server:
  ```bash
  ls -la /dev/net/tun
  ```
  If missing, load the kernel module:
  ```bash
  sudo modprobe tun
  ```
- Verify that the VPN type in `.env` matches your credentials (`VPN_TYPE=wireguard` or `VPN_TYPE=openvpn`)

### qBittorrent / Prowlarr / FlareSolverr are inaccessible
These services go through Gluetun (`network_mode: service:gluetun`). If the VPN is down, they are inaccessible.
- Check Gluetun status: `docker ps | grep gluetun`
- Restart the VPN: `docker restart gluetun`
- Verify Gluetun is `healthy` before restarting dependent services:
  ```bash
  docker inspect gluetun --format='{{.State.Health.Status}}'
  ```
- If Gluetun is healthy but services are still inaccessible, restart them:
  ```bash
  docker restart qbittorrent prowlarr flaresolverr
  ```

### Port forwarding is not working
- Verify that you added `+pmp` at the end of your `OPENVPN_USER` in the `.env`
- Verify that `VPN_PORT_FORWARDING=on` is set in the docker-compose
- Verify that `PORT_FORWARD_ONLY=on` is configured if you want to force servers with port forwarding
- Check the assigned port:
  ```bash
  docker logs gluetun 2>&1 | grep "port forwarded"
  ```
- Verify the port is properly applied to qBittorrent:
  ```bash
  docker exec gluetun wget -qO- http://127.0.0.1:8080/api/v2/app/preferences 2>/dev/null | grep listen_port
  ```

### Verify that Gluetun is connected to the VPN

To confirm that Gluetun has successfully established the VPN connection, several methods:

**1. Check the Gluetun logs:**
```bash
docker logs gluetun
```
Look for lines indicating a successful connection:
```
INFO [vpn] connected to ...
INFO [port forwarding] port forwarded is ...
```
If you see `AUTH` or `TLS` errors, check your credentials in the `.env` file.

**2. Check the public IP used by the VPN:**
```bash
docker exec gluetun wget -qO- https://ipinfo.io
```
The displayed IP should be different from your real IP and match the country configured in `SERVER_COUNTRIES`.

**3. Check the status via Gluetun's built-in API (port 8000):**
```bash
curl http://localhost:8000/v1/openvpn/status
```
Expected response: `{"status":"running"}`

**4. Check for DNS leaks:**
```bash
docker exec gluetun cat /etc/resolv.conf
```
The DNS should point to a VPN server, not your local DNS.

> 💡 If the VPN connection is down, all services routed through Gluetun (qBittorrent, Prowlarr, FlareSolverr) will be inaccessible.

### The VPN keeps disconnecting
- Check the logs for keepalive errors:
  ```bash
  docker logs gluetun 2>&1 | grep -i "keepalive\|timeout\|disconnect"
  ```
- Try changing the VPN country in `.env` (`SERVER_COUNTRIES`)
- Verify that `UPDATER_PERIOD=24h` is configured to automatically update servers
- If using WireGuard, regenerate your private key from the ProtonVPN portal

---

## 📺 Plex

### Plex is not found on the local network
- Plex uses `network_mode: host`, it should be directly accessible via the server IP on port 32400
- Check that port 32400 is not blocked by a firewall:
  ```bash
  sudo ufw status
  sudo ufw allow 32400/tcp
  ```
- Check the logs: `docker logs plex`
- Verify Plex is listening:
  ```bash
  curl -s http://localhost:32400/identity
  ```

### Plex can't see my files
- Verify that volumes `/data` and `/data2` are correctly mounted in fstab:
  ```bash
  mount | grep -E "/data|/data2"
  ```
- Check permissions: `ls -la /data/` (should belong to 1000:1000)
- In Plex, add libraries pointing to `/movies` or `/series` (the paths inside the container)
- If you just added files, trigger a manual scan: Plex → Libraries → `...` → Scan Library Files

### The claim token has expired
- Get a new token at https://plex.tv/claim (valid for 4 minutes)
- Add it in the docker-compose: `PLEX_CLAIM=claim-xxxxx`
- Redeploy: `docker compose up -d plex`

### Transcoding is slow or failing
- Check that the `/transcode` directory has enough disk space
- Check transcoding settings: Settings → Transcoder
- For hardware transcoding (GPU), verify the device is mounted in docker-compose:
  ```yaml
  devices:
    - /dev/dri:/dev/dri
  ```
- Check GPU capabilities:
  ```bash
  ls -la /dev/dri/
  ```

### Plex is inaccessible from outside (remote access)
- Verify that remote access is enabled in Settings → Remote Access
- Check that port 32400 is open on your router (port forwarding/NAT)
- If behind CGNAT, direct remote access won't work (use a reverse proxy or tunnel)

### Plex database is corrupted
- Symptoms: Plex crashes on startup, libraries empty despite files being present
- Stop Plex: `docker stop plex`
- Backup the database (host path, via the volume mount `/app/plex/config:/config`):
  ```bash
  DB_PATH="/app/plex/config/Library/Application Support/Plex Media Server/Plug-in Support/Databases"
  cp "${DB_PATH}/com.plexapp.plugins.library.db" "${DB_PATH}/com.plexapp.plugins.library.db.backup"
  ```
- Check database integrity with `sqlite3` (install on the host if missing: `sudo apt install sqlite3`):
  ```bash
  sqlite3 "${DB_PATH}/com.plexapp.plugins.library.db" "PRAGMA integrity_check"
  ```
- If the check returns errors, attempt a repair:
  ```bash
  sqlite3 "${DB_PATH}/com.plexapp.plugins.library.db" ".clone ${DB_PATH}/com.plexapp.plugins.library-repaired.db"
  mv "${DB_PATH}/com.plexapp.plugins.library.db" "${DB_PATH}/com.plexapp.plugins.library-corrupt.db"
  mv "${DB_PATH}/com.plexapp.plugins.library-repaired.db" "${DB_PATH}/com.plexapp.plugins.library.db"
  ```
- Restart Plex: `docker start plex`
- If the repair fails, restore the backup: `cp "${DB_PATH}/com.plexapp.plugins.library.db.backup" "${DB_PATH}/com.plexapp.plugins.library.db"`

---

## 🧲 qBittorrent

### The default password doesn't work
On first launch, qBittorrent generates a random password.
- Check the logs: `docker logs qbittorrent`
- Look for the line containing `temporary password`
- Once logged in, change the password in: Tools → Options → Web UI

### Downloads are slow
- Verify that VPN port forwarding is active:
  ```bash
  docker logs gluetun 2>&1 | grep "port forwarded"
  ```
- Verify the port is configured in qBittorrent: Tools → Options → Connection → Listening Port
- Check the connection settings in qBittorrent WebUI (speed limits)
- Check the max connections: Tools → Options → Connection (increase if needed)

### Downloads are stalled
- Verify the VPN is connected and port forwarding is working
- Check that trackers are responding: right-click torrent → Trackers
- Verify sufficient disk space:
  ```bash
  df -h /data/downloads
  ```
- Restart qBittorrent: `docker restart qbittorrent`

### Files are not being moved to Sonarr/Radarr
- Verify the download path in qBittorrent (`/downloads`) matches what is mounted in Sonarr/Radarr
- Check categories in qBittorrent: torrents sent by Sonarr should have category `tv`, those from Radarr `movies`
- Check permissions on the download folder:
  ```bash
  ls -la ${MEDIA_DIR}/qbittorrent/downloads/
  ```

### WebUI is not accessible
- The WebUI goes through Gluetun (port 8080). First check that Gluetun is healthy
- Check the logs:
  ```bash
  docker logs qbittorrent --tail 20
  ```
- Verify the port is mapped in the `gluetun` service of docker-compose (`8080:8080/tcp`)

---

## 🧭 Prowlarr / Indexers

### Indexers fail with Cloudflare errors
- Verify that FlareSolverr is running: `docker ps | grep flaresolverr`
- In Prowlarr, configure FlareSolverr as a proxy:
  1. Settings → Indexers → Add → FlareSolverr
  2. Host: `http://localhost:8191` (because Prowlarr and FlareSolverr share Gluetun's network)
  3. Add a tag (e.g., `flaresolverr`)
  4. On each Cloudflare indexer, add this tag

### Prowlarr doesn't sync with Sonarr/Radarr
- Check the API keys in Prowlarr (Settings → Apps)
- Addresses must use the Docker network IPs:
  - Sonarr: `http://172.19.0.6:8989`
  - Radarr: `http://172.19.0.5:7878`
- Get the Sonarr/Radarr API key: Settings → General → API Key
- Test the connection with the "Test" button in Prowlarr

### Indexers return 401/403 errors
- Verify your indexer credentials or API keys are still valid
- Some indexers rate-limit requests — wait a few minutes
- Check if the indexer is still online via a browser

### Prowlarr won't start or keeps restart-looping
- Prowlarr depends on Gluetun (`network_mode: service:gluetun`). First check that Gluetun is healthy
- Check the logs:
  ```bash
  docker logs prowlarr --tail 30
  ```
- If the database is corrupted, remove it and restart:
  ```bash
  docker stop prowlarr
  rm /app/prowlarr/config/prowlarr.db-journal
  docker start prowlarr
  ```

---

## 🌐 FlareSolverr

### FlareSolverr won't start
- FlareSolverr depends on Gluetun. Verify Gluetun is healthy:
  ```bash
  docker inspect gluetun --format='{{.State.Health.Status}}'
  ```
- Check the logs:
  ```bash
  docker logs flaresolverr --tail 20
  ```

### FlareSolverr can't solve Cloudflare challenges
- Some sites have advanced anti-bot protections that FlareSolverr cannot bypass
- Verify FlareSolverr is up to date:
  ```bash
  docker pull ghcr.io/flaresolverr/flaresolverr:latest
  docker compose up -d flaresolverr
  ```
- Increase the timeout in Prowlarr if resolutions are slow
- Check logs for specific errors:
  ```bash
  docker logs flaresolverr 2>&1 | grep -i "error\|timeout"
  ```

### FlareSolverr uses too much memory
- FlareSolverr uses a headless browser (Chromium) which consumes RAM
- Restart FlareSolverr regularly if memory increases:
  ```bash
  docker restart flaresolverr
  ```
- Check memory consumption:
  ```bash
  docker stats flaresolverr --no-stream
  ```

---

## 📺 Sonarr / TV Series

### Sonarr doesn't detect downloaded episodes
- Verify the download path in the Download Client matches the mount in Sonarr
- In Sonarr: Settings → Download Clients → check remote vs local path
- Check permissions:
  ```bash
  ls -la /data/downloads/
  ```
- Check the logs: Activity → Queue → warning icon for detailed error

### Sonarr returns no search results
- Verify Prowlarr is correctly configured and synced (Settings → Indexers)
- Check quality profiles are correctly configured (Settings → Profiles)
- Verify the series is monitored: Series → series → calendar icon enabled
- Test a manual search: Series → series → interactive search

### Sonarr shows "Import failed: Access denied"
- Check PUID/PGID permissions in the `.env`
- Verify the destination folder is accessible:
  ```bash
  sudo chown -R 1000:1000 /data /data2
  ```
- Check the volume mounts in docker-compose

### Sonarr is inaccessible (port 8989)
- Verify the container is running:
  ```bash
  docker ps | grep sonarr
  ```
- Check the logs:
  ```bash
  docker logs sonarr --tail 20
  ```
- Check the healthcheck:
  ```bash
  curl -f http://localhost:8989/ping
  ```

### Finding the Sonarr API key
To find the API key (needed for Prowlarr, Bazarr, etc.):
- Sonarr WebUI → Settings → General → Security → API Key
- Or via command line:
  ```bash
  docker exec sonarr cat /config/config.xml | grep -oP '(?<=<ApiKey>).*(?=</ApiKey>)'
  ```

---

## 🎬 Radarr / Movies

### Radarr doesn't detect downloaded movies
- Verify the download path in the Download Client matches the mount in Radarr
- In Radarr: Settings → Download Clients → check the configuration
- Check permissions on `/data` and `/downloads` folders
- Check the queue: Activity → Queue

### Radarr returns no search results
- Verify Prowlarr is correctly synced (Settings → Indexers)
- Check quality profiles (Settings → Profiles) — an overly restrictive profile may filter all results
- Verify the movie is monitored: Movies → movie → monitor icon enabled

### Radarr shows "Import failed" or "Access denied"
- Same solutions as Sonarr: check PUID/PGID and folder permissions
- Verify the Root Folder exists and is accessible:
  ```bash
  ls -la /data/
  ```

### Radarr is inaccessible (port 7878)
- Verify the container is running:
  ```bash
  docker ps | grep radarr
  ```
- Check the logs:
  ```bash
  docker logs radarr --tail 20
  ```
- Check the healthcheck:
  ```bash
  curl -f http://localhost:7878/ping
  ```

### Finding the Radarr API key
To find the API key:
- Radarr WebUI → Settings → General → Security → API Key
- Or via command line:
  ```bash
  docker exec radarr cat /config/config.xml | grep -oP '(?<=<ApiKey>).*(?=</ApiKey>)'
  ```

---

## 💬 Bazarr / Subtitles

### Bazarr can't find subtitles
- Verify that providers are configured (Settings → Providers)
- Some providers require an account (OpenSubtitles, Addic7ed)
- Check the connection with Sonarr/Radarr (Settings → Sonarr / Settings → Radarr)
- Verify the desired languages are configured: Settings → Languages

### Bazarr can't connect to Sonarr/Radarr
- Check the IP addresses and API keys in Settings → Sonarr and Settings → Radarr
- Addresses to use (Docker network):
  - Sonarr: `http://172.19.0.6:8989`
  - Radarr: `http://172.19.0.5:7878`
- Test the connection with the "Test" button
- Verify Sonarr and Radarr are accessible:
  ```bash
  curl -f http://172.19.0.6:8989/ping
  curl -f http://172.19.0.5:7878/ping
  ```

### Downloaded subtitles don't match
- Check the minimum score in Settings → Subtitles (a score too low accepts poor quality subtitles)
- Enable "Perfect Match" mode for better results
- Verify your media file names are clean (Bazarr uses file names for searching)

### Bazarr is inaccessible (port 6767)
```bash
docker ps | grep bazarr
docker logs bazarr --tail 20
curl -f http://localhost:6767/api
```

---

## 🎬 Seerr / Requests

### Seerr can't connect to Plex
- Verify Plex is running and accessible
- In Seerr, use the server IP (not `localhost`) since Plex is in `host` mode:
  - Address: `http://YOUR_SERVER_IP:32400`
- Verify your Plex token is valid in Seerr settings

### Seerr can't connect to Sonarr/Radarr
- Use Docker network addresses:
  - Sonarr: `http://172.19.0.6:8989`
  - Radarr: `http://172.19.0.5:7878`
- Verify the API keys for each service
- Test the connection with the "Test" button

### Requests are not sent to Sonarr/Radarr
- Verify quality profiles and root folders are configured in Seerr
- Verify Sonarr/Radarr are set as default servers in Seerr
- Check the logs:
  ```bash
  docker logs seerr --tail 30
  ```

### Seerr is inaccessible (port 5055)
```bash
docker ps | grep seerr
docker logs seerr --tail 20
```

### Seerr notifications are not working
- Check the configuration in Settings → Notifications
- Test each notification channel with the "Test" button

---

## 🧹 Cleanuparr

### Cleanuparr is not deleting files
- Verify Cleanuparr is connected to Radarr and Sonarr
- Check the cleanup rules in the WebUI (`http://YOUR_SERVER_IP:11011`)
- Verify the downloads volume is correctly mounted in docker-compose
- Check the logs:
  ```bash
  docker logs cleanuparr --tail 20
  ```

### Cleanuparr is inaccessible (port 11011)
- Verify the container is running:
  ```bash
  docker ps | grep cleanuparr
  ```
- Check the healthcheck:
  ```bash
  docker inspect cleanuparr --format='{{.State.Health.Status}}'
  ```
- Check the logs:
  ```bash
  docker logs cleanuparr --tail 20
  ```

### Cleanuparr is deleting files it shouldn't
- Review the cleanup rules in the WebUI
- Reduce the aggressiveness of rules or add exceptions
- Check Cleanuparr's history to see what was deleted

---

## 📊 Tautulli

### Tautulli doesn't see Plex activity
- Check the Plex connection in Settings → Plex Media Server
- The address must be the server IP (not `localhost`, since Tautulli is not in host mode)
- Port: `32400`
- Verify the Plex token is valid

### Tautulli notifications are not working
- Check the configuration in Settings → Notification Agents
- Test each agent with the "Test Notification" button
- Verify that triggers are enabled for each agent

### Tautulli shows incorrect or missing data
- Verify Tautulli can access Plex logs
- Reload libraries: Settings → Plex Media Server → Refresh Libraries
- If history is empty, import it: Settings → Import Plex Database

### Tautulli is inaccessible (port 8181)
```bash
docker ps | grep tautulli
docker logs tautulli --tail 20
curl -f http://localhost:8181/status
```

---

## 🐳 Portainer

### Unable to create the administrator account
Portainer automatically locks itself if the admin account is not created within the first few minutes.
- Restart the container: `docker restart portainer`
- Immediately access `http://YOUR_SERVER_IP:9000` to create the account
- If the problem persists, delete the data and start over:
  ```bash
  docker stop portainer
  rm -rf /app/portainer/config/*
  docker start portainer
  ```
  Then immediately access the interface to create the account.

### Portainer doesn't see the containers
- Verify that the Docker socket is properly mounted: `/var/run/docker.sock:/var/run/docker.sock`
- Check permissions on the socket: `ls -la /var/run/docker.sock`
- Check the logs: `docker logs portainer`
- Verify the endpoint is configured in Portainer: Environments → Local

### Unable to deploy a stack from Portainer
- Verify that the docker-compose file is valid (no YAML syntax errors)
- Validate the syntax:
  ```bash
  docker compose -f /opt/hub_multimedia/docker_compose.yml config --quiet
  ```
- Verify that all `.env` variables are filled in
- Check the logs in Portainer: container → Logs

### Portainer is inaccessible (port 9000)
```bash
docker ps | grep portainer
docker logs portainer --tail 20
```

---

## 🐳 General Docker

### A container keeps restarting
```bash
docker logs <container_name>
docker inspect <container_name> --format='{{.State.Status}} - Restarts: {{.RestartCount}}'
```
Common causes:
- Incorrect permissions on volumes
- Missing environment variable in `.env`
- Port already in use by another process
- Insufficient disk space

### Check all container status
```bash
cd /opt/hub_multimedia && docker compose ps
```

### Check the health of all containers
```bash
docker ps --format "table {{.Names}}\t{{.Status}}"
```

### Restart everything cleanly
```bash
cd /opt/hub_multimedia
docker compose down
docker compose up -d
```

### Restart a single service and its dependencies
```bash
cd /opt/hub_multimedia
docker compose up -d --force-recreate <service_name>
```

### Free up disk space
```bash
docker system prune -af
```
> ⚠️ Removes all unused images, volumes, and caches.

To see Docker disk usage:
```bash
docker system df
```

### A container shows "unhealthy"
- Check the healthcheck results:
  ```bash
  docker inspect <container_name> --format='{{json .State.Health}}' | python3 -m json.tool
  ```
- Verify the service inside the container responds:
  ```bash
  docker exec <container_name> curl -f http://localhost:<port>/ping
  ```
- If the container is unhealthy but works, the healthcheck may be misconfigured

### See real-time resource consumption
```bash
docker stats
```

### Limit Docker log size
If logs grow too large, configure rotation in `/etc/docker/daemon.json`:
```json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  }
}
```
Then restart Docker: `sudo systemctl restart docker`

---

## 📁 Permissions

### File permission errors
- Verify that PUID and PGID are correct in the `.env` (must match the user who owns the files)
- Check your current UID/GID:
  ```bash
  id
  ```
- Reapply permissions:
  ```bash
  sudo chown -R 1000:1000 /app
  sudo chown -R 1000:1000 /data
  sudo chown -R 1000:1000 /data2
  ```

### A service can't write to its configuration folder
- Check permissions on the `/app/<service>/config` folder:
  ```bash
  ls -la /app/<service>/config/
  ```
- Fix if needed:
  ```bash
  sudo chown -R 1000:1000 /app/<service>/config
  sudo chmod -R 755 /app/<service>/config
  ```

### Downloaded files have wrong permissions
- Check the PUID/PGID values in each service of the docker-compose
- All services should use the same PUID/PGID to avoid conflicts
- Check the umask in qBittorrent: Tools → Options → Downloads → Default Save Path

---

## 🌐 Network

### IP address conflict
If a container refuses to start with an IP error:
- Verify that no other Docker stack is using the subnet `172.19.0.0/24`
- List networks: `docker network ls`
- Inspect a network: `docker network inspect network_hub_multimedia`
- If there's a conflict, remove the orphan network:
  ```bash
  docker network rm <network_name>
  ```

### A port is already in use
If a container refuses to start with "port already in use":
- Identify the process using the port:
  ```bash
  sudo ss -tlnp | grep <port>
  ```
- Stop the process or change the port in docker-compose

### Containers can't see each other
- Verify containers are on the same Docker network:
  ```bash
  docker network inspect network_hub_multimedia
  ```
- Test connectivity:
  ```bash
  docker exec sonarr ping -c 2 172.19.0.5
  ```
- Exception: Plex is in `host` mode and is not on the Docker network. Other containers must use the server IP to reach it.

### DNS resolution issues in containers
- Check the DNS in a container:
  ```bash
  docker exec <container_name> cat /etc/resolv.conf
  ```
- If resolution fails, add custom DNS in docker-compose:
  ```yaml
  dns:
    - 1.1.1.1
    - 8.8.8.8
  ```

---

## 💾 Backup & Restore

### Create a backup
The automatic backup script is available:
```bash
sudo bash /opt/hub_multimedia/auto_deploy/save_hub.sh
```
Backups are stored in `/opt/backups/hub_multimedia/`.

### Restore a backup
```bash
sudo bash /opt/hub_multimedia/not_check_in_test/restore_hub.sh
```
The script displays available backups and lets you choose which one to restore.

> ⚠️ Restoring overwrites current configurations. Make sure to create a backup first if needed.

### Backup fails
- Check available disk space in `/opt/backups/`:
  ```bash
  df -h /opt/backups/
  ```
- Check permissions: the script must be run as `root` (or with `sudo`)
- Verify the backup directory exists:
  ```bash
  sudo mkdir -p /opt/backups/hub_multimedia
  ```

### Automate backups with cron
```bash
sudo crontab -e
```
Add this line for a daily backup at 3 AM:
```
0 3 * * * /bin/bash /opt/hub_multimedia/auto_deploy/save_hub.sh >> /var/log/hub_backup.log 2>&1
```

---

## 🔄 Updating the Hub

### Update all containers
```bash
sudo bash /opt/hub_multimedia/not_check_in_test/update_hub.sh
```
The script automatically:
1. Creates a preventive backup
2. Downloads new images (`docker compose pull`)
3. Redeploys containers
4. Cleans up old images

### Update a single service
```bash
cd /opt/hub_multimedia
docker compose pull <service_name>
docker compose up -d <service_name>
```

### A service no longer works after an update
- Check the logs to identify the error:
  ```bash
  docker logs <service_name> --tail 50
  ```
- Check if a database migration is needed (common with Sonarr/Radarr/Prowlarr)
- As a last resort, restore the backup made before the update:
  ```bash
  sudo bash /opt/hub_multimedia/not_check_in_test/restore_hub.sh
  ```

---

## 📝 Logs & Advanced Debugging

### Watch logs in real time
```bash
docker logs -f <container_name>
```

### Watch logs for all containers simultaneously
```bash
cd /opt/hub_multimedia && docker compose logs -f --tail 20
```

### Filter logs by error level
```bash
docker logs <container_name> 2>&1 | grep -i "error\|fatal\|critical"
```

### Enter a container for debugging
```bash
docker exec -it <container_name> /bin/bash
```
> If `/bin/bash` is not available, try `/bin/sh`.

### Inspect the full configuration of a container
```bash
docker inspect <container_name>
```

### Check environment variables of a container
```bash
docker exec <container_name> env
```

### Check network connectivity from a container
```bash
docker exec <container_name> wget -qO- https://ipinfo.io
```

---

## 🎵 Lidarr / Music

### Lidarr starts but WebUI is not accessible
- Check the correct IP address: `http://172.19.0.7:8686`
- Lidarr runs on port 8686. Verify its status:
  ```bash
  docker ps | grep lidarr
  ```
- If the container is `unhealthy`, check the logs:
  ```bash
  docker logs lidarr --tail 30
  ```

### Lidarr can't find artists/albums
- Verify Prowlarr is connected and synced with Lidarr
- Configure Prowlarr as the indexer source in Lidarr: Settings → Apps
- To download music, set up a download client (qBittorrent) in Lidarr settings

### Music files are not detected
- Verify `/data` and `/data2` folders are accessible within Lidarr
- Add a Root Folder pointing to `/data/music` or `/data2/music`
- Check permissions on music files:
  ```bash
  ls -la /data/music
  ```

---

## 🎬 Seerr / Requests
