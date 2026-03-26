# 🔗 Diagramme Mermaid — Flux de fonctionnement du Hub Multimédia

Ce diagramme peut remplacer l'image actuelle dans le README principal.  
GitHub rend nativement les blocs Mermaid dans les fichiers Markdown.

---

```mermaid
flowchart TD
    subgraph VPN["🔐 Gluetun (VPN)"]
        QB["🧲 qBittorrent\n:8080"]
        PR["🧭 Prowlarr\n:9696"]
        FS["🛡️ FlareSolverr\n:8191"]
    end

    subgraph Gestion["📂 Gestion des médias"]
        SO["📺 Sonarr\n:8989"]
        RA["🎬 Radarr\n:7878"]
        BA["💬 Bazarr\n:6767"]
    end

    subgraph Diffusion["📡 Diffusion & Monitoring"]
        PX["📺 Plex\n:32400"]
        TT["📊 Tautulli\n:8181"]
    end

    subgraph Utilisateur["👤 Utilisateur"]
        SE["⭐ Seerr\n:5055"]
    end

    subgraph Maintenance["🔧 Maintenance"]
        CU["🧹 Cleanuparr\n:11011"]
    end

    SE -->|"Demande film"| RA
    SE -->|"Demande série"| SO

    PR -->|"Indexers"| SO
    PR -->|"Indexers"| RA
    FS -->|"Anti-Cloudflare"| PR

    SO -->|"Téléchargement"| QB
    RA -->|"Téléchargement"| QB

    QB -->|"Fichiers prêts"| SO
    QB -->|"Fichiers prêts"| RA

    SO -->|"Séries organisées"| PX
    RA -->|"Films organisés"| PX

    BA -->|"Sous-titres"| SO
    BA -->|"Sous-titres"| RA

    PX -->|"Statistiques"| TT

    CU -->|"Nettoyage"| SO
    CU -->|"Nettoyage"| RA
```

---

## 📌 Comment intégrer dans le README principal

Remplacer le bloc image actuel :

```markdown
<img width="1104" height="976" alt="..." src="https://github.com/user-attachments/assets/..." />
```

Par le bloc Mermaid ci-dessus (copier le contenu entre les balises ` ```mermaid ` et ` ``` `).
