# 🐳 Portainer Configuration Tutorial (Simplified Version)

Portainer is a graphical interface for managing, monitoring, and administering your Docker containers from a browser.  
This guide covers only the main steps, without going into technical details.  
For advanced configuration, please refer to the official documentation:  
👉 https://docs.portainer.io/

---

## 1️⃣ Access Portainer

Once Portainer is installed, open the interface at: http://YOUR_SERVER_IP:9000

On first launch, you will need to create an administrator account.

---

## 2️⃣ Create the Administrator Account

Enter:

- A username (default: `admin`)  
- A secure password (minimum 12 characters)  

Click **Create user** to confirm.

> ⚠️ If you wait too long before creating the account, Portainer will lock itself for security. Restart the container to start over.

---

## 3️⃣ Connect the Docker Environment

After creating the account, Portainer will prompt you to connect an environment.

Select **Docker** → **Connect via socket** (already configured via docker-compose).

Click **Connect** to finalize.

---

## 4️⃣ Manage Your Containers

From the left menu, access:

- **Containers**: view the status of all your containers (Running, Stopped, etc.)  
- **Stacks**: manage your docker-compose files directly from the interface  
- **Images**: view downloaded Docker images  
- **Volumes**: check persistent volumes  
- **Networks**: view Docker networks  

You can start, stop, restart, or delete a container with a single click.

---

## 5️⃣ Deploy a Stack (docker-compose)

In: **Stacks** → **Add Stack**

- Give your stack a name (e.g., `hub_multimedia`)  
- Paste your `docker_compose.yml` content in the Web editor  
- Add your environment variables via **Add an environment file**  
- Click **Deploy the stack**  

---

## 6️⃣ View Container Logs

To diagnose a problem:

- Go to **Containers**  
- Click on the name of the relevant container  
- Click **Logs** to see the container's messages in real time  

---

## 7️⃣ Finalize and Test

Once connected to your Docker environment:

- Verify that all hub containers appear in the list  
- Test restarting a container from the interface  
- View logs to ensure everything is working  

---

## 📚 Going Further

This intentionally simplified guide does not cover:

- Multi-environment management (multiple servers)  
- Application templates  
- User and role management  
- Private Docker registries  
- Edge Agents for remote management  

For a complete and always up-to-date configuration:  
👉 https://docs.portainer.io/
