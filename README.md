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

## 🔗 Flux de fonctionnement

<img width="1426" height="5475" alt="User-Centric Media Download-2026-03-25-152838" src="https://github.com/user-attachments/assets/5af8e1f6-3cfd-4233-93e5-07bf50f34e83" />

