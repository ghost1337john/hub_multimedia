# 📺 Plex Configuration Tutorial (Simplified Version)

Plex is a media server that centralizes, organizes, and streams your movies, series, and music on all your devices.  
This guide covers only the main steps, without going into technical details.  
For advanced configuration, please refer to the official documentation:  
👉 https://support.plex.tv/

---

## 1️⃣ Access Plex

Once Plex is installed, open the interface at: http://YOUR_SERVER_IP:32400/web

On first launch, you will be redirected to the Plex login page.

---

## 2️⃣ Create or Connect a Plex Account

- Log in with your Plex account (or create one at https://plex.tv)  
- Accept the terms of use  
- Plex will automatically detect the local server  

> ⚠️ If the server is not detected, verify that port 32400 is not blocked by a firewall.

---

## 3️⃣ Name the Server

The setup wizard will prompt you to name your Plex server.

- Choose an easily identifiable name (e.g., `SRV-PLEX`)
- Check or uncheck the **Allow remote access** option according to your needs

---

## 4️⃣ Add Libraries

This is the main step. Add your libraries by pointing to the folders mounted in the container:

| Library Type   | Path in Container |
|----------------|-------------------|
| Movies         | `/movies`         |
| TV Series      | `/series`         |

For each library:

- Click **Add a Library**  
- Select the type (Movies, TV Shows, Music, etc.)  
- Browse folders and select the corresponding path  
- Confirm  

> 💡 The paths `/movies` and `/series` correspond to the `/data` and `/data2` volumes mounted in the docker-compose.

---

## 5️⃣ Configure Language and Agents

In: Settings → Libraries → (your library) → Manage

- Set the preferred language for metadata (e.g., English)  
- Plex will automatically download posters, summaries, and information  

---

## 6️⃣ Configure Remote Access (Optional)

In: Settings → Remote Access

- Enable remote access to access Plex from outside your network  
- Plex will attempt to automatically configure port 32400  
- If necessary, configure port forwarding on your router  

> ⚠️ Plex uses `network_mode: host` in the docker-compose, so ports are directly exposed on the server.

---

## 7️⃣ Invite Users (Optional)

In: Settings → Users & Sharing

- Click **Invite a Friend**  
- Enter the email address or Plex username  
- Choose the libraries to share  
- The user will receive an invitation by email  

---

## 8️⃣ Finalize and Test

Once libraries are added:

- Run a library scan: Libraries → (your library) → Scan Library Files  
- Verify that movies and series appear with the correct metadata  
- Test playback on a device (browser, TV, mobile)  
- Verify that Tautulli detects the activity if configured  

---

## 📚 Going Further

This intentionally simplified guide does not cover:

- Hardware transcoding configuration (GPU)  
- Embedded subtitles and playback settings  
- Playlists and collections  
- Server performance optimization  
- Plex Pass and premium features  

For a complete and always up-to-date configuration:  
👉 https://support.plex.tv/articles/
