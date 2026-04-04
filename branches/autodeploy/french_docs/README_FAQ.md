df -h /data /data2 /app

---

## 🔐 VPN / Gluetun

### Le VPN ne se connecte pas
- Vérifie que ta clé WireGuard est correcte dans le `.env`
- Vérifie que ton compte ProtonVPN supporte le port forwarding (plan payant requis)
- Consulte les logs : `docker logs gluetun`
- Vérifie que le device `/dev/net/tun` existe sur ton serveur :
  ```bash
  ls -la /dev/net/tun
  ```
  Si absent, charge le module kernel :
  ```bash
  sudo modprobe tun
  ```
- Vérifie que le type VPN dans le `.env` correspond à tes identifiants (`VPN_TYPE=wireguard` ou `VPN_TYPE=openvpn`)

### qBittorrent / Prowlarr / FlareSolverr sont inaccessibles
Ces services passent par Gluetun (`network_mode: service:gluetun`). Si le VPN est down, ils sont inaccessibles.
- Vérifie l'état de Gluetun : `docker ps | grep gluetun`
- Redémarre le VPN : `docker restart gluetun`
- Vérifie que Gluetun est `healthy` avant de redémarrer les services dépendants :
  ```bash
  docker inspect gluetun --format='{{.State.Health.Status}}'
  ```
- Si Gluetun est healthy mais les services sont toujours inaccessibles, redémarre-les :
  ```bash
  docker restart qbittorrent prowlarr flaresolverr
  ```

### Le port forwarding ne fonctionne pas
- Vérifie que tu as ajouté `+pmp` à la fin de ton `OPENVPN_USER` dans le `.env`
- Vérifie que `VPN_PORT_FORWARDING=on` est bien dans le docker-compose
- Vérifie que `PORT_FORWARD_ONLY=on` est configuré si tu veux forcer les serveurs avec port forwarding
- Consulte le port attribué :
  ```bash
  docker logs gluetun 2>&1 | grep "port forwarded"
  ```
- Vérifie que le port est bien appliqué à qBittorrent :
  ```bash
  docker exec gluetun wget -qO- http://127.0.0.1:8080/api/v2/app/preferences 2>/dev/null | grep listen_port
  ```

### Vérifier que Gluetun est bien connecté au VPN

Pour confirmer que Gluetun a bien établi la connexion VPN, plusieurs méthodes :

**1. Consulter les logs de Gluetun :**
```bash
docker logs gluetun
```
Cherche les lignes indiquant une connexion réussie :
```
INFO [vpn] connected to ...
INFO [port forwarding] port forwarded is ...
```
Si tu vois des erreurs `AUTH` ou `TLS`, vérifie tes identifiants dans le `.env`.

**2. Vérifier l'IP publique utilisée par le VPN :**
```bash
docker exec gluetun wget -qO- https://ipinfo.io
```
L'IP affichée doit être différente de ton IP réelle et correspondre au pays configuré dans `SERVER_COUNTRIES`.

**3. Vérifier l'état via l'API intégrée de Gluetun (port 8000) :**
```bash
curl http://localhost:8000/v1/openvpn/status
```
Réponse attendue : `{"status":"running"}`

**4. Vérifier qu'il n'y a pas de fuite DNS :**
```bash
docker exec gluetun cat /etc/resolv.conf
```
Le DNS doit pointer vers un serveur VPN, pas vers ton DNS local.

> 💡 Si la connexion VPN est down, tous les services qui passent par Gluetun (qBittorrent, Prowlarr, FlareSolverr) seront inaccessibles.

### Le VPN se déconnecte régulièrement
- Vérifie les logs pour des erreurs de keepalive :
  ```bash
  docker logs gluetun 2>&1 | grep -i "keepalive\|timeout\|disconnect"
  ```
- Essaie de changer de pays VPN dans le `.env` (`SERVER_COUNTRIES`)
- Vérifie que la variable `UPDATER_PERIOD=24h` est bien configurée pour mettre à jour les serveurs automatiquement
- Si tu utilises WireGuard, régénère ta clé privée depuis le portail ProtonVPN

