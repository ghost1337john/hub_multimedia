# 🧪 Not Check In Test — Améliorations en cours de validation

Ce dossier contient des fichiers et scripts **non encore intégrés** au projet principal.  
Ils doivent être testés et validés avant d'être déplacés dans les dossiers de production (`sources/`, `auto_deploy/`, `tuto_config/`).

---

## 📁 Contenu du dossier

### 🐳 `docker_compose_extras.yml`
Containers supplémentaires prêts à être ajoutés au docker-compose principal :

| Container    | Rôle                                                        | Port  | Statut     |
|--------------|-------------------------------------------------------------|-------|------------|
| Portainer    | Gestion des containers Docker via une WebUI                 | 9000  | ✅ Intégré  |
| Watchtower   | Mise à jour automatique des images Docker + notifications   | —     | En test    |
| Uptime Kuma  | Monitoring de disponibilité des services avec alertes       | 3001  | En test    |
| Lidarr       | Gestion automatisée de la musique (équivalent Sonarr/Radarr)| 8686  | En test    |
| Readarr      | Gestion automatisée des ebooks                              | 8787  | En test    |
| Recyclarr    | Synchronisation des profils qualité TRaSH Guides            | —     | En test    |

---

### 🩺 `healthchecks_to_add.yml`
Blocs de healthchecks pour les containers existants.  
**✅ Intégrés** dans le docker-compose principal (v1.3.4).

---

### 🔑 `.env.example`
Template du fichier `.env` avec toutes les variables nécessaires au déploiement.  
L'utilisateur n'a qu'à copier ce fichier et remplir ses propres valeurs.  
Destiné à être versionné dans le dépôt (contrairement au `.env` réel qui ne doit jamais être commité).

---

### 🔄 `restore_hub.sh`
Script interactif de restauration des configurations :
- Liste les sauvegardes disponibles avec leur taille
- Menu de sélection numéroté
- Demande de confirmation avant écrasement
- Arrêt des containers → extraction de l'archive → redémarrage

Complète le script `save_hub.sh` existant dans `auto_deploy/`.

---

### 🔄 `update_hub.sh`
Script de mise à jour automatique des containers :
- Exécute une sauvegarde préventive avant toute modification
- Télécharge les dernières images Docker (`docker compose pull`)
- Redéploie les containers avec les nouvelles versions
- Nettoie les anciennes images inutilisées
- Affiche l'état final des containers

---

### ❓ `README_FAQ.md`
FAQ et guide de dépannage couvrant les problèmes courants :
- VPN / Gluetun (connexion, port forwarding)
- Plex (découverte réseau, fichiers, claim token)
- qBittorrent (mot de passe, vitesse)
- Prowlarr / Indexers (Cloudflare, synchronisation)
- Bazarr / Sous-titres
- Tautulli (connexion Plex)
- Docker (redémarrage, logs, espace disque)
- Permissions et réseau

---

### 📊 `README_MERMAID_DIAGRAM.md`
Diagramme Mermaid du flux de fonctionnement complet du hub multimédia, incluant Tautulli.  
Rendu nativement par GitHub dans les fichiers Markdown.  
Destiné à remplacer l'image statique actuelle dans le README principal.

---

## 🗂️ Historique des versions (not_check_in_test)

### **v0.1.0 — 2026‑03‑26**
- Création du dossier `not_check_in_test`
- Ajout de `docker_compose_extras.yml` : Portainer, Watchtower, Uptime Kuma, Lidarr, Readarr, Recyclarr
- Ajout de `healthchecks_to_add.yml` : healthchecks pour Plex, Tautulli, Sonarr, Radarr, Bazarr, Prowlarr
- Ajout de `.env.example` : template des variables d'environnement
- Ajout de `restore_hub.sh` : script de restauration interactif
- Ajout de `update_hub.sh` : script de mise à jour avec sauvegarde préventive
- Ajout de `README_FAQ.md` : FAQ et troubleshooting complet
- Ajout de `README_MERMAID_DIAGRAM.md` : diagramme Mermaid du flux avec Tautulli

---

## 📌 Processus de validation

1. Tester chaque fichier sur un environnement de dev
2. Vérifier la compatibilité avec le docker-compose principal
3. Une fois validé, déplacer le fichier dans le dossier approprié
4. Mettre à jour le README principal et l'historique de versions
