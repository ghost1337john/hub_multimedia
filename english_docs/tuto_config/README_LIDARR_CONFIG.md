# 🎵 Lidarr Configuration Tutorial (Simplified Version)

Lidarr is a tool that automates the management and organization of your music library.  
This guide covers only the main steps, without entering into technical details.  
For any advanced configuration, please refer to the official documentation:  
👉 https://lidarr.audio/

---

## 1️⃣ Access Lidarr

Once Lidarr is installed, open the interface via: http://YOUR_SERVER_IP:8686

On first access, you will be guided through the setup wizard.

---

## 2️⃣ Set Up Root Folders

Lidarr needs to know the locations of:

- Your music library  
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

You can add compatible indexers to allow Lidarr to search for information about artists and albums.  
Specific configurations depend on your sources and are explained in the official documentation.

---

## 5️⃣ Add Artists and Albums

Once configured, you can:

1. Search for artists via `Add Artists`
2. Select the albums you want to download
3. Lidarr will automatically handle the rest

---

## 6️⃣ Finalize and Test

Once the elements are configured:

- Use **Test** to verify connections  
- Click **Save** to save

---

## 📚 Going Further

This deliberately simplified guide does not cover:

- Quality profiles  
- Import rules  
- Advanced Media Management settings  
- Automations  
- Integration with Prowlarr, etc.

For complete and always up-to-date configuration:  
👉 https://wiki.servarr.com/lidarr
