# 📺 Sonarr Configuration Tutorial (Simplified Version)

Sonarr is a tool for automating the management and organization of your TV series.  
This guide covers only the main steps, without going into technical details.  
For advanced configuration, please refer to the official documentation:  
👉 https://sonarr.tv

---

## 1️⃣ Access Sonarr

Once Sonarr is installed, open the interface at: http://YOUR_SERVER_IP:8989


On first launch, simply create your administrator account.

---

## 2️⃣ Set Up Main Folders

Sonarr needs to know the locations of:

- Your TV series  
- Files being processed  

These settings are configured in:

Settings → Media Management
Settings → Root Folders


The exact paths depend on your own organization.

---

## 3️⃣ Add a Download Client

In: Settings → Download Clients


…you can add a compatible external service (e.g., qBittorrent).

Enter only the necessary connection information (address, port, credentials).  
Advanced options are detailed in the official documentation.

---

## 4️⃣ Finalize and Test

Once the items are configured:

- Use **Test** to verify the connection  
- Click **Save** to save

---

## 📚 Going Further

This intentionally simplified guide does not cover:

- Advanced Media Management settings  
- Quality profiles  
- Indexers  
- Automations  
- Renaming  
- Integrations with Radarr, Prowlarr, Bazarr, etc.

For a complete and always up-to-date configuration:  
👉 https://wiki.servarr.com/sonarr
