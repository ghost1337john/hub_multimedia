# 🗂️ Version History

### **v1.5.5 — 2026‑04‑01**
- Added **Lidarr** for automated music management (port 8686)
- Integrated the service into docker-compose with configuration identical to Radarr/Sonarr
- Created Lidarr configuration documentation (French and English)
- Updated service tables in all READMEs (Project, french_docs, english_docs)
- Network IP assigned: 172.19.0.7

### **v1.5.4 — 2026‑03‑27**
- Reorganized the project into multiple dedicated Git branches (e.g. `Project`, `windows`, `docs`, etc.)
- Clear separation of environments and features by branch
- Updated repository structure to ease contribution and maintenance

### **v1.5.3 — 2026‑03‑27**
- Removed unused port 6789 (nzbget) from docker-compose and Windows scripts  
- Added an explanatory section in READMEs about the VPN architecture benefits (`network_mode: service:gluetun`): enforced tunnel, automatic kill switch, localhost communication, and ports exposed via Gluetun  

### **v1.5.2 — 2026‑03‑27**
- Complete overhaul of all README.md files (root, `french_docs/`, `english_docs/`) with professional GreyWizard-Filter styling  
- Added badges (Docker, Plex, VPN, License), table of contents, and architecture diagram  
- Improved formatting: disclaimer blocks, enriched service descriptions, prerequisites and project structure sections  
- Harmonized content between French and English versions  

### **v1.5.1 — 2026‑03‑26**
- Moved the Windows project into the `windows_project_test/` folder (scripts + FR/EN docs)  
- Generated standalone `install_hub_multimedia.exe` via ps2exe  
- Published GitHub Release v1.5.0 with the Windows binary  

### **v1.5.0 — 2026‑03‑26**
- Added automatic Windows installation script (PowerShell + .bat)  
- Added Windows-adapted docker-compose (no `/dev/net/tun`, Windows paths, Plex port mapping)  
- Added Windows documentation (`french_docs/` and `english_docs/`)  
- Support for `.exe` conversion via ps2exe  

### **v1.4.4 — 2026‑03‑26**
- Added FAQ entry for verifying Gluetun VPN connection (logs, public IP, API)  

### **v1.4.3 — 2026‑03‑26**
- Added instructions on how to retrieve PUID and PGID in installation guides and autoscript (`french_docs/` and `english_docs/`)  

### **v1.4.2 — 2026‑03‑26**
- Added English documentation notice at the top of the main README  
- Added WireGuard configuration instructions in the autoscript prerequisites (`french_docs/` and `english_docs/`)  

### **v1.4.1 — 2026‑03‑26**
- Reorganized French documentation into the `french_docs/` folder  
- 18 Markdown files copied into the mirrored `french_docs/` structure  

### **v1.4.0 — 2026‑03‑26**
- Added English translation of the entire project (`english_docs/` folder)

### **v1.3.9 — 2026‑03‑26**
- Updated hardware recommendations in `README_HOWTOINSTALL.md`: minimum and recommended configuration, note on Plex transcoding  
- Updated prerequisites in `auto_deploy/README_AUTOSCRIPT.md`: added the same recommendations  

### **v1.3.8 — 2026‑03‑26**
- Removed version history from the main README, redirected to `CHANGELOG.md`  
- Added Plex configuration tutorial (`tuto_config/README_PLEX_CONFIG.md`)  

### **v1.3.7 — 2026‑03‑26**
- Extracted version history into a dedicated file (`CHANGELOG.md`)  

### **v1.3.6 — 2026‑03‑26**
- Updated FAQ: added Portainer section  
- Updated `not_check_in_test` README: Portainer and healthchecks integration status  
- Added `README_SOURCES.md` file: credits and human/AI contribution process  

### **v1.3.5 — 2026‑03‑26**
- Added **Portainer** container to docker-compose with healthcheck  
- Added Portainer to the service list in the main README  
- Updated `README_HOWTOINSTALL.md`: directory tree, mkdir, access table  
- Updated deployment script (`autoscript_install_hub_on_debian.sh`): added Portainer  
- Added Portainer configuration tutorial (`tuto_config/README_PORTAINER_CONFIG.md`)  

### **v1.3.4 — 2026‑03‑26**
- Added missing healthchecks to docker-compose: Prowlarr, Sonarr, Radarr, Bazarr, Tautulli, and Plex  
- Added `PUID` and `PGID` variables to the `sources/.env` file  

### **v1.3.3 — 2026‑03‑26**
- Added README for the backup procedure (`auto_deploy/README_SAVE_HUB.md`)  

### **v1.3.2 — 2026‑03‑26**
- Added README for the autoscript (`auto_deploy/README_AUTOSCRIPT.md`)  
- Added a mention of automatic installation at the top of `README_HOWTOINSTALL.md`  

### **v1.3.1 — 2026‑03‑26**
- Added config volume for **FlareSolverr** in docker-compose  
- Updated `README_HOWTOINSTALL.md`: added Plex, Tautulli, and FlareSolverr to directory tree, mkdir, and access table  
- Removed `README_PLEX_INSTALL.md` file (redundant)  
- Renamed `test/` folder to `auto_deploy/`  
- Complete rewrite of the deployment script (`autoscript_install_hub_on_debian.sh`) for Debian 13  
- Rewrite of the backup script (`save_hub.sh`): backup of 11 container configs, automatic rotation, root verification  

### **v1.3.0 — 2026‑03‑26**
- Added **Plex** container to docker-compose and main README  
- Added **Tautulli** container to docker-compose  
- Added Tautulli configuration tutorial (`tuto_config/README_TAUTULLI_CONFIG.md`)  
- Integrated Plex into the service list in the README  

### **v1.2.2 — 2026‑03‑26**
- Added **Tautulli** module to the main README  
- Service description and role in the Plex ecosystem  

### **v1.2.1 — 2026‑03‑26**
- Added a general note explaining that tutorials are intentionally simplified  
- Complete rewrite of tutorials: Sonarr, Radarr, Bazarr, Prowlarr, Seerr, and CleanUpArr  
- Style and structure harmonization of all files in the `tuto_config` folder  
- General clarification of the main README  
- Improved overall project consistency

### **v1.2.0 — 2026‑03‑26**
- Added legal disclaimer regarding project usage
- Updated the main README (clarification + compliance)
- Updated Sonarr documentation (procedure, configuration, overall consistency) 
- Improved overall project consistency
- Minor adjustments to service presentation  

### **v1.1.0 — 2026‑03‑25**
- Added **Cleanuparr** module  
- Complete documentation added (installation + configuration)  
- Updated main README  
- Improved overall project consistency  

### **v1.0.0 — 2026‑03-24**
- Added Seerr  
- Dedicated documentation + visual diagram  
- Full integration with Radarr/Sonarr

### **v0.9.0 — 2026‑03-23**
- Initial version of the multimedia hub  
- Radarr, Sonarr, Prowlarr, qBittorrent, Gluetun, Bazarr, FlareSolverr  
- Installation and configuration documentation
