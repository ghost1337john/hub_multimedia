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

```text
Utilisateur → Seerr
        ↓
Radarr / Sonarr
        ↓
    Prowlarr
        ↓
   FlareSolverr (si Cloudflare)
        ↓
   qBittorrent → Gluetun (VPN)
        ↓
Téléchargement → Tri → Sous‑titres (Bazarr)
        ↓
            Plex

flowchart LR
    %% STYLE MATERIAL DESIGN
    classDef block fill:#ffffff,stroke:#90a4ae,stroke-width:2px,color:#37474f,rx:8px,ry:8px;
    classDef highlight fill:#e3f2fd,stroke:#64b5f6,stroke-width:2px,color:#0d47a1,rx:8px,ry:8px;

    A([👤 Utilisateur]):::block --> B([📬 Seerr]):::highlight
    B --> C([📺 Sonarr]):::block
    B --> D([🎬 Radarr]):::block

    C --> E([🧭 Prowlarr]):::highlight
    D --> E

    E --> F([🛡️ FlareSolverr<br/>(Cloudflare)]):::block

    F --> G([🔽 qBittorrent]):::highlight
    G --> H([🔐 Gluetun VPN]):::block

    H --> I([📥 Téléchargement]):::block
    I --> J([🗂️ Tri & Organisation]):::block
    J --> K([💬 Bazarr<br/>(Sous‑titres)]):::highlight

    K --> L([🎞️ Plex<br/>(Bibliothèque)]):::block
