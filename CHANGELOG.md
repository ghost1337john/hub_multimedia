# 🗂️ Historique des versions

### **v1.4.2 — 2026‑03‑26**
- Ajout de la mention de la documentation anglaise en haut du README principal  
- Ajout des instructions de configuration WireGuard dans les prérequis de l'autoscript (`french_docs/` et `english_docs/`)  

### **v1.4.1 — 2026‑03‑26**
- Réorganisation de la documentation française dans le dossier `french_docs/`  
- 18 fichiers Markdown copiés dans la structure miroir `french_docs/`  

### **v1.4.0 — 2026‑03‑26**
- Ajout de la traduction complète du projet en anglais (dossier `english_docs/`)  
- 18 fichiers Markdown traduits : README, CHANGELOG, tutoriels, FAQ, scripts, diagramme  

### **v1.3.9 — 2026‑03‑26**
- Mise à jour des recommandations matérielles dans `README_HOWTOINSTALL.md` : config minimale et recommandée, note sur le transcodage Plex  
- Mise à jour des prérequis dans `auto_deploy/README_AUTOSCRIPT.md` : ajout des mêmes recommandations  

### **v1.3.8 — 2026‑03‑26**
- Suppression de l'historique des versions du README principal, redirection vers `CHANGELOG.md`  
- Ajout du tutoriel de configuration Plex (`tuto_config/README_PLEX_CONFIG.md`)  

### **v1.3.7 — 2026‑03‑26**
- Extraction de l'historique des versions dans un fichier dédié (`CHANGELOG.md`)  

### **v1.3.6 — 2026‑03‑26**
- Mise à jour de la FAQ : ajout de la section Portainer  
- Mise à jour du README `not_check_in_test` : statut d'intégration de Portainer et des healthchecks  
- Ajout du fichier `README_SOURCES.md` : crédits et processus de contribution humain / IA  

### **v1.3.5 — 2026‑03‑26**
- Ajout du container **Portainer** dans le docker‑compose avec healthcheck  
- Ajout de Portainer dans la liste des services du README principal  
- Mise à jour du `README_HOWTOINSTALL.md` : arborescence, mkdir, tableau des accès  
- Mise à jour du script de déploiement (`autoscript_install_hub_on_debian.sh`) : ajout de Portainer  
- Ajout du tutoriel de configuration Portainer (`tuto_config/README_PORTAINER_CONFIG.md`)  

### **v1.3.4 — 2026‑03‑26**
- Ajout des healthchecks manquants dans le docker‑compose : Prowlarr, Sonarr, Radarr, Bazarr, Tautulli et Plex  
- Ajout des variables `PUID` et `PGID` dans le fichier `sources/.env`  

### **v1.3.3 — 2026‑03‑26**
- Ajout du README de la procédure de sauvegarde (`auto_deploy/README_SAVE_HUB.md`)  

### **v1.3.2 — 2026‑03‑26**
- Ajout du README de l'autoscript (`auto_deploy/README_AUTOSCRIPT.md`)  
- Ajout d'une mention de l'installation automatique en haut du `README_HOWTOINSTALL.md`  

### **v1.3.1 — 2026‑03‑26**
- Ajout du volume config pour **FlareSolverr** dans le docker‑compose  
- Mise à jour du `README_HOWTOINSTALL.md` : ajout de Plex, Tautulli et FlareSolverr dans l'arborescence, le mkdir et le tableau des accès  
- Suppression du fichier `README_PLEX_INSTALL.md` (redondant)  
- Renommage du dossier `test/` en `auto_deploy/`  
- Réécriture complète du script de déploiement (`autoscript_install_hub_on_debian.sh`) pour Debian 13  
- Réécriture du script de sauvegarde (`save_hub.sh`) : sauvegarde des configs des 11 containers, rotation automatique, vérification root  

### **v1.3.0 — 2026‑03‑26**
- Ajout du container **Plex** dans le docker‑compose et le README principal  
- Ajout du container **Tautulli** dans le docker‑compose  
- Ajout du tutoriel de configuration Tautulli (`tuto_config/README_TAUTULLI_CONFIG.md`)  
- Intégration de Plex dans la liste des services du README  

### **v1.2.2 — 2026‑03‑26**
- Ajout du module **Tautulli** dans le README principal  
- Description du service et rôle dans l'écosystème Plex  

### **v1.2.1 — 2026‑03‑26**
- Ajout d'une note globale expliquant que les tutoriels sont volontairement simplifiés  
- Réécriture complète des tutoriels : Sonarr, Radarr, Bazarr, Prowlarr, Seerr et CleanUpArr  
- Harmonisation du style et de la structure de tous les fichiers du dossier `tuto_config`  
- Clarification générale du README principal  
- Amélioration de la cohérence globale du projet
  
### **v1.2.0 — 2026‑03‑26**
- Ajout du disclaimer légal concernant l'usage du projet
- Mise à jour du README principal (clarification + conformité)
- Actualisation de la documentation Sonarr (procédure, configuration, cohérence globale) 
- Amélioration de la cohérence globale du projet
- Ajustements mineurs sur la présentation des services  

### **v1.1.0 — 2026‑03‑25**
- Ajout du module **Cleanuparr**  
- Documentation complète ajoutée (installation + configuration)  
- Mise à jour du README principal  
- Amélioration de la cohérence globale du projet  

### **v1.0.0 — 2026‑03-24**
- Ajout de Seerr  
- Documentation dédiée + schéma visuel  
- Intégration complète avec Radarr/Sonarr

### **v0.9.0 — 2026‑03-23**
- Version initiale du hub multimédia  
- Radarr, Sonarr, Prowlarr, qBittorrent, Gluetun, Bazarr, FlareSolverr  
- Documentation d'installation et de configuration
