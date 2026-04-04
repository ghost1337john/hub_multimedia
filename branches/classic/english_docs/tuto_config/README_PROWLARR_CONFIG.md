# 🧭 Prowlarr Configuration Tutorial (Simplified Version)

Prowlarr is a centralized indexer manager designed to work with Sonarr, Radarr, and other applications in the *Arr ecosystem.  
This guide covers only the main steps, without going into technical details.  
For advanced configuration, please refer to the official documentation:  
👉 https://wiki.servarr.com/prowlarr

---

## 1️⃣ Access Prowlarr

Once Prowlarr is installed, open the interface at: http://YOUR_SERVER_IP:9696


On first launch, simply configure your administrator account if prompted.

---

## 2️⃣ Add Indexers

In:

Indexers → Add Indexer


…add the indexers of your choice.

Each indexer may require:

- An API key  
- A username  
- A password  
- A specific URL  

Detailed instructions are available in the official documentation or on each indexer's website.

---

## 3️⃣ Connect Prowlarr to Sonarr and Radarr

In:

Settings → Apps


Add your *Arr applications (Sonarr, Radarr, etc.) by providing:

- The service address  
- The port  
- The API key  

Prowlarr will automatically synchronize indexers with these applications.

---

## 4️⃣ Configure Categories (Optional)

In:

Indexers → (Select an indexer) → Categories


You can adjust categories to match your preferences.  
Default values are suitable in most cases.

---

## 5️⃣ Finalize and Test

Once the items are configured:

- Use **Test** to verify connections  
- Click **Save** to save  
- Verify that indexers appear correctly in Sonarr and Radarr

---

## 📚 Going Further

This intentionally simplified guide does not cover:

- Proxies  
- Advanced private indexers  
- Ratio settings  
- Custom filters  
- Complex integrations with other services  

For a complete and always up-to-date configuration:  
👉 https://wiki.servarr.com/prowlarr
