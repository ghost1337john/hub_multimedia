# 📺 Installer Plex en Docker sur Debian

Cette section explique comment installer **Plex Media Server** sur une machine Debian en utilisant Docker et Docker Compose.

---

## 🧩 Prérequis

Avant de commencer, assure‑toi d’avoir :

- Debian 10/11/12 (ou dérivé)
- Un utilisateur avec droits `sudo`
- Docker installé  
- Docker Compose installé  
- Un dossier pour stocker :
  - la configuration Plex  
  - ta médiathèque (films, séries, musique…)

---

## 📁 Arborescence recommandée

Voici une structure simple et efficace :

```
/app/plex/config
/data/films
/data/series
/data/musique
```

Tu peux l’adapter selon ton organisation.

---

## 🛠️ 1. Créer les dossiers nécessaires et monter les partages dans data via fstab

À exécuter sur ton serveur :

```bash
sudo mkdir -p /app/plex/config \
             /data
```

---

## 🧾 2. Créer le fichier `docker-compose.yml`

Voici un `docker-compose.yml` propre et fonctionnel :

```yaml
version: "3.9"

services:
  plex:
    image: lscr.io/linuxserver/plex:latest
    container_name: plex
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Paris
      - VERSION=docker
    volumes:
      - /app/plex/config:/config
      - /media/films:/data/films
      - /media/series:/data/series
      - /media/musique:/data/musique
    ports:
      - 32400:32400
    restart: unless-stopped
```

---

## 🚀 3. Déployer Plex

Dans le dossier où se trouve ton `docker-compose.yml` :

```bash
docker compose up -d
```

Plex va se télécharger puis démarrer automatiquement.

---

## 🌐 4. Accéder à Plex

Une fois le conteneur lancé, ouvre ton navigateur :

👉 **http://IP_DE_TON_SERVEUR:32400/web**

Tu seras invité à te connecter avec ton compte Plex.

---

## 🎞️ 5. Ajouter ta médiathèque

Depuis l’interface Plex :

1. Clique sur **Ajouter une bibliothèque**
2. Choisis le type (Films, Séries, Musique…)
3. Sélectionne le dossier correspondant :
   - `/data/films`
   - `/data/series`
   - `/data/musique`
4. Valide

Plex va scanner et organiser automatiquement tes contenus.

---

## 🔄 Mise à jour de Plex

Pour mettre à jour Plex :

```bash
docker compose pull
docker compose up -d
```

---

## 🛡️ Conseils supplémentaires

- Utilise un **reverse proxy** (Traefik, Nginx Proxy Manager…) pour un accès sécurisé HTTPS.
- Sauvegarde régulièrement `/app/plex/config`.
- Si tu utilises un VPN, attention : Plex nécessite un accès direct pour le remote access.

---

Si tu veux, je peux aussi te générer :

- une **version Portainer** (comme pour ton hub multimédia)  
- une **version avec Traefik / HTTPS**  
- une **version avec stockage sur NAS (NFS/SMB)**  
- ou une **intégration Plex dans ton README existant**

Tu veux pousser ça encore plus loin J ?
