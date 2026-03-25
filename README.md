# 🎬 Hub Multimédia Automatisé

Ce projet met en place un écosystème multimédia complet, automatisé et sécurisé, basé sur Docker.  
Il gère le téléchargement, l’organisation, les sous‑titres, les demandes utilisateurs et la sécurité réseau via VPN.

---

## 🧩 Services inclus

### 🔐 Gluetun — VPN + Firewall
Gluetun assure la sécurité du réseau en encapsulant qBittorrent, Prowlarr et FlareSolverr dans un tunnel VPN.

**Fonctionnalités :**
- VPN ProtonVPN (WireGuard)
- Killswitch intégré
- Port forwarding automatique
- Filtrage anti‑malware
- Exposition contrôlée des ports nécessaires

---

### 🧲 qBittorrent — Téléchargement sécurisé
Client torrent fonctionnant **exclusivement via Gluetun**.

**Caractéristiques :**
- Interface Web : `:8080`
- Téléchargements dans `${MEDIA_DIR}/qbittorrent/downloads`
- Healthcheck intégré
- Aucune fuite IP possible

---

### 🧭 Prowlarr — Gestionnaire d’indexers
Centralise et synchronise les indexers pour Radarr et Sonarr.

**Points clés :**
- Fonctionne derrière Gluetun
- Port exposé : `9696`
- Support FlareSolverr pour contourner Cloudflare

---

### 📺 Sonarr — Séries automatisées
Gère la recherche, le téléchargement et l’organisation des séries.

**Accès :** `:8989`

---

### 🎬 Radarr — Films automatisés
Même fonctionnement que Sonarr, mais pour les films.

**Accès :** `:7878`

---

### 💬 Bazarr — Sous‑titres automatiques
Télécharge et gère les sous‑titres pour Radarr et Sonarr.

**Accès :** `:6767`

---

### ⭐ Seerr — Interface de demandes utilisateurs
Permet aux utilisateurs de demander films et séries.

**Accès :** `:5055`

---

### 🛡️ FlareSolverr — Contournement Cloudflare
Proxy permettant à Prowlarr d’accéder aux indexers protégés.

**Accès :** `:8191`

---

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
