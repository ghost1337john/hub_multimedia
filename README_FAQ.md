# ❓ FAQ & Troubleshooting — Hub Multimédia

---

## 📋 Sommaire

- [🚀 Diagnostic rapide](#-diagnostic-rapide)
- [🔐 VPN / Gluetun](#-vpn--gluetun)
- [📺 Plex](#-plex)
- [🧲 qBittorrent](#-qbittorrent)
- [🧭 Prowlarr / Indexers](#-prowlarr--indexers)
- [🌐 FlareSolverr](#-flaresolverr)
- [📺 Sonarr / Séries TV](#-sonarr--séries-tv)
- [🎬 Radarr / Films](#-radarr--films)
- [💬 Bazarr / Sous-titres](#-bazarr--sous-titres)
- [🎵 Lidarr / Musique](#-lidarr--musique)
- [🎬 Seerr / Demandes](#-seerr--demandes)
- [🧹 Cleanuparr](#-cleanuparr)
- [📊 Tautulli](#-tautulli)
- [🐳 Portainer](#-portainer)
- [🐳 Docker général](#-docker-général)
- [📁 Permissions](#-permissions)
- [🌐 Réseau](#-réseau)
- [💾 Sauvegarde & Restauration](#-sauvegarde--restauration)
- [🔄 Mise à jour du Hub](#-mise-à-jour-du-hub)
- [📝 Logs & Debugging avancé](#-logs--debugging-avancé)

---

## 🚀 Diagnostic rapide

Avant de chercher un problème spécifique, lance ces commandes pour avoir une vue d'ensemble :

### Vérifier l'état de tous les containers
```bash
cd /opt/hub_multimedia && docker compose ps
```
Les containers sains affichent `Up (healthy)`. Un container `unhealthy` ou `restarting` indique un problème.

### Vérifier les containers qui consomment trop de ressources
```bash
docker stats --no-stream
```

### Vérifier l'espace disque disponible
```bash
df -h /data /data2 /app
```
> ⚠️ Si un disque est plein à plus de 95%, les containers peuvent dysfonctionner (échecs d'écriture, crash, corruption de données).

### Vérifier les logs récents d'un container en erreur
```bash
docker logs --tail 50 <nom_du_container>
```

### Tester la connectivité réseau entre containers
```bash
docker exec sonarr ping -c 2 172.19.0.5
```
