> 🌍 **English documentation available** — The full documentation is also available in English in the [`english_docs/`](english_docs/) folder.

⚠️ Disclaimer — Responsabilité
L'auteur de ce projet ne peut être tenu responsable de l'usage qui en est fait.
Chaque utilisateur est entièrement responsable de s'assurer que son utilisation respecte les lois en vigueur dans son pays, notamment en matière de droit d'auteur.

Ce projet fournit uniquement une infrastructure technique destinée à la gestion de contenus obtenus légalement.
Toute utilisation visant à télécharger, partager ou accéder à des œuvres protégées sans autorisation est strictement interdite et se fait aux risques et périls de l'utilisateur.

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

### 📺 Plex — Serveur multimédia
Permet de centraliser, organiser et diffuser vos films, séries et musiques sur tous vos appareils (TV, mobile, navigateur).

### 📊 Tautulli — Surveillance et statistiques Plex
Fournit un tableau de bord complet pour surveiller l’activité Plex, l’usage des médias, les historiques de lecture et les alertes.

### 🛡️ FlareSolverr — Contournement Cloudflare
Proxy permettant à Prowlarr d’accéder aux indexers protégés.

### 🐳 Portainer — Gestion des containers en WebUI
Interface graphique pour gérer, surveiller et administrer l'ensemble des containers Docker depuis un navigateur.

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

Consulte le fichier [`CHANGELOG.md`](CHANGELOG.md) pour l'historique complet des versions.


