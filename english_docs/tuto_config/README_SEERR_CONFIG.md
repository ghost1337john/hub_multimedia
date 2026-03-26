# ⭐ Seerr Configuration Tutorial (Simplified Version)

Seerr is an interface that allows users to request movies and TV series, and to track the status of their addition to your library.  
This guide covers only the main steps, without going into technical details.  
For advanced configuration, please refer to the official documentation:  
👉 https://docs.seerr.dev/

---

## 1️⃣ Access Seerr

Once Seerr is installed, open the interface at: http://YOUR_SERVER_IP:5055


On first launch, follow the quick setup wizard and create your administrator account.

---

## 2️⃣ Connect Seerr to Radarr and Sonarr

In:

Settings → Services


Add your Radarr and Sonarr instances by providing:

- The service address  
- The port  
- The API key  

Advanced options are detailed in the official documentation.

---

## 3️⃣ Configure Authentication

In:

Settings → Users


You can:

- Enable authentication via an external provider (e.g., Plex, Jellyfin, Emby)  
- Manage users and their permissions  

Authentication methods are explained in detail in the official documentation.

---

## 4️⃣ Set Permissions and Roles

In:

Settings → Permissions


You can define:

- Allowed actions for users  
- Request limits  
- Custom roles  

These settings depend on your organization and your needs.

---

## 5️⃣ Finalize and Test

Once the items are configured:

- Verify the connection to Radarr and Sonarr via **Test**  
- Save with **Save**  
- Make a test request to validate functionality

---

## 📚 Going Further

This intentionally simplified guide does not cover:

- Notifications  
- Advanced integrations  
- Webhooks  
- Quota settings  
- Interface customizations  

For a complete and always up-to-date configuration:  
👉 https://docs.seerr.dev/