---

## 📺 Plex

### Plex n'est pas trouvé sur le réseau local
- Plex utilise `network_mode: host`, il doit être accessible directement via l'IP du serveur sur le port 32400
- Vérifie que le port 32400 n'est pas bloqué par un firewall :
  ```bash
  sudo ufw status
  sudo ufw allow 32400/tcp
  ```
- Vérifie les logs : `docker logs plex`
- Vérifie que Plex écoute bien :
  ```bash
  curl -s http://localhost:32400/identity
  ```

### Plex ne voit pas mes fichiers
- Vérifie que les volumes `/data` et `/data2` sont correctement montés dans le fstab :
  ```bash
  mount | grep -E "/data|/data2"
  ```
- Vérifie les permissions : `ls -la /data/` (doit appartenir à 1000:1000)
- Dans Plex, ajoute les bibliothèques en pointant vers `/movies` ou `/series` (les chemins internes au container)
- Si tu viens d'ajouter des fichiers, lance un scan manuel : Plex → Bibliothèques → `...` → Scanner les fichiers

### Le claim token a expiré
- Récupère un nouveau token sur https://plex.tv/claim (valide 4 minutes)
- Ajoute-le dans le docker-compose : `PLEX_CLAIM=claim-xxxxx`
- Redéploie : `docker compose up -d plex`

### Le transcodage est lent ou en erreur
- Vérifie que le dossier `/transcode` a suffisamment d'espace disque
- Vérifie les paramètres de transcodage : Settings → Transcoder
- Pour le transcodage matériel (GPU), vérifie que le device est monté dans le docker-compose :
  ```yaml
  devices:
    - /dev/dri:/dev/dri
  ```
- Vérifie les capacités GPU :
  ```bash
  ls -la /dev/dri/
  ```

### Plex est inaccessible depuis l'extérieur (accès distant)
- Vérifie que l'accès distant est activé dans Settings → Remote Access
- Vérifie que le port 32400 est ouvert sur ton routeur (redirection de port/NAT)
- Si tu es derrière un CGNAT, l'accès distant direct ne fonctionnera pas (utilise un reverse proxy ou un tunnel)

### La base de données Plex est corrompue
- Symptômes : Plex plante au démarrage, bibliothèques vides malgré fichiers présents
- Arrête Plex : `docker stop plex`
- Sauvegarde la base de données (chemin sur l'hôte, via le montage de volume `/app/plex/config:/config`) :
  ```bash
  DB_PATH="/app/plex/config/Library/Application Support/Plex Media Server/Plug-in Support/Databases"
  cp "${DB_PATH}/com.plexapp.plugins.library.db" "${DB_PATH}/com.plexapp.plugins.library.db.backup"
  ```
- Vérifie l'intégrité de la base avec `sqlite3` (à installer sur l'hôte si absent : `sudo apt install sqlite3`) :
  ```bash
  sqlite3 "${DB_PATH}/com.plexapp.plugins.library.db" "PRAGMA integrity_check"
  ```
- Si la vérification renvoie des erreurs, tente une réparation :
  ```bash
  sqlite3 "${DB_PATH}/com.plexapp.plugins.library.db" ".clone ${DB_PATH}/com.plexapp.plugins.library-repaired.db"
  mv "${DB_PATH}/com.plexapp.plugins.library.db" "${DB_PATH}/com.plexapp.plugins.library-corrupt.db"
  mv "${DB_PATH}/com.plexapp.plugins.library-repaired.db" "${DB_PATH}/com.plexapp.plugins.library.db"
  ```
- Redémarre Plex : `docker start plex`
- Si la réparation échoue, restaure la sauvegarde : `cp "${DB_PATH}/com.plexapp.plugins.library.db.backup" "${DB_PATH}/com.plexapp.plugins.library.db"`

---

## 🧲 qBittorrent

