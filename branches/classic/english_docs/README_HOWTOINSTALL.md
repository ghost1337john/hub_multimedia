## 🛠️ Prerequisites

Before installing this multimedia hub, make sure you have the following:

### 🔧 Hardware & System
- A server or virtual machine capable of running Docker  
- Linux recommended (Debian, Ubuntu)
- Administrator access (sudo) 
- Minimum configuration:
  - CPU: 4 cores
  - RAM: 8 GB
  - Storage: 64 GB SSD
- Recommended configuration (comfortable):
  - CPU: 6 cores
  - RAM: 16 GB
  - Storage: 128 GB SSD

> 💡 **Note on Plex**: without hardware transcoding (GPU), each transcoded stream can consume 1–2 CPU cores.  
> With **Direct Play** (no transcoding), 4 cores / 8 GB is sufficient.  
> With **transcoding** for 2–3 simultaneous users, plan for 6 cores / 16 GB or a compatible GPU (Intel QuickSync, NVIDIA).

- A NAS that stores your files (Series/Movies)
- NAS shares configured for automatic mounting via FSTAB
- A paid ProtonVPN account

### 📦 Required Software
- **Docker**  
- **Docker Compose** (v2 or higher)
- **Portainer** (Container Management WebUI)

### 🔐 VPN & Network
- A **ProtonVPN** account (port forwarding compatible)
- A valid **WireGuard** key  

### 📁 Recommended Directory Structure
Organize your folders to store container configs on your server as follows:

/app/
  ├── gluetun/config
  ├── qbittorrent/config
  ├── prowlarr/config
  ├── sonarr/config
  ├── radarr/config
  ├── lidarr/config
  ├── cleanuparr/config
  ├── bazarr/config
  ├── seerr/config
  ├── flaresolverr/config
  ├── plex/config
  ├── tautulli/config
  └── portainer/config

#Retrieve the PUID and PGID of your user

The **PUID** (User ID) and **PGID** (Group ID) values allow Docker containers to run with the same permissions as your user on the host system. To retrieve them, run the `id` command in your terminal:

```bash
id
```

Expected output:
```
uid=1000(plex) gid=1000(plex)
groupes=1000(plex),24(cdrom),25(floppy),27(sudo),29(audio),30(dip),44(video),46(plu
gdev),100(users),101(netdev)
```

- **PUID** = the value after `uid=` → here `1000`
- **PGID** = the value after `gid=` → here `1000`

> 💡 Enter these values in your `.env` file so that containers have the correct permissions on your files.
#Create all directories in a single command:
```
sudo mkdir -p \
  /app/gluetun/config \
  /app/qbittorrent/config \
  /app/prowlarr/config \
  /app/sonarr/config \
  /app/radarr/config \
    /app/lidarr/config \
  /app/cleanuparr/config \
  /app/bazarr/config \
  | Lidarr        | http://serverip:8686       |
  /app/seerr/config \
  /app/flaresolverr/config \
  /app/plex/config \
  /app/tautulli/config \
  /app/portainer/config \

sudo mkdir /data
```
#Assign permissions on the directories 
```
sudo chown -R 1000:1000 /app
sudo chown -R 1000:1000 /data
```

### 📁 NAS Mount Points Relative to the Script
Organize your mount points on your server as follows:

/data/
  ├── films 
  ├── series
  └── qbittorrent/
        └── downloads/

### 🔑 `.env` File
Create the `.env` file at the project root with the ProtonVPN information retrieved as follows:

For OpenVPN, go to the Account section and copy your username and password.
NOTE: FOR PORT FORWARDING TO WORK, YOU MUST ADD "+pmp" AT THE END OF YOUR USERNAME IN THE .env FILE.

<img width="1055" height="738" alt="image" src="https://github.com/user-attachments/assets/2b364b33-b5cc-4d03-8619-dd9c0b8f0363" />

For WireGuard, go to the Downloads section and create a new WireGuard configuration.
Select Router, no filtering, and "NAT‑PMP (Port Forwarding)". Deselect VPN
Accelerator. When you click Create, a window will display the configuration. Copy the
PrivateKey.

<img width="1040" height="851" alt="image" src="https://github.com/user-attachments/assets/21c5f167-0c1d-4723-88b5-b6bbf737a88a" />

Example file with the information: 

```
PUID=1000
PGID=1000
TZ=Europe/Paris

MEDIA_DIR=/data

OPENVPN_USER=kokorasta695
OPENVPN_PASSWORD=rgijo7r8g7r@
WIREGUARD_PRIVATE_KEY=aeztgéerzoi7894949
SERVER_COUNTRIES=Spain,Portugal
```

---

## 🚀 Installation with Docker

### 1️⃣ Clone the `classic` branch on your Linux machine in a working directory and navigate into it (e.g., /home/$user/docker) 

```bash
git clone --branch classic --single-branch https://github.com/ghost1337john/hub_multimedia.git
cd hub_multimedia/sources
```

### 2️⃣ Configure the `.env` file as explained above 

- Enter your VPN credentials
- Verify the volume paths
- Adjust `MEDIA_DIR` according to your storage

### 3️⃣ Launch the environment

```bash
docker compose up -d
```

### 4️⃣ Verify everything is working

```bash
docker compose ps
```

Services should appear as **Up**.

---
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## 

## 🐳 Installation via Portainer (no command line)
This method allows you to install the entire multimedia hub directly from Portainer, without using Docker on the command line.

🧭 1. Access Portainer
Open your browser

Go to your Portainer address:
http://YOUR_SERVER_IP:9000

Log in with your administrator account

📁 2. Prepare the required folders

Before deploying the stack, create the prerequisite folders on your server.

🧩 3. Create the stack in Portainer
In the left menu, click on Stacks

Click on Add Stack

Give your stack a name, for example:
hub_multimedia

Paste your docker-compose.yml file in the Web editor field

🔐 4. Add the .env file
Still on the stack creation page:

Scroll down to the Environment variables section

Click on Add an environment file

Paste the contents of your .env

Save

🚀 5. Deploy the stack
Verify that your docker-compose.yml and .env are correct

Click on Deploy the stack

Wait a few minutes while Portainer downloads and configures the containers

🔍 6. Verify everything is working
Once the stack is deployed:

Go back to Stacks

Click on hub_multimedia

Verify that all containers are in Running state

## 🌐 Service Access

| Service       | Local URL                     |
|---------------|-------------------------------|
| Plex          | http://serverip:32400/web     |
| Sonarr        | http://serverip:8989          |
| Radarr        | http://serverip:7878          |
| Bazarr        | http://serverip:6767          |
| Seerr         | http://serverip:5055          |
| Prowlarr      | http://serverip:9696          |
| qBittorrent   | http://serverip:8080          |
| FlareSolverr  | http://serverip:8191          |
| Tautulli      | http://serverip:8181          |
| Cleanuparr    | http://serverip:11011         |
| Portainer     | http://serverip:9000          |

> ⚠️ qBittorrent, Prowlarr, and FlareSolverr go through **Gluetun**, so their ports are exposed via the VPN container.

---
## 🌐 Service Configuration

I will generate additional tutorial files for configuration from the WebUIs.
Follow this configuration order:

| Service       |
|---------------|
| Plex          |
| Sonarr        | 
| Radarr        |
| Lidarr        |
| Bazarr        |
| Prowlarr      |
| FlareSolverr  |
| qBittorrent   |
| Seerr         |
| Tautulli      |
| Cleanuparr    |
