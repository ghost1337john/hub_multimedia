# 📊 Tautulli Configuration Tutorial (Simplified Version)

Tautulli is a tool for monitoring your Plex server activity and viewing detailed statistics.  
This guide covers only the main steps, without going into technical details.  
For advanced configuration, please refer to the official documentation:  
👉 https://tautulli.com/

---

## 1️⃣ Access Tautulli

Once Tautulli is installed, open the interface at: http://YOUR_SERVER_IP:8181

On first launch, follow the quick setup wizard.

---

## 2️⃣ Connect Tautulli to Plex

The wizard will ask you to connect your Plex server.  
Simply enter:

- Your Plex server address  
- The port (default: 32400)  
- Your Plex credentials (login via Plex account)  

Once connected, select the Plex server you want to monitor.

---

## 3️⃣ Configure Notifications (Optional)

In: Settings → Notification Agents

You can set up notifications to be alerted for certain events:

- Media play / pause / stop  
- New content added  
- Server issues  

Multiple agents are available (Discord, Telegram, Email, etc.).  
Enter the connection information specific to each agent.

---

## 4️⃣ View Activity and Statistics

From the dashboard, you can view:

- Current streams in real time  
- Playback history  
- Statistics by user, library, or media  

This information is available directly without additional configuration.

---

## 5️⃣ Finalize and Test

Once the items are configured:

- Verify that Plex activity shows correctly on the dashboard  
- Use **Test Notification** to verify your notification agents  
- Click **Save** to save

---

## 📚 Going Further

This intentionally simplified guide does not cover:

- Automatic newsletters  
- Advanced monitoring settings  
- Custom scripts  
- Statistics export  
- Advanced integrations with Plex  

For a complete and always up-to-date configuration:  
👉 https://github.com/Tautulli/Tautulli/wiki