### Le mot de passe par défaut ne fonctionne pas
Au premier lancement, qBittorrent génère un mot de passe aléatoire.
- Consulte les logs : `docker logs qbittorrent`
- Cherche la ligne contenant `temporary password`
- Une fois connecté, change le mot de passe dans : Tools → Options → Web UI

### Les téléchargements sont lents
- Vérifie que le port forwarding VPN est actif :
  ```bash
  docker logs gluetun 2>&1 | grep "port forwarded"
  ```
- Vérifie que le port est bien configuré dans qBittorrent : Tools → Options → Connection → Listening Port
- Vérifie les paramètres de connexion dans qBittorrent WebUI (limites de vitesse)
- Vérifie le nombre de connexions max : Tools → Options → Connection (augmente si nécessaire)

### Les téléchargements sont en « stalled » (bloqués)
- Vérifie que le VPN est connecté et que le port forwarding fonctionne
- Vérifie que les trackers répondent : clic droit sur le torrent → Trackers
- Vérifie que l'espace disque est suffisant :
  ```bash
  df -h /data/downloads
  ```
- Redémarre qBittorrent : `docker restart qbittorrent`

### Les fichiers ne sont pas déplacés vers Sonarr/Radarr
- Vérifie que le chemin de téléchargement dans qBittorrent (`/downloads`) correspond à ce qui est monté dans Sonarr/Radarr
- Vérifie les catégories dans qBittorrent : les torrents envoyés par Sonarr doivent avoir la catégorie `tv`, ceux de Radarr `movies`
- Vérifie les permissions sur le dossier de téléchargement :
  ```bash
  ls -la ${MEDIA_DIR}/qbittorrent/downloads/
  ```

### L'interface WebUI n'est pas accessible
- L'interface passe par Gluetun (port 8080). Vérifie d'abord que Gluetun est healthy
- Vérifie les logs :
  ```bash
  docker logs qbittorrent --tail 20
  ```
- Vérifie que le port est bien mappé dans le service `gluetun` du docker-compose (`8080:8080/tcp`)

---

## 🧭 Prowlarr / Indexers

### Les indexers échouent avec des erreurs Cloudflare
- Vérifie que FlareSolverr est démarré : `docker ps | grep flaresolverr`
- Dans Prowlarr, configure FlareSolverr comme proxy :
  1. Settings → Indexers → Add → FlareSolverr
  2. Host : `http://localhost:8191` (car Prowlarr et FlareSolverr partagent le réseau de Gluetun)
  3. Ajoute un tag (ex : `flaresolverr`)
  4. Sur chaque indexer Cloudflare, ajoute ce tag

### Prowlarr ne synchronise pas avec Sonarr/Radarr
- Vérifie les clés API dans Prowlarr (Settings → Apps)
- Les adresses doivent utiliser les IPs du réseau Docker :
  - Sonarr : `http://172.19.0.6:8989`
  - Radarr : `http://172.19.0.5:7878`
- Récupère la clé API de Sonarr/Radarr : Settings → General → API Key
- Teste la connexion avec le bouton « Test » dans Prowlarr

### Les indexers renvoient des erreurs 401/403
- Vérifie que tes identifiants ou clés API d'indexer sont toujours valides
- Certains indexers limitent le nombre de requêtes (rate limiting) — attends quelques minutes
- Vérifie que l'indexer est toujours en ligne via un navigateur

### Prowlarr ne démarre pas ou est en boucle de redémarrage
- Prowlarr dépend de Gluetun (`network_mode: service:gluetun`). Vérifie d'abord que Gluetun est healthy
- Vérifie les logs :
  ```bash
  docker logs prowlarr --tail 30
  ```
- Si la base de données est corrompue, supprime-la et redémarre :
  ```bash
  docker stop prowlarr
  rm /app/prowlarr/config/prowlarr.db-journal
  docker start prowlarr
  ```

---

## 🌐 FlareSolverr

### FlareSolverr ne démarre pas
- FlareSolverr dépend de Gluetun. Vérifie que Gluetun est healthy :
  ```bash
  docker inspect gluetun --format='{{.State.Health.Status}}'
  ```
