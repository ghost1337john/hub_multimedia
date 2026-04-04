# 💾 Setting Up Automatic Backup for the Multimedia Hub

This guide explains how to use and automate the `save_hub.sh` script to back up all multimedia hub container configurations on Debian.

---

## 🧩 Prerequisites

- The multimedia hub deployed and running (via autoscript or manually)
- **Root** or **sudo** access
- Containers configured via their respective WebUIs

---

## 📋 What the Script Backs Up

The script archives configurations of the **11 containers**:

| Container     | Backed Up Folder                 |
|---------------|----------------------------------|
| Gluetun       | `/app/gluetun/config`            |
| qBittorrent   | `/app/qbittorrent/config`        |
| Prowlarr      | `/app/prowlarr/config`           |
| Sonarr        | `/app/sonarr/config`             |
| Radarr        | `/app/radarr/config`             |
| Bazarr        | `/app/bazarr/config`             |
| Seerr         | `/app/seerr/config`              |
| FlareSolverr  | `/app/flaresolverr/config`       |
| Cleanuparr    | `/app/cleanuparr/config`         |
| Tautulli      | `/app/tautulli/config`           |
| Plex          | `/app/plex/config`               |

It also backs up `docker-compose.yml` and `.env` from `/opt/hub_multimedia/`.

---

## 🚀 Manual Usage

```bash
sudo bash /path/to/auto_deploy/save_hub.sh
```

The script will:
1. Check root permissions
2. Verify the existence of each configuration folder
3. Gracefully stop containers
4. Create a timestamped `.tar.gz` archive in `/opt/backups/hub_multimedia/`
5. Restart containers
6. Delete old backups beyond the 5 most recent

---

## ⏰ Automation with Cron

To schedule an automatic backup, add a cron task:

```bash
sudo crontab -e
```

Scheduling examples:

**Every day at 3 AM:**
```
0 3 * * * /path/to/auto_deploy/save_hub.sh >> /var/log/save_hub.log 2>&1
```

**Every Sunday at 4 AM:**
```
0 4 * * 0 /path/to/auto_deploy/save_hub.sh >> /var/log/save_hub.log 2>&1
```

> 💡 Replace `/path/to/` with the actual path of the repository on your server (e.g., `/home/plex/hub_multimedia/`).

---

## 📂 Backup Location

Archives are stored in:

```
/opt/backups/hub_multimedia/
```

Named in the format: `backup_YYYY-MM-DD_HH-MM.tar.gz`

Only the **5 most recent** backups are kept (configurable via `MAX_BACKUPS` in the script).

---

## 🔄 Restoring a Backup

In case of a problem, to restore a backup:

```bash
# 1. Stop containers
cd /opt/hub_multimedia
sudo docker compose down

# 2. Extract the archive (from root /)
sudo tar -xzf /opt/backups/hub_multimedia/backup_YYYY-MM-DD_HH-MM.tar.gz -C /

# 3. Restart containers
sudo docker compose up -d
```

> ⚠️ Replace `YYYY-MM-DD_HH-MM` with the date of the desired backup.

---

## ⚠️ Important Notes

- The script **stops containers** during the backup to ensure file consistency. Services will therefore be temporarily unavailable.
- Schedule the cron backup during off-peak hours to minimize impact.
- **Media data** (movies, TV series) is **not backed up** by this script. Only configurations are.
- Consider externalizing archives (NAS, remote storage) for complete protection.
