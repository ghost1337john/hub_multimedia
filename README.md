<img width="1264" height="842" alt="Gemini_Generated_Image_bzivrtbzivrtbziv" src="https://github.com/user-attachments/assets/7271c058-62da-450e-828a-1569d611fc0d" />


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
- [🔗 Flux de fonctionnement](#-flux-de-fonctionnement)
- [🚀 Installation rapide](#-installation-rapide)
- [🛠️ Prérequis](#️-prérequis)
- [📁 Structure du projet](#-structure-du-projet)
- [🌿 Stratégie Git](#-stratégie-git)
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
| 6 | 🎵 **Lidarr** | Automatisation de la musique | 8686 |
| 7 | 💬 **Bazarr** | Sous‑titres automatiques | 6767 |
| 8 | ⭐ **Seerr** | Interface de demandes utilisateurs | 5055 |
| 9 | 📺 **Plex** | Serveur multimédia (streaming) | 32400 |
| 10 | 📊 **Tautulli** | Surveillance et statistiques Plex | 8181 |
| 11 | 🛡️ **FlareSolverr** | Contournement Cloudflare pour Prowlarr | 8191 |
| 12 | 🐳 **Portainer** | Gestion des containers en WebUI | 9000 |
| 13 | 🧹 **Cleanuparr** | Nettoyage automatisé des téléchargements | 11011 |

> 🔒 **qBittorrent**, **Prowlarr** et **FlareSolverr** utilisent `network_mode: service:gluetun` — ils partagent l'espace réseau du conteneur VPN.
>
> **Avantages de cette architecture :**
> - **Tout le trafic passe par le VPN** : ces services n'ont aucun accès direct à Internet, tout est routé à travers le tunnel WireGuard/OpenVPN.
> - **Kill switch automatique** : si le VPN tombe, ces services perdent toute connectivité — aucune fuite d'IP possible.
> - **Communication locale simplifiée** : les services qui partagent le même namespace réseau communiquent entre eux via `localhost` (ex : Prowlarr → FlareSolverr sur `localhost:8191`).
> - **Ports exposés via Gluetun** : comme ces services n'ont pas leur propre pile réseau, leurs ports sont déclarés sur le conteneur Gluetun — c'est le fonctionnement attendu et recommandé.

---

### 🔗 Flux de fonctionnement detaille

1. L'utilisateur fait une demande de film ou de serie dans Seerr, ou une demande de musique via Lidarr.
2. Seerr transmet ensuite la demande a Sonarr (series) et/ou Radarr (films).
3. Sonarr, Radarr et Lidarr interrogent Prowlarr pour rechercher les indexers adaptes.
4. Prowlarr utilise FlareSolverr si necessaire pour interroger certains indexers proteges.
5. Une fois les releases trouvees, Sonarr, Radarr et Lidarr envoient les taches de telechargement a qBittorrent.
6. qBittorrent, Prowlarr et FlareSolverr sont encapsules dans le tunnel VPN gere par Gluetun (`network_mode: service:gluetun`).
7. Lorsque le telechargement est termine, Sonarr, Radarr et Lidarr importent, renomment et deplacent les fichiers vers les bons dossiers medias.
8. Bazarr s'appuie sur Sonarr et Radarr pour identifier les medias et gerer les sous-titres manquants via ses propres indexers.
9. Cleanuparr nettoie ensuite les elements termines dans qBittorrent et supprime les traces de telechargement selon ta configuration.
10. Plex scanne les fichiers finaux et met a jour la bibliotheque.
11. Tautulli genere ensuite des statistiques sur l'utilisation de Plex par les utilisateurs.

---

## 🚀 Installation rapide

Ce dépôt utilise maintenant **une seule branche** (`Project`) avec des variantes classées par dossiers.

Choisis le dossier adapté à ton type d'installation :

- **Linux manuel** : [`branches/classic/`](branches/classic/)
	- Guide FR : [`branches/classic/french_docs/README_HOWTOINSTALL.md`](branches/classic/french_docs/README_HOWTOINSTALL.md)
- **Linux automatisé (Debian)** : [`branches/autodeploy/`](branches/autodeploy/)
	- Guide FR : [`branches/autodeploy/french_docs/auto_deploy/README_AUTOSCRIPT.md`](branches/autodeploy/french_docs/auto_deploy/README_AUTOSCRIPT.md)

---

## 🛠️ Prérequis

Les prérequis dépendent du dossier choisi (`branches/classic`, `branches/autodeploy`).

Consulte directement la documentation du dossier cible depuis la section [Installation rapide](#-installation-rapide).

---

## 📁 Structure du projet

```
hub_multimedia/
├── branches/
│   ├── classic/
│   │   ├── sources/
│   │   ├── french_docs/
│   │   └── tuto_config/
│   ├── autodeploy/
│   │   ├── auto_deploy/
│   │   ├── sources/
│   │   ├── french_docs/
│   │   └── tuto_config/
├── CHANGELOG.md
└── README.md                   # Ce fichier
```

---

## 🌿 Stratégie Git

Le dépôt est organisé sur **une branche unique** (`Project`) avec des variantes regroupées en sous-dossiers :

- `branches/classic` : installation Linux manuelle.
- `branches/autodeploy` : installation Linux automatisée (Debian).

Recommandations :

1. Créer les PR directement sur `Project`.
2. Limiter les changements au dossier concerné quand la modification est spécifique à un type d'installation.
3. Appliquer les changements transverses (docs globales, structure commune) de façon cohérente dans les dossiers impactés.

---

## 📝 Note sur la configuration

Afin de garder ce projet **simple, évolutif et indépendant** des préférences de chacun, la configuration spécifique de chaque service (Sonarr, Radarr, Prowlarr, qBittorrent, etc.) n'est pas détaillée ici.

Chaque utilisateur est libre d'adapter l'écosystème à ses besoins. Des tutoriels dédiés sont disponibles dans :

- [`branches/classic/french_docs/tuto_config/`](branches/classic/french_docs/tuto_config/)
- [`branches/autodeploy/french_docs/tuto_config/`](branches/autodeploy/french_docs/tuto_config/)

---

## ❓ FAQ / Dépannage

Pour une FAQ plus complète (guides détaillés, cas fréquents et solutions avancées), consulte :

- 🇫🇷 FAQ Linux manuel (FR) : [`branches/classic/french_docs/README_FAQ.md`](branches/classic/french_docs/README_FAQ.md)
- 🇫🇷 FAQ Linux auto-deploy (FR) : [`branches/autodeploy/french_docs/README_FAQ.md`](branches/autodeploy/french_docs/README_FAQ.md)

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