- Vérifie les logs :
  ```bash
  docker logs flaresolverr --tail 20
  ```

### FlareSolverr ne résout pas les challenges Cloudflare
- Certains sites ont des protections anti-bot avancées que FlareSolverr ne peut pas contourner
- Vérifie que FlareSolverr est à jour :
  ```bash
  docker pull ghcr.io/flaresolverr/flaresolverr:latest
  docker compose up -d flaresolverr
  ```
- Augmente le timeout dans Prowlarr si les résolutions sont lentes
- Vérifie les logs pour des erreurs spécifiques :
  ```bash
  docker logs flaresolverr 2>&1 | grep -i "error\|timeout"
  ```

### FlareSolverr consomme trop de mémoire
- FlareSolverr utilise un navigateur headless (Chromium) qui consomme de la RAM
- Redémarre FlareSolverr régulièrement si la mémoire augmente :
  ```bash
  docker restart flaresolverr
  ```
- Vérifie la consommation mémoire :
  ```bash
  docker stats flaresolverr --no-stream
  ```

---

## 📺 Sonarr / Séries TV

### Sonarr ne détecte pas les épisodes téléchargés
- Vérifie que le chemin de téléchargement dans le Download Client correspond au montage dans Sonarr
- Dans Sonarr : Settings → Download Clients → vérifier le chemin distant vs local
- Vérifie les permissions :
  ```bash
  ls -la /data/downloads/
  ```
- Consulte les logs : Activity → Queue → icône d'avertissement pour voir l'erreur détaillée

### Sonarr ne trouve pas de résultats de recherche
- Vérifie que Prowlarr est correctement configuré et synchronisé (Settings → Indexers)
- Vérifie que les profils de qualité sont correctement configurés (Settings → Profiles)
- Vérifie que la série est bien monitorée : Series → série → icône de calendrier activée
- Teste une recherche manuelle : Series → série → recherche interactive

### Sonarr affiche « Import failed: Access denied »
- Vérifie les permissions PUID/PGID dans le `.env`
- Vérifie que le dossier de destination est accessible :
  ```bash
  sudo chown -R 1000:1000 /data /data2
  ```
- Vérifie les montages volumes dans le docker-compose

### Sonarr est inaccessible (port 8989)
- Vérifie que le container est en cours d'exécution :
  ```bash
  docker ps | grep sonarr
  ```
- Vérifie les logs :
  ```bash
  docker logs sonarr --tail 20
  ```
- Vérifie le healthcheck :
  ```bash
  curl -f http://localhost:8989/ping
  ```

### La clé API de Sonarr
Pour trouver la clé API (nécessaire pour Prowlarr, Bazarr, etc.) :
- Sonarr WebUI → Settings → General → Security → API Key
- Ou via la ligne de commande :
  ```bash
  docker exec sonarr cat /config/config.xml | grep -oP '(?<=<ApiKey>).*(?=</ApiKey>)'
  ```

---

## 🎬 Radarr / Films

### Radarr ne détecte pas les films téléchargés
- Vérifie que le chemin de téléchargement dans le Download Client correspond au montage dans Radarr
- Dans Radarr : Settings → Download Clients → vérifier la configuration
- Vérifie les permissions sur les dossiers `/data` et `/downloads`
- Consulte la file d'attente : Activity → Queue

### Radarr ne trouve pas de résultats de recherche
- Vérifie que Prowlarr est correctement synchronisé (Settings → Indexers)
- Vérifie les profils de qualité (Settings → Profiles) — un profil trop restrictif peut filtrer tous les résultats
- Vérifie que le film est bien monitoré : Movies → film → icône moniteur activée

### Radarr affiche « Import failed » ou « Access denied »
- Mêmes solutions que pour Sonarr : vérifie PUID/PGID et les permissions sur les dossiers
- Vérifie que le dossier racine (Root Folder) existe et est accessible :
  ```bash
  ls -la /data/
  ```

### Radarr est inaccessible (port 7878)
- Vérifie que le container est en cours d'exécution :
  ```bash
  docker ps | grep radarr
  ```
