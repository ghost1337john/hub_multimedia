📝 Version
v1.1.0 — 2026‑03‑25
Ajout du module Cleanuparr

Documentation complète ajoutée (installation + configuration + résolution SQLite Error 5)

Mise à jour du README principal

Amélioration de la cohérence globale du projet

v1.0.0 — 2026‑02
Ajout de Seerr

Documentation dédiée + schéma visuel

Intégration complète avec Radarr/Sonarr

v0.9.0 — 2026‑01
Version initiale du hub multimédia

Radarr, Sonarr, Prowlarr, qBittorrent, Gluetun, Bazarr, FlareSolverr

Documentation d’installation et de configuration

# 🎬 Hub Multimédia Automatisé

Ce projet met en place un écosystème multimédia complet, automatisé et sécurisé, basé sur Docker avec possibilité de le déployer via Portainer.
Il gère le téléchargement, l’organisation, les sous‑titres, les demandes utilisateurs et la sécurité réseau via VPN.

---

## 🧩 Services inclus

### 🔐 Gluetun — VPN + Firewall
Gluetun assure la sécurité du réseau en encapsulant qBittorrent, Prowlarr et FlareSolverr dans un tunnel VPN.

### 🧲 qBittorrent — Téléchargement sécurisé
Client torrent fonctionnant **exclusivement via Gluetun**.

### 🧭 Prowlarr — Gestionnaire d’indexers
Centralise et synchronise les indexers pour Radarr et Sonarr.

### 📺 Sonarr — Séries automatisées
Gère la recherche, le téléchargement et l’organisation des séries.

### 🎬 Radarr — Films automatisés
Même fonctionnement que Sonarr, mais pour les films.

### 💬 Bazarr — Sous‑titres automatiques
Télécharge et gère les sous‑titres pour Radarr et Sonarr.

### ⭐ Seerr — Interface de demandes utilisateurs
Permet aux utilisateurs de demander films et séries.

### 🛡️ FlareSolverr — Contournement Cloudflare
Proxy permettant à Prowlarr d’accéder aux indexers protégés.

🧹 Cleanuparr — Nettoyage automatisé
Nouveau module permettant :

le nettoyage des téléchargements terminés

la suppression des torrents importés

la gestion des fichiers orphelins

la synchronisation propre avec Radarr/Sonarr

la résolution des conflits de DB SQLite

## 🔗 Flux de fonctionnement

<img width="1426" height="5475" alt="User-Centric Media Download-2026-03-25-152838" src="https://github.com/user-attachments/assets/5af8e1f6-3cfd-4233-93e5-07bf50f34e83" />

