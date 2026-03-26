⚠️ Disclaimer — Responsabilité
L’auteur de ce projet ne peut être tenu responsable de l’usage qui en est fait.
Chaque utilisateur est entièrement responsable de s’assurer que son utilisation respecte les lois en vigueur dans son pays, notamment en matière de droit d’auteur.

Ce projet fournit uniquement une infrastructure technique destinée à la gestion de contenus obtenus légalement.
Toute utilisation visant à télécharger, partager ou accéder à des œuvres protégées sans autorisation est strictement interdite et se fait aux risques et périls de l’utilisateur.

# 🎬 Hub Multimédia Automatisé

Ce projet est destiné exclusivement à la gestion de contenus multimédias.
Il ne vise en aucun cas à encourager, faciliter ou contourner des mécanismes de protection liés au droit d’auteur.

🧩 Présentation
Ce hub multimédia propose un écosystème complet, automatisé et sécurisé, basé sur Docker (ou Portainer).
Il permet de gérer l’organisation, la récupération, les sous‑titres, les demandes utilisateurs et la sécurité réseau via VPN.

L’objectif : offrir une infrastructure moderne sécurisée, propre et centralisée pour vos bibliothèques multimédias personnelles.
---

## 🧩 Services inclus

### 🔐 Gluetun — VPN + Firewall
Assure la sécurité du réseau en encapsulant les services sensibles dans un tunnel VPN.

### 🧲 qBittorrent — Téléchargement sécurisé
Fonctionne uniquement via Gluetun pour garantir un trafic protégé.
(L’usage doit respecter les lois en vigueur et se limiter à des contenus dont vous possédez les droits.)

### 🧭 Prowlarr — Gestionnaire d’indexers
Centralise et synchronise les indexers pour Radarr et Sonarr.

### 📺 Sonarr — Séries automatisées
Gère la recherche, l’importation et l’organisation de séries.

### 🎬 Radarr — Films automatisés
Même fonctionnement que Sonarr, mais pour les films.

### 💬 Bazarr — Sous‑titres automatiques
Télécharge et gère les sous‑titres pour Radarr et Sonarr.

### ⭐ Seerr — Interface de demandes utilisateurs
Permet aux utilisateurs de demander films et séries déjà présents ou à importer.

### � Tautulli — Surveillance et statistiques Plex
Fournit un tableau de bord complet pour surveiller l’activité Plex, l’usage des médias, les historiques de lecture et les alertes.

### �🛡️ FlareSolverr — Contournement Cloudflare
Proxy permettant à Prowlarr d’accéder aux indexers protégés.

### 🧹 Cleanuparr — Nettoyage automatisé  
Nouveau module permettant :  
- le nettoyage des synchronisations terminées  
- la suppression des torrents importés  
- la gestion des fichiers orphelins  
- la synchronisation propre avec Radarr/Sonarr

# 📝 Note sur la configuration des services
Afin de garder ce projet simple, évolutif et indépendant des préférences de chacun, je ne détaillerai pas la configuration spécifique de chaque service (Sonarr, Radarr, Prowlarr, qBittorrent, etc.).
Chaque utilisateur est libre d’adapter l’écosystème à ses besoins et peut facilement trouver des guides complets en effectuant une recherche internet pour la configuration de chaque outil.

## 🔗 Flux de fonctionnement

<img width="1104" height="976" alt="Gemini_Generated_Image_6wk7c16wk7c16wk7" src="https://github.com/user-attachments/assets/22c30f5e-73c1-4058-818d-5de3192acc97" />

# 🗂️ Historique des versions

### **v1.2.2 — 2026‑03‑26**
- Ajout du module **Tautulli** dans le README principal  
- Description du service et rôle dans l’écosystème Plex  

### **v1.2.1 — 2026‑03‑26**
- Ajout d’une note globale expliquant que les tutoriels sont volontairement simplifiés  
- Réécriture complète des tutoriels : Sonarr, Radarr, Bazarr, Prowlarr, Seerr et CleanUpArr  
- Harmonisation du style et de la structure de tous les fichiers du dossier `tuto_config`  
- Clarification générale du README principal  
- Amélioration de la cohérence globale du projet
  
### **v1.2.0 — 2026‑03‑26**
- Ajout du disclaimer légal concernant l’usage du projet
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
- Documentation d’installation et de configuration

