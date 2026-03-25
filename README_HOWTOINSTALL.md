
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
  ├── bazarr/
  └── seerr/

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
  /app/bazarr \
  /app/seerr \

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

Pour OpenVPN, allez dans la section Compte et copiez votre nom d’utilisateur et votre mot de passe.
REMARQUE : POUR QUE LE TRANSFERT DE PORT FONCTIONNE, VOUS DEVEZ AJOUTER «
+pmp » À LA FIN DE VOTRE NOM D’UTILISATEUR DANS LE FICHIER .env.

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

### 1️⃣ Cloner le dépôt sur votre linux dans un répertoire de travail (ex : /home/$user/docker) :

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
