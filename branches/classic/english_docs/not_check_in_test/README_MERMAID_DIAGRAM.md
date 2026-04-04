# 🔗 Mermaid Diagram — Multimedia Hub Workflow

This diagram can replace the current image in the main README.  
GitHub natively renders Mermaid blocks in Markdown files.

---

```mermaid
flowchart TD
    subgraph VPN["🔐 Gluetun (VPN)"]
        QB["🧲 qBittorrent\n:8080"]
        PR["🧭 Prowlarr\n:9696"]
        FS["🛡️ FlareSolverr\n:8191"]
    end

    subgraph Management["📂 Media Management"]
        SO["📺 Sonarr\n:8989"]
        RA["🎬 Radarr\n:7878"]
        BA["💬 Bazarr\n:6767"]
    end

    subgraph Streaming["📡 Streaming & Monitoring"]
        PX["📺 Plex\n:32400"]
        TT["📊 Tautulli\n:8181"]
    end

    subgraph User["👤 User"]
        SE["⭐ Seerr\n:5055"]
    end

    subgraph Maintenance["🔧 Maintenance"]
        CU["🧹 Cleanuparr\n:11011"]
    end

    SE -->|"Movie request"| RA
    SE -->|"Series request"| SO

    PR -->|"Indexers"| SO
    PR -->|"Indexers"| RA
    FS -->|"Anti-Cloudflare"| PR

    SO -->|"Download"| QB
    RA -->|"Download"| QB

    QB -->|"Files ready"| SO
    QB -->|"Files ready"| RA

    SO -->|"Organized series"| PX
    RA -->|"Organized movies"| PX

    BA -->|"Subtitles"| SO
    BA -->|"Subtitles"| RA

    PX -->|"Statistics"| TT

    CU -->|"Cleanup"| SO
    CU -->|"Cleanup"| RA
```

---

## 📌 How to Integrate into the Main README

Replace the current image block:

```markdown
<img width="1104" height="976" alt="..." src="https://github.com/user-attachments/assets/..." />
```

With the Mermaid block above (copy the content between the ` ```mermaid ` and ` ``` ` tags).
