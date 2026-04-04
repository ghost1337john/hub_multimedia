# 🎬 Radarr Configuration Tutorial (Simplified Version)

Radarr is a tool for automating the management and organization of your movies.  
This guide covers only the main steps, without going into technical details.  
For advanced configuration, please refer to the official documentation:  
👉 https://radarr.video/

---

## 1️⃣ Access Radarr

Once Radarr is installed, open the interface at: http://YOUR_SERVER_IP:7878

On first launch, simply create your administrator account if prompted.

---

## 2️⃣ Set Up Main Folders

Radarr needs to know the locations of:

- Your movies  
- Files being processed  

These settings are configured in:

Settings → Media Management
Settings → Root Folders

The exact paths depend on your own organization.

---

## 3️⃣ Add a Download Client

In:

Settings → Download Clients


…you can add a compatible external service (e.g., qBittorrent).

Enter only the necessary connection information (address, port, credentials).  
Advanced options are detailed in the official documentation.

---

## 4️⃣ Configure Indexers (Optional)

In:

Settings → Indexers

You can add compatible indexers to allow Radarr to search for movie information.  
Specific configurations depend on your sources and are explained in the official documentation.

---

## 5️⃣ Finalize and Test

Once the items are configured:

- Use **Test** to verify connections  
- Click **Save** to save

---

## 📚 Going Further

This intentionally simplified guide does not cover:

- Quality profiles  
- Import rules  
- Advanced Media Management settings  
- Automations  
- Integrations with Sonarr, Prowlarr, Bazarr, etc.

For a complete and always up-to-date configuration:  
👉 https://wiki.servarr.com/radarr
