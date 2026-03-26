# 💬 Bazarr Configuration Tutorial (Simplified Version)

Bazarr is a tool for automatically managing subtitles for your movies and TV series.  
This guide covers only the main steps, without going into technical details.  
For advanced configuration, please refer to the official documentation:  
👉 https://www.bazarr.media/

---

## 1️⃣ Access Bazarr
 
Once Bazarr is installed, open the interface at: http://YOUR_SERVER_IP:6767

On first launch, follow the quick setup wizard.

---

## 2️⃣ Connect Bazarr to Sonarr and Radarr

In:

Settings → Sonarr
Settings → Radarr

…add your existing instances by providing:

- The service address  
- The port  
- The API key  

Advanced options are detailed in the official documentation.

---

## 3️⃣ Set Subtitle Languages

In: Settings → Languages


Select the languages you want to use for your subtitles.  
You can enable multiple languages according to your needs.

---

## 4️⃣ Configure Subtitle Providers

In: Settings → Providers


Enable the providers you want to use.  
Some require creating an account or an API key.  
Specific instructions are available on the official website.

---

## 5️⃣ Finalize and Test

Once the items are configured:

- Use **Test** to verify connections  
- Click **Save** to save

---

## 📚 Going Further

This intentionally simplified guide does not cover:

- Advanced detection settings  
- Quality filters  
- Replacement rules  
- Synchronization settings  
- Advanced integrations with Sonarr and Radarr  

For a complete and always up-to-date configuration:  
👉 https://wiki.bazarr.media/