- Vérifie les logs :
  ```bash
  docker logs radarr --tail 20
  ```
- Vérifie le healthcheck :
  ```bash
  curl -f http://localhost:7878/ping
  ```

### La clé API de Radarr
Pour trouver la clé API :
- Radarr WebUI → Settings → General → Security → API Key
- Ou via la ligne de commande :
  ```bash
  docker exec radarr cat /config/config.xml | grep -oP '(?<=<ApiKey>).*(?=</ApiKey>)'
  ```

---

## 💬 Bazarr / Sous-titres

### Bazarr ne trouve pas de sous-titres
- Vérifie que les providers sont configurés (Settings → Providers)
- Certains providers nécessitent un compte (OpenSubtitles, Addic7ed)
- Vérifie la connexion avec Sonarr/Radarr (Settings → Sonarr / Settings → Radarr)
- Vérifie que les langues souhaitées sont configurées : Settings → Languages

### Bazarr ne se connecte pas à Sonarr/Radarr
- Vérifie les adresses IP et les clés API dans Settings → Sonarr et Settings → Radarr
- Adresses à utiliser (réseau Docker) :
  - Sonarr : `http://172.19.0.6:8989`
  - Radarr : `http://172.19.0.5:7878`
- Teste la connexion avec le bouton « Test »
- Vérifie que Sonarr et Radarr sont accessibles :
  ```bash
  curl -f http://172.19.0.6:8989/ping
  curl -f http://172.19.0.5:7878/ping
  ```

