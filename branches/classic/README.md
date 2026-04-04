
## 📋 Table des matières

- [🛠️ Prérequis](#prérequis)
- [📦 Logiciels nécessaires](#logiciels-nécessaires)
- [🔐 VPN & réseau](#vpn--réseau)
- [📁 Arborescence recommandée](#arborescence-recommandée)
- [Récupérer le PUID et le PGID de l'utilisateur](#récupérer-le-puid-et-le-pgid-de-lutilisateur)
- [Création des répertoires en une ligne de commande](#création-des-répertoires-en-une-ligne-de-commande)
- [Attribution des droits sur les répertoires](#attribution-des-droits-sur-les-répertoires)
- [📁 Points de montage du NAS par rapport au script](#points-de-montage-du-nas-par-rapport-au-script)
- [🔑 Fichier .env](#fichier-env)
- [🚀 Installation avec docker](#installation-avec-docker)
- [🐳 Installation via Portainer (sans ligne de commande)](#installation-via-portainer-sans-ligne-de-commande)

Avant d'installer ce hub multimédia, assure-toi de disposer des éléments suivants :

### 🔧 Matériel & système
- Un serveur ou une machine virtuelle capable de faire tourner Docker  
- Linux recommandé (Debian, Ubuntu)
- Accès administrateur (sudo) 
- Config minimale :
  - CPU : 4 cœurs
  - RAM : 8 Go
  - Stockage : 64 Go SSD
- Config recommandée (confortable) :
  - CPU : 6 cœurs
  - RAM : 16 Go
  - Stockage : 128 Go SSD

> 💡 **Note sur Plex** : sans transcodage matériel (GPU), chaque flux transcodé peut consommer 1‑2 cœurs CPU.  
> Avec du **Direct Play** (pas de transcodage), 4 cœurs / 8 Go suffisent.  
> Avec **transcodage** pour 2‑3 utilisateurs simultanés, prévoir 6 cœurs / 16 Go ou un GPU compatible (Intel QuickSync, NVIDIA).

- Un NAS qui stocke vos fichiers (Series/Films)
- Les partages du NAS paramétrés en montage automatique via le FSTAB
- Un compte ProtonVPN payant

### 📦 Logiciels nécessaires
- **Docker**  
- **Docker Compose** (v2 ou supérieur)
- **Portainer** (Gestion des containers en WebUI)

### 🔐 VPN & réseau
- Un compte **ProtonVPN** (compatible port forwarding)
- Une clé **WireGuard** valide  

### 📁 Arborescence recommandée
Organise tes dossiers pour stocker les configs des containers sur ton serveur comme ceci :

Pour créer tous les dossiers nécessaires en une seule commande :
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
  /app/seerr/config \
  /app/flaresolverr/config \
  /app/plex/config \
  /app/tautulli/config \

# Exemple d'organisation des dossiers de configuration :

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


Pour que les containers Docker aient les bons droits sur vos fichiers, récupérez votre **PUID** (User ID) et **PGID** (Group ID) avec :

```bash
id
```

Notez ces valeurs, elles seront utilisées dans le fichier `.env` à la racine du projet.

Exemple de fichier `.env` :

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

Pour OpenVPN, allez dans la section Compte de ProtonVPN et copiez votre nom d'utilisateur et mot de passe. Ajoutez « +pmp » à la fin de votre nom d'utilisateur pour activer le port forwarding.

Pour WireGuard, créez une nouvelle configuration dans la section Téléchargements, sélectionnez Router, aucun filtrage, NAT‑PMP (Port Forwarding), puis copiez la PrivateKey.

> 💡 Adaptez les chemins et identifiants à votre configuration.

# Attribution des droits sur les répertoires
```bash
sudo chown -R 1000:1000 /app
sudo chown -R 1000:1000 /data
```

### 📁 Points de montage du NAS par rapport au script 
Organise tes points de montage sur ton serveur comme ceci :

/data/
  ├── films 
  ├── series
sudo mkdir /data
```
  └── qbittorrent/
        └── downloads/

### 🔑 Fichier `.env`
Créer le fichier `.env` à la racine du projet avec les informations de proton VPN récupérables comme suit :

Pour OpenVPN, allez dans la section Compte et copiez votre nom d'utilisateur et votre mot de passe.
REMARQUE : POUR QUE LE TRANSFERT DE PORT FONCTIONNE, VOUS DEVEZ AJOUTER «
+pmp » À LA FIN DE VOTRE NOM D'UTILISATEUR DANS LE FICHIER .env.

Pour WireGuard, allez dans la section Téléchargements et créez une nouvelle configuration WireGuard.
Sélectionnez Router, aucun filtrage, et « NAT‑PMP (Port Forwarding) ». Désélectionnez VPN
Accelerator. Lorsque vous cliquez sur Create, une fenêtre affichera la configuration. Copiez la
PrivateKey.

Exemple de fichier avec les informations : 

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

## 🚀 Installation avec docker


### 1️⃣ Cloner le dépôt principal (branche `Project`)

```bash
git clone https://github.com/ghost1337john/hub_multimedia.git
cd hub_multimedia/branches/classic
```

### 2️⃣ Configurer le fichier `.env` comme expliquer précédement 

- Renseigne tes identifiants VPN
- Vérifie les chemins de volumes
- Ajuste `MEDIA_DIR` selon ton stockage

### 3️⃣ Lancer l'environnement

```bash
docker compose up -d
```

### 4️⃣ Vérifier que tout fonctionne

```bash
docker compose ps
```

Les services doivent apparaître en **Up**.

---
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## 

## 🐳 Installation via Portainer (sans ligne de commande)
Cette méthode permet d'installer tout le hub multimédia directement depuis Portainer, sans utiliser Docker en ligne de commande.

🧭 1. Accéder à Portainer
Ouvre ton navigateur

Va sur l'adresse de ton Portainer :
http://IP_DE_TON_SERVEUR:9000

Connecte‑toi avec ton compte administrateur

📁 2. Préparer les dossiers nécessaires

Avant de déployer la stack, crée les dossiers des prérequis sur ton serveur.

🧩 3. Créer la stack dans Portainer
Dans le menu de gauche, clique sur Stacks

Clique sur Add Stack

Donne un nom à ta stack, par exemple :
hub_multimedia

Colle ton fichier docker-compose.yml dans le champ Web editor

🔐 4. Ajouter le fichier .env
Toujours dans la page de création de la stack :

Descends jusqu'à la section Environment variables

Clique sur Add an environment file

Colle le contenu de ton .env

Sauvegarde

🚀 5. Déployer la stack
Vérifie que ton docker-compose.yml et ton .env sont corrects

Clique sur Deploy the stack

Patiente quelques minutes pendant que Portainer télécharge et configure les conteneurs

🔍 6. Vérifier que tout fonctionne
Une fois la stack déployée :

Retourne dans Stacks

Clique sur hub_multimedia

Vérifie que tous les conteneurs sont en Running

## 🌐 Accès aux services

| Service       | URL locale                  |
|---------------|-----------------------------|
| Plex          | http://ipduserveur:32400/web  |
| Sonarr        | http://ipduserveur:8989       |
| Radarr        | http://ipduserveur:7878       |
| Lidarr        | http://ipduserveur:8686       |
| Bazarr        | http://ipduserveur:6767       |
| Seerr         | http://ipduserveur:5055       |
| Prowlarr      | http://ipduserveur:9696       |
| qBittorrent   | http://ipduserveur:8080       |
| FlareSolverr  | http://ipduserveur:8191       |
| Tautulli      | http://ipduserveur:8181       |
| Cleanuparr    | http://ipduserveur:11011       |
| Portainer     | http://ipduserveur:9000        |

> ⚠️ qBittorrent, Prowlarr et FlareSolverr passent par **Gluetun**, donc leurs ports sont exposés via le conteneur VPN.

---
## 🌐 Configuration des différents services 

Je vais générer d'autres fichiers tutoriels pour la configuration depuis les WebUIs.
Suivre cette ordre de configuration :

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
