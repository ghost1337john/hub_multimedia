> 🌍 **English documentation available** — The full documentation is also available in English in the [`english_docs/`](english_docs/) folder.

---

> ⚠️ **Disclaimer — Responsabilité**
>
> L'auteur de ce projet ne peut être tenu responsable de l'usage qui en est fait.
> Chaque utilisateur est entièrement responsable de s'assurer que son utilisation respecte les lois en vigueur dans son pays, notamment en matière de droit d'auteur.
>
> Ce projet fournit uniquement une infrastructure technique destinée à la gestion de contenus **obtenus légalement**.
> Toute utilisation visant à télécharger, partager ou accéder à des œuvres protégées sans autorisation est **strictement interdite** et se fait aux risques et périls de l'utilisateur.

---

# 🎬 Hub Multimédia Automatisé

> *Un écosystème Docker complet, sécurisé et automatisé pour vos bibliothèques multimédias personnelles.*

![Docker](https://img.shields.io/badge/Docker-ready-2496ED?logo=docker&logoColor=white)
![Docker Compose](https://img.shields.io/badge/Docker%20Compose-v2-2496ED?logo=docker&logoColor=white)
![Plex](https://img.shields.io/badge/Plex-Media%20Server-E5A00D?logo=plex&logoColor=white)
![VPN](https://img.shields.io/badge/VPN-ProtonVPN-6D4AFF?logo=protonvpn&logoColor=white)
![License](https://img.shields.io/badge/Usage-Personnel%20uniquement-green)

Ce projet est destiné exclusivement à la gestion de contenus multimédias.
Il ne vise en aucun cas à encourager, faciliter ou contourner des mécanismes de protection liés au droit d'auteur.

---

## 📋 Table des matières

- [🧩 Présentation](#-présentation)
- [⚙️ Services inclus](#️-services-inclus)
- [🏗️ Architecture](#️-architecture)
- [🔗 Flux de fonctionnement](#-flux-de-fonctionnement)
- [🚀 Installation rapide](#-installation-rapide)
- [🛠️ Prérequis](#️-prérequis)
- [📁 Structure du projet](#-structure-du-projet)
- [🌿 Strategie Git](#-strategie-git)
- [📝 Note sur la configuration](#-note-sur-la-configuration)
- [❓ FAQ / Dépannage](#-faq--dépannage)
- [🗂️ Historique des versions](#️-historique-des-versions)

---

## 🧩 Présentation

Ce hub multimédia propose un **écosystème complet, automatisé et sécurisé**, basé sur Docker (ou Portainer).
Il permet de gérer l'organisation, la récupération, les sous‑titres, les demandes utilisateurs et la sécurité réseau via VPN.

**L'objectif :** offrir une infrastructure moderne, sécurisée, propre et centralisée pour vos bibliothèques multimédias personnelles.

---

## ⚙️ Services inclus

| # | Service | Rôle | Port |
|---|---------|------|------|
| 1 | 🔐 **Gluetun** | VPN + Firewall (tunnel ProtonVPN) | — |
| 2 | 🧲 **qBittorrent** | Téléchargement sécurisé via VPN | 8080 |
| 3 | 🧭 **Prowlarr** | Gestionnaire d'indexers centralisé | 9696 |
| 4 | 📺 **Sonarr** | Automatisation des séries TV | 8989 |
| 5 | 🎬 **Radarr** | Automatisation des films | 7878 |
| 6 | 💬 **Bazarr** | Sous‑titres automatiques | 6767 |
| 7 | ⭐ **Seerr** | Interface de demandes utilisateurs | 5055 |
| 8 | 📺 **Plex** | Serveur multimédia (streaming) | 32400 |
| 9 | 📊 **Tautulli** | Surveillance et statistiques Plex | 8181 |
| 10 | 🛡️ **FlareSolverr** | Contournement Cloudflare pour Prowlarr | 8191 |
| 11 | 🐳 **Portainer** | Gestion des containers en WebUI | 9000 |
| 12 | 🧹 **Cleanuparr** | Nettoyage automatisé des téléchargements | 11011 |

> 🔒 **qBittorrent**, **Prowlarr** et **FlareSolverr** utilisent `network_mode: service:gluetun` — ils partagent l'espace réseau du conteneur VPN.
>
> **Avantages de cette architecture :**
> - **Tout le trafic passe par le VPN** : ces services n'ont aucun accès direct à Internet, tout est routé à travers le tunnel WireGuard/OpenVPN.
> - **Kill switch automatique** : si le VPN tombe, ces services perdent toute connectivité — aucune fuite d'IP possible.
> - **Communication locale simplifiée** : les services qui partagent le même namespace réseau communiquent entre eux via `localhost` (ex : Prowlarr → FlareSolverr sur `localhost:8191`).
> - **Ports exposés via Gluetun** : comme ces services n'ont pas leur propre pile réseau, leurs ports sont déclarés sur le conteneur Gluetun — c'est le fonctionnement attendu et recommandé.

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    HUB MULTIMÉDIA                       │
│                                                         │
│  ┌──────────┐    ┌──────────┐    ┌──────────────────┐   │
│  │  Seerr   │───▶│  Radarr  │───▶│                  │   │
│  │ (5055)   │    │  (7878)  │    │   qBittorrent    │   │
│  └──────────┘    └──────────┘    │     (8080)       │   │
│       │          ┌──────────┐    │  via Gluetun VPN │   │
│       └─────────▶│  Sonarr  │───▶│                  │   │
│                  │  (8989)  │    └──────────────────┘   │
│                  └──────────┘             │             │
│                       │                  ▼             │
│              ┌─────────────────┐  ┌──────────────┐     │
│              │    Prowlarr     │  │  FlareSolverr │     │
│              │     (9696)      │  │    (8191)     │     │
│              └─────────────────┘  └──────────────┘     │
│                       │                                 │
│              ┌─────────────────┐                        │
│              │     Bazarr      │                        │
│              │     (6767)      │                        │
│              └─────────────────┘                        │
│                       │                                 │
│              ┌─────────────────┐  ┌──────────────┐     │
│              │      Plex       │  │  Cleanuparr  │     │
│              │    (32400)      │  │   (11011)    │     │
│              └─────────────────┘  └──────────────┘     │
│                       │                                 │
│              ┌─────────────────┐  ┌──────────────┐     │
│              │    Tautulli     │  │  Portainer   │     │
│              │     (8181)      │  │   (9000)     │     │
│              └─────────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────┘
```

---

## 🔗 Flux de fonctionnement

<img width="1104" height="976" alt="Schéma du flux des services hub_multimedia" src="https://github.com/user-attachments/assets/22c30f5e-73c1-4058-818d-5de3192acc97" />

---

## 🚀 Installation rapide

Cette branche `auto-deploy` est conçue pour un **déploiement entièrement automatisé sur Debian 13**.

📖 **Guide d'installation principal : [`french_docs/auto_deploy/README_AUTOSCRIPT.md`](french_docs/auto_deploy/README_AUTOSCRIPT.md)**

> 💡 Pour une installation **manuelle** (sans script), se référer à la branche [`classic`](https://github.com/ghost1337john/hub_multimedia/tree/classic).

---

## 🛠️ Prérequis

### 🔧 Matériel & système

| Composant | Minimum | Recommandé |
|-----------|---------|------------|
| CPU | 4 cœurs | 6 cœurs |
| RAM | 8 Go | 16 Go |
| Stockage | 64 Go SSD | 128 Go SSD |
| OS | Linux (Debian/Ubuntu) | Debian 13 |

> 💡 Sans GPU, chaque flux Plex transcodé consomme 1–2 cœurs CPU.

### 📦 Logiciels requis

- **Docker** (dernière version stable)
- **Docker Compose** v2 ou supérieur
- **Git**

### 🔐 VPN & réseau

- Compte **ProtonVPN** actif (compatible port forwarding)
- Clé **WireGuard** valide (ou identifiants OpenVPN)

---

## 📁 Structure du projet

```
hub_multimedia/
├── sources/
│   ├── docker_compose.yml      # Stack Docker principale
│   └── .env                    # Variables d'environnement (VPN, chemins)
├── auto_deploy/
│   ├── autoscript_install_hub_on_debian.sh
│   └── save_hub.sh
├── french_docs/
│   ├── README.md
│   ├── README_SOURCES.md
│   ├── auto_deploy/
│   │   └── README_AUTOSCRIPT.md
│   └── tuto_config/            # Tutoriels de configuration par service
├── english_docs/
│   ├── README.md
│   ├── auto_deploy/
│   │   └── README_AUTOSCRIPT.md
│   └── tuto_config/
├── CHANGELOG.md
└── README.md                   # Ce fichier
```

---

## 🌿 Strategie Git

Le dépôt est organisé autour d'une branche principale et de branches spécialisées :

- `Project` : branche complète (référence) avec toutes les variantes.
- `classic` : variante installation manuelle Linux (sans auto-deploy ni Windows).
- `auto-deploy` : variante automatisée Debian (script + stack Linux).
- `windows` : variante installation Windows.

Conventions recommandées pour les merges :

1. Ouvrir les PR sur la branche cible métier (pas systématiquement sur `Project`).
2. Les changements transverses (stack Docker, sécurité, docs globales) partent d'abord sur `Project`.
3. Reporter ensuite ces commits dans les branches spécialisées par sélection (`cherry-pick`) pour éviter de réintroduire des dossiers supprimés.
4. Éviter les merges de branches spécialisées vers `Project` sauf cas explicitement validé.

Exemple de synchronisation ciblée :

```bash
git checkout classic
git cherry-pick <sha_commit_depuis_Project>
```

---

## 📝 Note sur la configuration

Afin de garder ce projet **simple, évolutif et indépendant** des préférences de chacun, la configuration spécifique de chaque service (Sonarr, Radarr, Prowlarr, qBittorrent, etc.) n'est pas détaillée ici.

Chaque utilisateur est libre d'adapter l'écosystème à ses besoins. Des tutoriels dédiés sont disponibles dans le dossier [`french_docs/tuto_config/`](french_docs/tuto_config/).

---

## ❓ FAQ / Dépannage

Pour une FAQ plus complète (guides détaillés, cas fréquents et solutions avancées), consulte :

- 🇫🇷 FAQ complète (FR) : [`french_docs/README_FAQ.md`](french_docs/README_FAQ.md)
- 🇬🇧 Full FAQ (EN) : [`english_docs/README_FAQ.md`](english_docs/README_FAQ.md)

<details>
<summary>🔴 Un container ne démarre pas</summary>

```bash
# Vérifier les logs du container
docker logs <nom_du_container>

# Vérifier l'état de tous les services
docker compose ps
```
</details>

<details>
<summary>🔴 Gluetun / VPN ne se connecte pas</summary>

```bash
# Vérifier les logs Gluetun
docker logs gluetun

# Vérifier l'IP publique actuelle (doit être celle du VPN)
docker exec gluetun wget -qO- https://api.ipify.org
```

Vérifie que ta clé WireGuard et tes identifiants ProtonVPN sont corrects dans le fichier `.env`.
</details>

<details>
<summary>🔴 qBittorrent / Prowlarr inaccessibles</summary>

Ces services passent par Gluetun. S'ils sont inaccessibles, vérifie d'abord que **Gluetun est en bonne santé** (`healthy`).

```bash
docker compose ps gluetun
```
</details>

<details>
<summary>�� Problèmes de permissions sur les fichiers</summary>

```bash
# Vérifier ton PUID/PGID
id

# Réappliquer les permissions
sudo chown -R 1000:1000 /app
sudo chown -R 1000:1000 /data
```

Assure-toi que `PUID` et `PGID` dans le fichier `.env` correspondent à ton utilisateur.
</details>

<details>
<summary>🔵 Mettre à jour les containers</summary>

```bash
docker compose pull
docker compose up -d
```
</details>

<details>
<summary>🔵 Arrêter proprement la stack</summary>

```bash
docker compose down
```
</details>

---

## 🗂️ Historique des versions

Consulte le fichier [`CHANGELOG.md`](CHANGELOG.md) pour l'historique complet des versions.
