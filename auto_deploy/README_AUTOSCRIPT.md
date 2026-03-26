# 🚀 Installation automatique du Hub Multimédia via Autoscript

Ce script permet de déployer l'intégralité du hub multimédia sur un serveur **Debian 13 (Trixie)** en une seule commande.

---

## 🧩 Prérequis

- Un serveur ou une VM sous **Debian 13**
- Un accès **root** ou **sudo**
- Une connexion internet active
- Un compte **ProtonVPN** avec une clé WireGuard valide
- Les partages NAS montés dans `/data` et `/data2` (via fstab)

---

## 📁 Contenu du dossier `auto_deploy/`

| Fichier | Description |
|---------|-------------|
| `autoscript_install_hub_on_debian.sh` | Script d'installation et de déploiement complet |
| `save_hub.sh` | Script de sauvegarde des configurations des containers |

---

## 🛠️ Étapes d'installation

### 1. Cloner le dépôt sur le serveur

```bash
git clone https://github.com/ghost1337john/hub_multimedia.git
cd hub_multimedia
```

### 2. Créer le fichier `.env`

Avant de lancer le script, crée le fichier `.env` dans le dossier `sources/` :

```bash
nano sources/.env
```

Contenu attendu :

```
PUID=1000
PGID=1000
TZ=Europe/Paris
MEDIA_DIR=/data
OPENVPN_USER=ton_user+pmp
OPENVPN_PASSWORD=ton_password
WIREGUARD_PRIVATE_KEY=ta_cle_privee
SERVER_COUNTRIES=Spain,Portugal
```

> ⚠️ Le fichier `.env` est **obligatoire**. Sans lui, le script s'arrêtera avec une erreur.

### 3. Lancer le script d'installation

```bash
sudo bash auto_deploy/autoscript_install_hub_on_debian.sh
```

---

## 📋 Ce que fait le script

1. Vérifie les droits root
2. Met à jour le système (`apt update && upgrade`)
3. Installe Docker et Docker Compose (si absents)
4. Crée l'arborescence des dossiers de configuration (`/app/*/config`)
5. Crée les dossiers de données (`/data`, `/data2`)
6. Attribue les droits à l'utilisateur PUID/PGID 1000
7. Copie le `docker-compose.yml` et le `.env` dans `/opt/hub_multimedia`
8. Vérifie la validité du fichier docker-compose
9. Lance tous les containers
10. Affiche l'état des containers et les URLs d'accès

---

## 🌐 Accès aux services après installation

Le script affiche automatiquement les URLs avec l'IP du serveur :

| Service       | Port  |
|---------------|-------|
| Plex          | 32400 |
| Sonarr        | 8989  |
| Radarr        | 7878  |
| Bazarr        | 6767  |
| Seerr         | 5055  |
| Prowlarr      | 9696  |
| qBittorrent   | 8080  |
| FlareSolverr  | 8191  |
| Tautulli      | 8181  |
| Cleanuparr    | 11011 |

---

## 💾 Sauvegarde des configurations

Une fois les services configurés via leurs WebUI, utilise le script de sauvegarde :

```bash
sudo bash auto_deploy/save_hub.sh
```

Ce script :
- Arrête proprement les containers
- Archive les configurations des 11 services + le docker-compose et le .env
- Redémarre les containers
- Conserve les **5 dernières sauvegardes** (rotation automatique)

Les archives sont stockées dans `/opt/backups/hub_multimedia/`.

---

## ⚠️ Notes importantes

- Les services qBittorrent, Prowlarr et FlareSolverr passent par le VPN (**Gluetun**). Si le VPN ne démarre pas, ces services seront inaccessibles.
- Plex fonctionne en `network_mode: host` pour la découverte réseau.
- Les montages NAS (`/data`, `/data2`) doivent être configurés dans le **fstab** avant de lancer le script.
