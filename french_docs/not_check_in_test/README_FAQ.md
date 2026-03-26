# ❓ FAQ & Troubleshooting — Hub Multimédia

---

## 🔐 VPN / Gluetun

### Le VPN ne se connecte pas
- Vérifie que ta clé WireGuard est correcte dans le `.env`
- Vérifie que ton compte ProtonVPN supporte le port forwarding (plan payant requis)
- Consulte les logs : `docker logs gluetun`
- Vérifie que le device `/dev/net/tun` existe sur ton serveur

### qBittorrent / Prowlarr / FlareSolverr sont inaccessibles
Ces services passent par Gluetun (`network_mode: service:gluetun`). Si le VPN est down, ils sont inaccessibles.
- Vérifie l'état de Gluetun : `docker ps | grep gluetun`
- Redémarre le VPN : `docker restart gluetun`

### Le port forwarding ne fonctionne pas
- Vérifie que tu as ajouté `+pmp` à la fin de ton `OPENVPN_USER` dans le `.env`
- Vérifie que `VPN_PORT_FORWARDING=on` est bien dans le docker-compose

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

> 💡 Si la connexion VPN est down, tous les services qui passent par Gluetun (qBittorrent, Prowlarr, FlareSolverr) seront inaccessibles.

---

## 📺 Plex

### Plex n'est pas trouvé sur le réseau local
- Plex utilise `network_mode: host`, il doit être accessible directement via l'IP du serveur sur le port 32400
- Vérifie que le port 32400 n'est pas bloqué par un firewall : `sudo ufw status`
- Vérifie les logs : `docker logs plex`

### Plex ne voit pas mes fichiers
- Vérifie que les volumes `/data` et `/data2` sont correctement montés dans le fstab
- Vérifie les permissions : `ls -la /data/` (doit appartenir à 1000:1000)
- Dans Plex, ajoute les bibliothèques en pointant vers `/movies` ou `/series` (les chemins internes au container)

### Le claim token a expiré
- Récupère un nouveau token sur https://plex.tv/claim
- Ajoute-le dans le docker-compose : `PLEX_CLAIM=claim-xxxxx`
- Redéploie : `docker compose up -d plex`

---

## 🧲 qBittorrent

### Le mot de passe par défaut ne fonctionne pas
Au premier lancement, qBittorrent génère un mot de passe aléatoire.
- Consulte les logs : `docker logs qbittorrent`
- Cherche la ligne contenant `temporary password`

### Les téléchargements sont lents
- Vérifie que le port forwarding VPN est actif : `docker logs gluetun | grep "port forwarded"`
- Vérifie les paramètres de connexion dans qBittorrent WebUI

---

## 🧭 Prowlarr / Indexers

### Les indexers échouent avec des erreurs Cloudflare
- Vérifie que FlareSolverr est démarré : `docker ps | grep flaresolverr`
- Dans Prowlarr, configure FlareSolverr comme proxy (Settings → Indexers → Add FlareSolverr tag)

### Prowlarr ne synchronise pas avec Sonarr/Radarr
- Vérifie les clés API dans Prowlarr (Settings → Apps)
- Les adresses doivent utiliser les IPs du réseau Docker (ex : `172.19.0.6` pour Sonarr)

---

## 💬 Bazarr / Sous-titres

### Bazarr ne trouve pas de sous-titres
- Vérifie que les providers sont configurés (Settings → Providers)
- Certains providers nécessitent un compte (OpenSubtitles, Addic7ed)
- Vérifie la connexion avec Sonarr/Radarr (Settings → Sonarr / Settings → Radarr)

---

## 📊 Tautulli

### Tautulli ne voit pas l'activité Plex
- Vérifie la connexion à Plex dans Settings → Plex Media Server
- L'adresse doit être l'IP du serveur (pas localhost, car Tautulli n'est pas en host mode)
- Port : 32400

---

## 🐳 Portainer

### Impossible de créer le compte administrateur
Portainer se verrouille automatiquement si le compte admin n'est pas créé dans les premières minutes.
- Redémarre le container : `docker restart portainer`
- Accède immédiatement à `http://IP_DU_SERVEUR:9000` pour créer le compte

### Portainer ne voit pas les containers
- Vérifie que le socket Docker est bien monté : `/var/run/docker.sock:/var/run/docker.sock`
- Vérifie les permissions sur le socket : `ls -la /var/run/docker.sock`
- Consulte les logs : `docker logs portainer`

### Impossible de déployer une stack depuis Portainer
- Vérifie que le fichier docker-compose est valide (pas d'erreurs de syntaxe YAML)
- Vérifie que toutes les variables du `.env` sont renseignées
- Consulte les logs dans Portainer : container → Logs

---

## 🐳 Docker général

### Un container redémarre en boucle
```bash
docker logs <nom_du_container>
docker inspect <nom_du_container> | grep -i status
```

### Vérifier l'état de tous les containers
```bash
cd /opt/hub_multimedia && docker compose ps
```

### Tout redémarrer proprement
```bash
cd /opt/hub_multimedia
docker compose down
docker compose up -d
```

### Libérer de l'espace disque
```bash
docker system prune -af
```
> ⚠️ Supprime toutes les images, volumes et caches non utilisés.

---

## 📁 Permissions

### Erreur de permissions sur les fichiers
- Vérifie que PUID et PGID sont corrects dans le `.env` (doivent correspondre à l'utilisateur propriétaire des fichiers)
- Réapplique les droits :
```bash
sudo chown -R 1000:1000 /app
sudo chown -R 1000:1000 /data
sudo chown -R 1000:1000 /data2
```

---

## 🌐 Réseau

### Conflit d'adresses IP
Si un container refuse de démarrer avec une erreur d'IP :
- Vérifie qu'aucune autre stack Docker n'utilise le subnet `172.19.0.0/24`
- Liste les réseaux : `docker network ls`
- Inspecte un réseau : `docker network inspect network_hub_multimedia`
