# 🪟 Installation sur Windows

## Prérequis

- **Windows 10/11** (Pro, Enterprise, ou Home avec WSL2)
- **Docker Desktop** installé avec le backend **WSL2**
  - Téléchargement : https://www.docker.com/products/docker-desktop/
- **8 Go de RAM** minimum (16 Go recommandé pour Plex + VPN)
- Connexion Internet active
- Un compte **ProtonVPN** avec un abonnement supportant le port forwarding

---

## Installation rapide

### Option 1 : Double-cliquer sur le .bat (recommandé)

1. Clone le dépôt ou télécharge le dossier `auto_deploy/windows/`
2. Double-clique sur **`install_hub_windows.bat`**
3. Accepte l'élévation administrateur
4. Suis l'assistant interactif

### Option 2 : Depuis PowerShell

```powershell
Set-ExecutionPolicy Bypass -Scope Process
.\auto_deploy\windows\install_hub_windows.ps1
```

### Option 3 : Créer un véritable .exe

Pour convertir le script en exécutable `.exe` :

```powershell
Install-Module ps2exe -Scope CurrentUser
Invoke-ps2exe .\auto_deploy\windows\install_hub_windows.ps1 .\install_hub.exe
```

Ensuite, double-cliquez sur `install_hub.exe` pour lancer l'installation.

---

## Ce que fait le script

| Étape | Description |
|-------|-------------|
| 1 | Vérifie que Docker Desktop est installé et démarré |
| 2 | Configure les répertoires d'installation (interactif) |
| 3 | Configure la connexion VPN (WireGuard ou OpenVPN) |
| 4 | Génère le fichier `.env` avec vos paramètres |
| 5 | Génère un `docker-compose.yml` adapté à Windows |
| 6 | Valide la configuration docker-compose |
| 7 | Déploie les 12 containers |

---

## Différences avec la version Linux

| Élément | Linux | Windows |
|---------|-------|---------|
| Device VPN | `/dev/net/tun` monté manuellement | Géré par Docker Desktop/WSL2 |
| Chemins volumes | `/app/...` | `C:/hub_multimedia/app/...` |
| Plex réseau | `network_mode: host` | Mapping de ports (32400) |
| Fuseau horaire | `/etc/localtime` monté | Variable d'environnement `TZ` |
| Permissions | `chown` PUID/PGID | Géré par Docker Desktop/WSL2 |
| Script | Bash | PowerShell |

---

## Structure des fichiers après installation

```
C:\hub_multimedia\
├── app\
│   ├── gluetun\config\
│   ├── qbittorrent\config\
│   ├── prowlarr\config\
│   ├── sonarr\config\
│   ├── radarr\config\
│   ├── bazarr\config\
│   ├── seerr\config\
│   ├── flaresolverr\config\
│   ├── cleanuparr\config\
│   ├── tautulli\config\
│   ├── plex\config\
│   └── portainer\config\
├── data\
│   ├── films\
│   ├── series\
│   └── qbittorrent\downloads\
├── data2\
└── docker\
    ├── docker-compose.yml
    └── .env
```

---

## Accès aux services

| Service | URL |
|---------|-----|
| Plex | http://localhost:32400/web |
| Sonarr | http://localhost:8989 |
| Radarr | http://localhost:7878 |
| Bazarr | http://localhost:6767 |
| Seerr | http://localhost:5055 |
| Prowlarr | http://localhost:9696 |
| qBittorrent | http://localhost:8080 |
| FlareSolverr | http://localhost:8191 |
| Tautulli | http://localhost:8181 |
| Cleanuparr | http://localhost:11011 |
| Portainer | http://localhost:9000 |

---

## Commandes utiles

### Vérifier l'état des containers
```powershell
cd C:\hub_multimedia\docker
docker compose ps
```

### Redémarrer la stack
```powershell
cd C:\hub_multimedia\docker
docker compose down
docker compose up -d
```

### Consulter les logs d'un service
```powershell
docker logs gluetun
docker logs plex
```

### Vérifier la connexion VPN
```powershell
docker exec gluetun wget -qO- https://ipinfo.io
```

---

## Dépannage

### Docker Desktop n'est pas détecté
- Vérifie que Docker Desktop est installé et démarré (icône dans la barre des tâches)
- Active le backend WSL2 : Docker Desktop → Settings → General → Use the WSL 2 based engine

### Gluetun ne se connecte pas au VPN
- Vérifie les logs : `docker logs gluetun`
- Vérifie les identifiants dans `C:\hub_multimedia\docker\.env`
- Pour WireGuard : vérifie que la clé privée est correcte
- Pour OpenVPN : vérifie que `+pmp` est ajouté au nom d'utilisateur

### qBittorrent / Prowlarr inaccessibles
Ces services passent par Gluetun. Si le VPN est down, ils sont inaccessibles.
```powershell
docker restart gluetun
```

### Plex ne voit pas les fichiers médias
- Vérifie les chemins dans `docker-compose.yml`
- Dans Plex, ajoute les bibliothèques en pointant vers `/movies` ou `/series` (chemins internes au container)
