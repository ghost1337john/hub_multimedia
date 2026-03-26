
> 💡 **Installation rapide** : Si tu es sur **Debian 13**, tu peux utiliser le script d'installation automatique au lieu de suivre ce guide manuellement.  
> Consulte [`auto_deploy/README_AUTOSCRIPT.md`](auto_deploy/README_AUTOSCRIPT.md) pour plus de détails.

---

## 🛠️ Prérequis

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

/app/
  ├── gluetun/config
  ├── qbittorrent/config
  ├── prowlarr/config
  ├── sonarr/config
  ├── radarr/config
  ├── cleanuparr/config
  ├── bazarr/config
  ├── seerr/config
  ├── flaresolverr/config
  ├── plex/config
  ├── tautulli/config
  └── portainer/config

#Afficher l'uid et le giud de l'utilisateur en cours :
```
plex@SRV-PLEX:~$id
uid=1000(plex) gid=1000(plex)
groupes=1000(plex),24(cdrom),25(floppy),27(sudo),29(audio),30(dip),44(video),46(plu
gdev),100(users),101(netdev)
```
#Création des répertoires en une ligne de commande :
```
sudo mkdir -p \
  /app/gluetun/config \
  /app/qbittorrent/config \
  /app/prowlarr/config \
  /app/sonarr/config \
  /app/radarr/config \
  /app/cleanuparr/config \
  /app/bazarr/config \
  /app/seerr/config \
  /app/flaresolverr/config \
  /app/plex/config \
  /app/tautulli/config \
  /app/portainer/config \

sudo mkdir /data
```
#Attribution des droits sur les répertoires 
```
sudo chown -R 1000:1000 /app
sudo chown -R 1000:1000 /data
```

### 📁 Points de montage du NAS par rapport au script 
Organise tes points de montage sur ton serveur comme ceci :

/data/
  ├── films 
  ├── series
  └── qbittorrent/
        └── downloads/

### 🔑 Fichier `.env`
Créer le fichier `.env` à la racine du projet avec les informations de proton VPN récupérables comme suit :

Pour OpenVPN, allez dans la section Compte et copiez votre nom d'utilisateur et votre mot de passe.
REMARQUE : POUR QUE LE TRANSFERT DE PORT FONCTIONNE, VOUS DEVEZ AJOUTER «
+pmp » À LA FIN DE VOTRE NOM D'UTILISATEUR DANS LE FICHIER .env.

<img width="1055" height="738" alt="image" src="https://github.com/user-attachments/assets/2b364b33-b5cc-4d03-8619-dd9c0b8f0363" />

Pour WireGuard, allez dans la section Téléchargements et créez une nouvelle configuration WireGuard.
Sélectionnez Router, aucun filtrage, et « NAT‑PMP (Port Forwarding) ». Désélectionnez VPN
Accelerator. Lorsque vous cliquez sur Create, une fenêtre affichera la configuration. Copiez la
PrivateKey.

<img width="1040" height="851" alt="image" src="https://github.com/user-attachments/assets/21c5f167-0c1d-4723-88b5-b6bbf737a88a" />

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

### 1️⃣ Cloner le dépôt sur votre linux dans un répertoire de travail et placer vous dedans (ex : /home/$user/docker) 

```bash
git clone https://github.com/ghost1337john/hub_multimedia.git
cd hub_multimedia/sources
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
| Bazarr        |
| Prowlarr      |
| FlareSolverr  |
| qBittorrent   |
| Seerr         |
| Tautulli      |
| Cleanuparr    |
