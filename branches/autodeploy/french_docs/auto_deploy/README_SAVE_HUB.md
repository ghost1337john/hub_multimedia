# 💾 Mise en place de la sauvegarde automatique du Hub Multimédia

Ce guide explique comment utiliser et automatiser le script `save_hub.sh` pour sauvegarder les configurations de tous les containers du hub multimédia sur Debian.

---

## 🧩 Prérequis

- Le hub multimédia déployé et fonctionnel (via l'autoscript ou manuellement)
- Un accès **root** ou **sudo**
- Les containers configurés via leurs WebUI respectives

---

## 📋 Ce que sauvegarde le script

Le script archive les configurations des **11 containers** :

| Container     | Dossier sauvegardé               |
|---------------|----------------------------------|
| Gluetun       | `/app/gluetun/config`            |
| qBittorrent   | `/app/qbittorrent/config`        |
| Prowlarr      | `/app/prowlarr/config`           |
| Sonarr        | `/app/sonarr/config`             |
| Radarr        | `/app/radarr/config`             |
| Bazarr        | `/app/bazarr/config`             |
| Seerr         | `/app/seerr/config`              |
| FlareSolverr  | `/app/flaresolverr/config`       |
| Cleanuparr    | `/app/cleanuparr/config`         |
| Tautulli      | `/app/tautulli/config`           |
| Plex          | `/app/plex/config`               |

Il sauvegarde également le `docker-compose.yml` et le `.env` depuis `/opt/hub_multimedia/`.

---

## 🚀 Utilisation manuelle

```bash
sudo bash /chemin/vers/auto_deploy/save_hub.sh
```

Le script va :
1. Vérifier les droits root
2. Vérifier l'existence de chaque dossier de configuration
3. Arrêter proprement les containers
4. Créer une archive `.tar.gz` horodatée dans `/opt/backups/hub_multimedia/`
5. Redémarrer les containers
6. Supprimer les anciennes sauvegardes au-delà des 5 dernières

---

## ⏰ Automatisation avec cron

Pour planifier une sauvegarde automatique, ajoute une tâche cron :

```bash
sudo crontab -e
```

Exemples de planification :

**Tous les jours à 3h du matin :**
```
0 3 * * * /chemin/vers/auto_deploy/save_hub.sh >> /var/log/save_hub.log 2>&1
```

**Tous les dimanches à 4h du matin :**
```
0 4 * * 0 /chemin/vers/auto_deploy/save_hub.sh >> /var/log/save_hub.log 2>&1
```

> 💡 Remplace `/chemin/vers/` par le chemin réel du dépôt sur ton serveur (ex : `/home/plex/hub_multimedia/`).

---

## 📂 Emplacement des sauvegardes

Les archives sont stockées dans :

```
/opt/backups/hub_multimedia/
```

Nommées au format : `backup_YYYY-MM-DD_HH-MM.tar.gz`

Seules les **5 dernières** sauvegardes sont conservées (configurable via `MAX_BACKUPS` dans le script).

---

## 🔄 Restauration d'une sauvegarde

En cas de problème, pour restaurer une sauvegarde :

```bash
# 1. Arrêter les containers
cd /opt/hub_multimedia
sudo docker compose down

# 2. Extraire l'archive (depuis la racine /)
sudo tar -xzf /opt/backups/hub_multimedia/backup_YYYY-MM-DD_HH-MM.tar.gz -C /

# 3. Redémarrer les containers
sudo docker compose up -d
```

> ⚠️ Remplace `YYYY-MM-DD_HH-MM` par la date de la sauvegarde souhaitée.

---

## ⚠️ Notes importantes

- Le script **arrête les containers** pendant la sauvegarde pour garantir la cohérence des fichiers. Les services seront donc temporairement indisponibles.
- Planifie la sauvegarde cron à une heure creuse pour minimiser l'impact.
- Les **données médias** (films, séries) ne sont **pas sauvegardées** par ce script. Seules les configurations le sont.
- Pense à externaliser les archives (NAS, stockage distant) pour une protection complète.
