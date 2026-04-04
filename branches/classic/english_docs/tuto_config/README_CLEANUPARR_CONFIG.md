# 🧹 CleanUpArr Configuration Tutorial (Simplified Version)

CleanUpArr is a tool for keeping your multimedia library clean and consistent by automating certain cleanup tasks.  
This guide covers only the main steps, without going into technical details.  
For advanced configuration, please refer to the official project documentation.

https://github.com/cleanuparr/cleanuparr

---

## 1️⃣ Access CleanUpArr

Once CleanUpArr is installed, open the interface at the address configured in your environment.  
Depending on your installation, it may look like: http://YOUR_SERVER_IP:PORT

---

## 2️⃣ Connect CleanUpArr to Your *Arr Services

In:

Settings → Services


Add the applications you want to integrate (Sonarr, Radarr, etc.) by providing:

- The service address  
- The port  
- The API key  

CleanUpArr will use these connections to analyze and clean up the relevant items.

---

## 3️⃣ Configure Cleanup Rules

In:

Settings → Queue Cleaner
Settings → Download Cleaner

You can enable or disable the rules offered by CleanUpArr.  
Each rule can be adjusted according to your preferences.  
Detailed explanations are available in the official documentation.

---

## 4️⃣ Run an Analysis

In:

Dashboard → Jobs → Run Now

You can run a manual analysis to check the state of your library.  
The proposed actions will depend on the enabled rules.

---

## 5️⃣ Finalize and Automate

Once configuration is complete:

- Verify that services are properly connected  
- Enable automation if desired  
- Save with **Save**

---

## 📚 Going Further

This intentionally simplified guide does not cover:

- Advanced rules  
- Complex automatic actions  
- Additional external integrations  
- Log or diagnostic settings  

For a complete and always up-to-date configuration, refer to the official project documentation.
https://github.com/cleanuparr/cleanuparr
