# 🗂️ Version History

### **v1.4.0 — 2026‑03‑26**
- Added English translation of the entire project (`en/` folder)

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
