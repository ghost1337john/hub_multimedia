# ❓ FAQ & Troubleshooting — Multimedia Hub

---

## 🔐 VPN / Gluetun

### The VPN won't connect
- Check that your WireGuard key is correct in the `.env`
- Verify that your ProtonVPN account supports port forwarding (paid plan required)
- Check the logs: `docker logs gluetun`
- Verify that the device `/dev/net/tun` exists on your server

### qBittorrent / Prowlarr / FlareSolverr are inaccessible
These services go through Gluetun (`network_mode: service:gluetun`). If the VPN is down, they are inaccessible.
- Check Gluetun status: `docker ps | grep gluetun`
- Restart the VPN: `docker restart gluetun`

### Port forwarding is not working
- Verify that you added `+pmp` at the end of your `OPENVPN_USER` in the `.env`
- Verify that `VPN_PORT_FORWARDING=on` is set in the docker-compose

---

## 📺 Plex

### Plex is not found on the local network
- Plex uses `network_mode: host`, it should be directly accessible via the server IP on port 32400
- Check that port 32400 is not blocked by a firewall: `sudo ufw status`
- Check the logs: `docker logs plex`

### Plex can't see my files
- Verify that volumes `/data` and `/data2` are correctly mounted in fstab
- Check permissions: `ls -la /data/` (should belong to 1000:1000)
- In Plex, add libraries pointing to `/movies` or `/series` (the paths inside the container)

### The claim token has expired
- Get a new token at https://plex.tv/claim
- Add it in the docker-compose: `PLEX_CLAIM=claim-xxxxx`
- Redeploy: `docker compose up -d plex`

---

## 🧲 qBittorrent

### The default password doesn't work
On first launch, qBittorrent generates a random password.
- Check the logs: `docker logs qbittorrent`
- Look for the line containing `temporary password`

### Downloads are slow
- Verify that VPN port forwarding is active: `docker logs gluetun | grep "port forwarded"`
- Check the connection settings in qBittorrent WebUI

---

## 🧭 Prowlarr / Indexers

### Indexers fail with Cloudflare errors
- Verify that FlareSolverr is running: `docker ps | grep flaresolverr`
- In Prowlarr, configure FlareSolverr as a proxy (Settings → Indexers → Add FlareSolverr tag)

### Prowlarr doesn't sync with Sonarr/Radarr
- Check the API keys in Prowlarr (Settings → Apps)
- Addresses must use the Docker network IPs (e.g., `172.19.0.6` for Sonarr)

---

## 💬 Bazarr / Subtitles

### Bazarr can't find subtitles
- Verify that providers are configured (Settings → Providers)
- Some providers require an account (OpenSubtitles, Addic7ed)
- Check the connection with Sonarr/Radarr (Settings → Sonarr / Settings → Radarr)

---

## 📊 Tautulli

### Tautulli doesn't see Plex activity
- Check the Plex connection in Settings → Plex Media Server
- The address must be the server IP (not localhost, since Tautulli is not in host mode)
- Port: 32400

---

## 🐳 Portainer

### Unable to create the administrator account
Portainer automatically locks itself if the admin account is not created within the first few minutes.
- Restart the container: `docker restart portainer`
- Immediately access `http://YOUR_SERVER_IP:9000` to create the account

### Portainer doesn't see the containers
- Verify that the Docker socket is properly mounted: `/var/run/docker.sock:/var/run/docker.sock`
- Check permissions on the socket: `ls -la /var/run/docker.sock`
- Check the logs: `docker logs portainer`

### Unable to deploy a stack from Portainer
- Verify that the docker-compose file is valid (no YAML syntax errors)
- Verify that all `.env` variables are filled in
- Check the logs in Portainer: container → Logs

---

## 🐳 General Docker

### A container keeps restarting
```bash
docker logs <container_name>
docker inspect <container_name> | grep -i status
```

### Check all container status
```bash
cd /opt/hub_multimedia && docker compose ps
```

### Restart everything cleanly
```bash
cd /opt/hub_multimedia
docker compose down
docker compose up -d
```

### Free up disk space
```bash
docker system prune -af
```
> ⚠️ Removes all unused images, volumes, and caches.

---

## 📁 Permissions

### File permission errors
- Verify that PUID and PGID are correct in the `.env` (must match the user who owns the files)
- Reapply permissions:
```bash
sudo chown -R 1000:1000 /app
sudo chown -R 1000:1000 /data
sudo chown -R 1000:1000 /data2
```

---

## 🌐 Network

### IP address conflict
If a container refuses to start with an IP error:
- Verify that no other Docker stack is using the subnet `172.19.0.0/24`
- List networks: `docker network ls`
- Inspect a network: `docker network inspect network_hub_multimedia`