### Les sous-titres téléchargés ne correspondent pas
- Vérifie le score minimum dans Settings → Subtitles (un score trop bas accepte des sous-titres de mauvaise qualité)
- Active le mode « Perfect Match » pour de meilleurs résultats
- Vérifie que les noms de fichiers de tes médias sont propres (Bazarr s'appuie sur le nom pour chercher)

### Bazarr est inaccessible (port 6767)
```bash
docker ps | grep bazarr
docker logs bazarr --tail 20
curl -f http://localhost:6767/api
```

---

## 🎬 Seerr / Demandes

### Seerr ne se connecte pas à Plex
- Vérifie que Plex est en cours d'exécution et accessible
- Dans Seerr, utilise l'IP du serveur (pas `localhost`) car Plex est en mode `host` :
  - Adresse : `http://IP_DU_SERVEUR:32400`
- Vérifie que ton token Plex est valide dans les paramètres de Seerr

### Seerr ne se connecte pas à Sonarr/Radarr
- Utilise les adresses du réseau Docker :
  - Sonarr : `http://172.19.0.6:8989`
  - Radarr : `http://172.19.0.5:7878`
- Vérifie les clés API de chaque service
- Teste la connexion avec le bouton « Test »

### Les demandes ne sont pas envoyées à Sonarr/Radarr
- Vérifie que les profils de qualité et les dossiers racines sont configurés dans Seerr
- Vérifie que Sonarr/Radarr sont bien définis comme serveurs par défaut dans Seerr
- Consulte les logs :
  ```bash
  docker logs seerr --tail 30
  ```

### Seerr est inaccessible (port 5055)
```bash
docker ps | grep seerr
docker logs seerr --tail 20
```

### Les notifications Seerr ne fonctionnent pas
- Vérifie la configuration dans Settings → Notifications
- Teste chaque canal de notification avec le bouton « Test »

---

## 🧹 Cleanuparr

### Cleanuparr ne supprime pas les fichiers
- Vérifie que Cleanuparr est connecté à Radarr et Sonarr
- Vérifie les règles de nettoyage dans l'interface WebUI (`http://IP_DU_SERVEUR:11011`)
- Vérifie que le volume de téléchargements est monté correctement dans le docker-compose
- Consulte les logs :
  ```bash
  docker logs cleanuparr --tail 20
  ```

### Cleanuparr est inaccessible (port 11011)
- Vérifie que le container est en cours d'exécution :
  ```bash
  docker ps | grep cleanuparr
  ```
- Vérifie que le healthcheck passe :
  ```bash
  docker inspect cleanuparr --format='{{.State.Health.Status}}'
  ```
- Vérifie les logs :
  ```bash
  docker logs cleanuparr --tail 20
  ```

### Cleanuparr supprime des fichiers qu'il ne devrait pas
- Revérifie les règles de nettoyage dans l'interface WebUI
- Réduis l'agressivité des règles ou ajoute des exceptions
- Consulte l'historique de Cleanuparr pour voir ce qui a été supprimé

---

## 📊 Tautulli

### Tautulli ne voit pas l'activité Plex
- Vérifie la connexion à Plex dans Settings → Plex Media Server
- L'adresse doit être l'IP du serveur (pas `localhost`, car Tautulli n'est pas en host mode)
- Port : `32400`
- Vérifie que le token Plex est valide

### Les notifications Tautulli ne fonctionnent pas
- Vérifie la configuration dans Settings → Notification Agents
- Teste chaque agent avec le bouton « Test Notification »
- Vérifie que les triggers (déclencheurs) sont activés pour chaque agent

### Tautulli affiche des données incorrectes ou manquantes
- Vérifie que Tautulli peut accéder aux logs de Plex
- Recharge les bibliothèques : Settings → Plex Media Server → Refresh Libraries
- Si l'historique est vide, importe-le : Settings → Import Plex Database

### Tautulli est inaccessible (port 8181)
```bash
docker ps | grep tautulli
docker logs tautulli --tail 20
curl -f http://localhost:8181/status
```

---

## 🐳 Portainer

### Impossible de créer le compte administrateur
Portainer se verrouille automatiquement si le compte admin n'est pas créé dans les premières minutes.
- Redémarre le container : `docker restart portainer`
- Accède immédiatement à `http://IP_DU_SERVEUR:9000` pour créer le compte
- Si le problème persiste, supprime les données et recommence :
  ```bash
  docker stop portainer
  rm -rf /app/portainer/config/*
  docker start portainer
  ```
  Puis accède immédiatement à l'interface pour créer le compte.

### Portainer ne voit pas les containers
- Vérifie que le socket Docker est bien monté : `/var/run/docker.sock:/var/run/docker.sock`
- Vérifie les permissions sur le socket : `ls -la /var/run/docker.sock`
- Consulte les logs : `docker logs portainer`
- Vérifie que l'endpoint est bien configuré dans Portainer : Environments → Local

### Impossible de déployer une stack depuis Portainer
- Vérifie que le fichier docker-compose est valide (pas d'erreurs de syntaxe YAML)
- Valide la syntaxe :
  ```bash
  docker compose -f /opt/hub_multimedia/docker_compose.yml config --quiet
  ```
- Vérifie que toutes les variables du `.env` sont renseignées
- Consulte les logs dans Portainer : container → Logs

### Portainer est inaccessible (port 9000)
```bash
docker ps | grep portainer
docker logs portainer --tail 20
```

---

## 🐳 Docker général

### Un container redémarre en boucle
```bash
docker logs <nom_du_container>
docker inspect <nom_du_container> --format='{{.State.Status}} - Restarts: {{.RestartCount}}'
```
Causes fréquentes :
- Permissions incorrectes sur les volumes
- Variable d'environnement manquante dans le `.env`
- Port déjà utilisé par un autre processus
- Espace disque insuffisant

### Vérifier l'état de tous les containers
```bash
cd /opt/hub_multimedia && docker compose ps
```

### Vérifier la santé de tous les containers
```bash
docker ps --format "table {{.Names}}\t{{.Status}}"
```

### Tout redémarrer proprement
```bash
cd /opt/hub_multimedia
docker compose down
docker compose up -d
```

### Redémarrer un seul service et ses dépendances
```bash
cd /opt/hub_multimedia
docker compose up -d --force-recreate <nom_du_service>
```

### Libérer de l'espace disque
```bash
docker system prune -af
```
> ⚠️ Supprime toutes les images, volumes et caches non utilisés.

Pour voir l'espace utilisé par Docker :
```bash
docker system df
```

### Un container affiche « unhealthy »
- Consulte les résultats du healthcheck :
  ```bash
  docker inspect <nom_du_container> --format='{{json .State.Health}}' | python3 -m json.tool
  ```
- Vérifie que le service à l'intérieur du container répond :
  ```bash
  docker exec <nom_du_container> curl -f http://localhost:<port>/ping
  ```
- Si le container est unhealthy mais fonctionne, le healthcheck est peut-être mal configuré

### Voir la consommation de ressources en temps réel
```bash
docker stats
```

### Limiter la taille des logs Docker
Si les logs deviennent trop volumineux, configure la rotation dans `/etc/docker/daemon.json` :
```json
{
## 🎵 Lidarr / Musique
  "log-driver": "json-file",
### Lidarr démarre mais la WebUI n'est pas accessible
- Vérifie que l'adresse IP est correcte : `http://172.19.0.7:8686`
- Lidarr s'exécute sur le port 8686. Vérifie le status :
  ```bash
  docker ps | grep lidarr
  ```
- Si le container est `unhealthy`, vérifie les logs :
  ```bash
  docker logs lidarr --tail 30
  ```
  "log-opts": {
### Lidarr ne trouve pas d'artistes/albums
- Vérifie que Prowlarr est connecté et synchronisé avec Lidarr
- Configuration en Sonarr/Radarr : Settings → Apps - Ajoute Prowlarr comme source d'indexers
- Pour récupérer de la musique, configure un client de téléchargement (qBittorrent) dans Lidarr
    "max-size": "10m",
### Les fichiers de musique ne sont pas détectés
- Vérifie que les dossiers `/data` et `/data2` sont correctement accessibles dans Lidarr
- Ajoute un chemin racine (Root Folder) pointant vers `/data/music` ou `/data2/music`
- Vérifie les permissions sur les fichiers de musique :
  ```bash
  ls -la /data/music
  ```
    "max-file": "3"
  }
}
```
Puis redémarre Docker : `sudo systemctl restart docker`

---

## 📁 Permissions

### Erreur de permissions sur les fichiers
- Vérifie que PUID et PGID sont corrects dans le `.env` (doivent correspondre à l'utilisateur propriétaire des fichiers)
- Vérifie ton UID/GID actuel :
  ```bash
  id
  ```
- Réapplique les droits :
  ```bash
  sudo chown -R 1000:1000 /app
  sudo chown -R 1000:1000 /data
  sudo chown -R 1000:1000 /data2
  ```

### Un service ne peut pas écrire dans son dossier de configuration
- Vérifie les permissions du dossier `/app/<service>/config` :
  ```bash
  ls -la /app/<service>/config/
  ```
- Corrige si nécessaire :
  ```bash
  sudo chown -R 1000:1000 /app/<service>/config
  sudo chmod -R 755 /app/<service>/config
  ```

### Les fichiers téléchargés n'ont pas les bonnes permissions
- Vérifie les valeurs PUID/PGID dans chaque service du docker-compose
- Tous les services doivent utiliser le même PUID/PGID pour éviter les conflits
- Vérifie le umask dans qBittorrent : Tools → Options → Downloads → Default Save Path

---

## 🌐 Réseau

### Conflit d'adresses IP
Si un container refuse de démarrer avec une erreur d'IP :
- Vérifie qu'aucune autre stack Docker n'utilise le subnet `172.19.0.0/24`
- Liste les réseaux : `docker network ls`
- Inspecte un réseau : `docker network inspect network_hub_multimedia`
- Si conflit, supprime le réseau orphelin :
  ```bash
  docker network rm <nom_du_réseau>
  ```

### Un port est déjà utilisé
Si un container refuse de démarrer avec « port already in use » :
- Identifie le processus qui utilise le port :
  ```bash
  sudo ss -tlnp | grep <port>
  ```
- Arrête le processus ou change le port dans le docker-compose

### Les containers ne se voient pas entre eux
- Vérifie que les containers sont sur le même réseau Docker :
  ```bash
  docker network inspect network_hub_multimedia
  ```
- Teste la connectivité :
  ```bash
  docker exec sonarr ping -c 2 172.19.0.5
  ```
- Exception : Plex est en mode `host` et n'est pas sur le réseau Docker. Les autres containers doivent utiliser l'IP du serveur pour le joindre.

### Problèmes de résolution DNS dans les containers
- Vérifie le DNS dans un container :
  ```bash
  docker exec <nom_du_container> cat /etc/resolv.conf
  ```
- Si la résolution échoue, ajoute un DNS personnalisé dans le docker-compose :
  ```yaml
  dns:
    - 1.1.1.1
    - 8.8.8.8
  ```

---

## 💾 Sauvegarde & Restauration

### Créer une sauvegarde
Le script de sauvegarde automatique est disponible :
```bash
sudo bash /opt/hub_multimedia/auto_deploy/save_hub.sh
```
Les sauvegardes sont stockées dans `/opt/backups/hub_multimedia/`.

### Restaurer une sauvegarde
```bash
sudo bash /opt/hub_multimedia/not_check_in_test/restore_hub.sh
```
Le script affiche les sauvegardes disponibles et te permet de choisir laquelle restaurer.

> ⚠️ La restauration écrase les configurations actuelles. Assure-toi de faire une sauvegarde avant si nécessaire.

### La sauvegarde échoue
- Vérifie l'espace disque disponible dans `/opt/backups/` :
  ```bash
  df -h /opt/backups/
  ```
- Vérifie les permissions : le script doit être exécuté en `root` (ou avec `sudo`)
- Vérifie que le dossier de sauvegarde existe :
  ```bash
  sudo mkdir -p /opt/backups/hub_multimedia
  ```

### Automatiser les sauvegardes avec cron
```bash
sudo crontab -e
```
Ajoute cette ligne pour une sauvegarde quotidienne à 3h du matin :
```
0 3 * * * /bin/bash /opt/hub_multimedia/auto_deploy/save_hub.sh >> /var/log/hub_backup.log 2>&1
```

---

## 🔄 Mise à jour du Hub

### Mettre à jour tous les containers
```bash
sudo bash /opt/hub_multimedia/not_check_in_test/update_hub.sh
```
Le script fait automatiquement :
1. Une sauvegarde préventive
2. Le téléchargement des nouvelles images (`docker compose pull`)
3. Le redéploiement des containers
4. Le nettoyage des anciennes images

### Mettre à jour un seul service
```bash
cd /opt/hub_multimedia
docker compose pull <nom_du_service>
docker compose up -d <nom_du_service>
```

### Un service ne fonctionne plus après mise à jour
- Consulte les logs pour identifier l'erreur :
  ```bash
  docker logs <nom_du_service> --tail 50
  ```
- Vérifie si une migration de base de données est nécessaire (fréquent avec Sonarr/Radarr/Prowlarr)
- En dernier recours, restaure la sauvegarde faite avant la mise à jour :
  ```bash
  sudo bash /opt/hub_multimedia/not_check_in_test/restore_hub.sh
  ```

---

## 📝 Logs & Debugging avancé

### Voir les logs en temps réel
```bash
docker logs -f <nom_du_container>
```

### Voir les logs de tous les containers simultanément
```bash
cd /opt/hub_multimedia && docker compose logs -f --tail 20
```

### Filtrer les logs par niveau d'erreur
```bash
docker logs <nom_du_container> 2>&1 | grep -i "error\|fatal\|critical"
```

### Entrer dans un container pour debugger
```bash
docker exec -it <nom_du_container> /bin/bash
```
> Si `/bin/bash` n'est pas disponible, essaie `/bin/sh`.

### Inspecter la configuration complète d'un container
```bash
docker inspect <nom_du_container>
```

### Vérifier les variables d'environnement d'un container
```bash
docker exec <nom_du_container> env
```

### Vérifier la connectivité réseau depuis un container
```bash
docker exec <nom_du_container> wget -qO- https://ipinfo.io
```
