
## 🛠️ Prérequis

Avant d’installer ce hub multimédia, assure-toi de disposer des éléments suivants :

### 🔧 Matériel & système
- Un serveur ou une machine virtuelle capable de faire tourner Docker  
- Linux recommandé (Debian, Ubuntu)
- Accès administrateur (sudo) 
- Config recommandée :
  - CPU : 6 cœurs
  - RAM : 12 Go
  - Stockage : 128 Go (selon la bibliothèque)
- Un NAS qui stocke vos fichiers (Series/Films)
- Les partages du NAS paramétrés en montage automatique via le FSTAB

### 📦 Logiciels nécessaires
- **Docker**  
- **Docker Compose** (v2 ou supérieur)
- **Portainer** (Gestion des containers en WebUI)

### 🔐 VPN & réseau
- Un compte **ProtonVPN** (compatible port forwarding)
- Une clé **WireGuard** valide  

### 📁 Arborescence recommandée
Organise tes dossiers pour stocker les configs des containers sur ton serveur comme ceci :

/app/
  ├── gluetun/config
  ├── qbittorrent/config
  ├── prowlarr/config
  ├── sonarr/config
  ├── radarr/config
  ├── bazarr/
  └── seerr/

```
sudo mkdir -p \
  /app/gluetun/config \
  /app/qbittorrent/config \
  /app/prowlarr/config \
  /app/sonarr/config \
  /app/radarr/config \
  /app/bazarr \
  /app/seerr \
```

### 📁 Points de montage du NAS par rapport au script 
Organise tes points de montage sur ton serveur comme ceci :

/data/
  ├── films 
  ├── series
  └── qbittorrent/
        └── downloads/

### 🔑 Fichier `.env`
Crée un fichier `.env` à la racine du projet :

```
PUID=1000
PGID=1000
TZ=Europe/Paris

MEDIA_DIR=/mnt/media

OPENVPN_USER=
OPENVPN_PASSWORD=
WIREGUARD_PRIVATE_KEY=
SERVER_COUNTRIES=France
```

---

## 🚀 Installation

### 1️⃣ Cloner le dépôt

```bash
git clone https://github.com/ghost1337john/hub_multimedia.git
cd hub_multimedia
```

### 2️⃣ Configurer le fichier `.env`

- Renseigne tes identifiants VPN
- Vérifie les chemins de volumes
- Ajuste `MEDIA_DIR` selon ton stockage

### 3️⃣ Lancer l’environnement

```bash
docker compose up -d
```

### 4️⃣ Vérifier que tout fonctionne

```bash
docker compose ps
```

Les services doivent apparaître en **Up**.

---

## 🌐 Accès aux services

| Service       | URL locale                  |
|---------------|-----------------------------|
| Sonarr        | http://localhost:8989       |
| Radarr        | http://localhost:7878       |
| Bazarr        | http://localhost:6767       |
| Seerr         | http://localhost:5055       |
| Prowlarr      | http://localhost:9696       |
| qBittorrent   | http://localhost:8080       |
| FlareSolverr  | http://localhost:8191       |

> ⚠️ qBittorrent, Prowlarr et FlareSolverr passent par **Gluetun**, donc leurs ports sont exposés via le conteneur VPN.

---

Si tu veux, je peux aussi te générer :

- une **section “Dépannage / Troubleshooting”**  
- une **section “Mise à jour & maintenance”**  
- un **diagramme Mermaid** pour ton README  
- ou même une **optimisation avancée** (réseaux dédiés, labels Traefik, Watchtower, etc.)

Tu veux pousser ton README encore plus loin J ?
