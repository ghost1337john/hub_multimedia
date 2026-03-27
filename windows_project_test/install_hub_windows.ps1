<#
.SYNOPSIS
    Hub Multimedia - Installateur automatique Windows
.DESCRIPTION
    Deploie le Hub Multimedia complet via Docker Desktop sur Windows 10/11 (WSL2)
    12 containers : Gluetun, qBittorrent, Prowlarr, Sonarr, Radarr, Bazarr,
    Seerr, FlareSolverr, Cleanuparr, Tautulli, Plex, Portainer
#>

# === Auto-elevation administrateur ===
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = "Hub Multimedia - Installation Windows"

# === BANNER ===
Clear-Host
Write-Host ""
Write-Host "  =================================================" -ForegroundColor Cyan
Write-Host "       Hub Multimedia - Installation Windows        " -ForegroundColor Cyan
Write-Host "       Docker Desktop + WSL2                        " -ForegroundColor Cyan
Write-Host "  =================================================" -ForegroundColor Cyan
Write-Host ""

# ===========================================================
# ETAPE 1 : Verification de Docker Desktop
# ===========================================================
Write-Host "  [1/7] Verification de Docker Desktop..." -ForegroundColor Green

$dockerCmd = Get-Command docker -ErrorAction SilentlyContinue
if (-not $dockerCmd) {
    Write-Host "  ERREUR : Docker n'est pas installe." -ForegroundColor Red
    Write-Host "  Telecharge Docker Desktop : https://www.docker.com/products/docker-desktop/" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "  Appuie sur Entree pour quitter"
    exit 1
}

try {
    $null = docker info 2>&1
    if ($LASTEXITCODE -ne 0) { throw "Docker not running" }
    Write-Host "    Docker Desktop est demarre." -ForegroundColor Gray
} catch {
    Write-Host "  ERREUR : Docker Desktop n'est pas demarre." -ForegroundColor Red
    Write-Host "  Lance Docker Desktop puis relance ce script." -ForegroundColor Yellow
    Write-Host ""
    Read-Host "  Appuie sur Entree pour quitter"
    exit 1
}

try {
    $null = docker compose version 2>&1
    if ($LASTEXITCODE -ne 0) { throw "Compose not found" }
} catch {
    Write-Host "  ERREUR : Docker Compose n'est pas disponible." -ForegroundColor Red
    Read-Host "  Appuie sur Entree pour quitter"
    exit 1
}

Write-Host ""

# ===========================================================
# ETAPE 2 : Configuration des repertoires
# ===========================================================
Write-Host "  [2/7] Configuration des repertoires..." -ForegroundColor Green
Write-Host ""

$defaultInstallDir = "C:\hub_multimedia"
Write-Host "    Repertoire d'installation [$defaultInstallDir] : " -NoNewline
$InstallDir = Read-Host
if ([string]::IsNullOrWhiteSpace($InstallDir)) { $InstallDir = $defaultInstallDir }

$AppDir  = Join-Path $InstallDir "app"
$DataDir = Join-Path $InstallDir "data"
$Data2Dir = Join-Path $InstallDir "data2"
$DockerDir = Join-Path $InstallDir "docker"

Write-Host "    Repertoire medias principal [$DataDir] : " -NoNewline
$customData = Read-Host
if (-not [string]::IsNullOrWhiteSpace($customData)) { $DataDir = $customData }

Write-Host "    Repertoire medias secondaire [$Data2Dir] : " -NoNewline
$customData2 = Read-Host
if (-not [string]::IsNullOrWhiteSpace($customData2)) { $Data2Dir = $customData2 }

# Creation de l'arborescence
$services = @("gluetun","qbittorrent","prowlarr","sonarr","radarr","bazarr","seerr","flaresolverr","cleanuparr","tautulli","plex","portainer")
foreach ($svc in $services) {
    New-Item -ItemType Directory -Path (Join-Path $AppDir "$svc\config") -Force | Out-Null
}
foreach ($d in @((Join-Path $DataDir "films"), (Join-Path $DataDir "series"), (Join-Path $DataDir "qbittorrent\downloads"), $Data2Dir)) {
    New-Item -ItemType Directory -Path $d -Force | Out-Null
}
New-Item -ItemType Directory -Path $DockerDir -Force | Out-Null

Write-Host "    Repertoires crees." -ForegroundColor Gray
Write-Host ""

# ===========================================================
# ETAPE 3 : Configuration VPN
# ===========================================================
Write-Host "  [3/7] Configuration VPN..." -ForegroundColor Green
Write-Host ""

Write-Host "    Fuseau horaire [Europe/Paris] : " -NoNewline
$TZ = Read-Host
if ([string]::IsNullOrWhiteSpace($TZ)) { $TZ = "Europe/Paris" }

Write-Host ""
Write-Host "    Type de VPN :" -ForegroundColor Cyan
Write-Host "      1. WireGuard (recommande)"
Write-Host "      2. OpenVPN"
Write-Host "    Choix [1] : " -NoNewline
$vpnChoice = Read-Host
if ($vpnChoice -eq "2") { $VpnType = "openvpn" } else { $VpnType = "wireguard" }

$WgKey = ""; $OvpnUser = ""; $OvpnPass = ""
Write-Host ""
if ($VpnType -eq "wireguard") {
    Write-Host "    Cle privee WireGuard : " -NoNewline
    $WgKey = Read-Host
} else {
    Write-Host "    !! Ajouter +pmp a la fin du nom d'utilisateur !!" -ForegroundColor Yellow
    Write-Host "    Nom d'utilisateur OpenVPN : " -NoNewline
    $OvpnUser = Read-Host
    Write-Host "    Mot de passe OpenVPN : " -NoNewline
    $OvpnPass = Read-Host
}

Write-Host ""
Write-Host "    Pays serveurs VPN (ex: Spain,Portugal) [Netherlands] : " -NoNewline
$Countries = Read-Host
if ([string]::IsNullOrWhiteSpace($Countries)) { $Countries = "Netherlands" }

Write-Host ""

# Convertir les chemins en format Docker (forward slashes)
$AppDirD  = $AppDir  -replace '\\','/'
$DataDirD = $DataDir -replace '\\','/'
$Data2DirD = $Data2Dir -replace '\\','/'
$MediaDirD = $DataDirD

# ===========================================================
# ETAPE 4 : Generation du fichier .env
# ===========================================================
Write-Host "  [4/7] Generation du fichier .env..." -ForegroundColor Green

$envLines = @(
    "# Hub Multimedia - Windows .env",
    "# Genere par install_hub_windows.ps1",
    "",
    "# Base config",
    "PUID=1000",
    "PGID=1000",
    "TZ=$TZ",
    "MEDIA_DIR=$MediaDirD",
    "",
    "# Gluetun config",
    "VPN_TYPE=$VpnType",
    "SERVER_COUNTRIES=$Countries",
    "",
    "# OpenVPN config",
    "OPENVPN_USER=$OvpnUser",
    "OPENVPN_PASSWORD=$OvpnPass",
    "",
    "# WireGuard config",
    "WIREGUARD_PRIVATE_KEY=$WgKey"
)
$envPath = Join-Path $DockerDir ".env"
[System.IO.File]::WriteAllLines($envPath, $envLines, [System.Text.UTF8Encoding]::new($false))

Write-Host "    .env cree dans $DockerDir" -ForegroundColor Gray
Write-Host ""

# ===========================================================
# ETAPE 5 : Generation du docker-compose.yml
# ===========================================================
Write-Host "  [5/7] Generation du docker-compose.yml adapte Windows..." -ForegroundColor Green

# Template docker-compose (single-quoted here-string : aucune variable PS expansee)
$compose = @'
networks:
  network_hub_multimedia:
    name: network_hub_multimedia
    ipam:
      config:
        - subnet: 172.19.0.0/24

services:
  gluetun:
    image: qmcgaw/gluetun:v3
    container_name: gluetun
    cap_add:
      - NET_ADMIN
    networks:
      network_hub_multimedia:
        ipv4_address: 172.19.0.3
    ports:
      - 8080:8080/tcp   # qbittorrent
      - 6881:6881       # qbittorrent torrent
      - 9696:9696       # prowlarr
      - 8191:8191       # flaresolverr
    environment:
      - TZ=${TZ}
      - UPDATER_PERIOD=24h
      - VPN_SERVICE_PROVIDER=protonvpn
      - VPN_TYPE=${VPN_TYPE}
      - BLOCK_MALICIOUS=on
      - OPENVPN_USER=${OPENVPN_USER}
      - OPENVPN_PASSWORD=${OPENVPN_PASSWORD}
      - OPENVPN_CIPHERS=AES-256-GCM
      - WIREGUARD_PRIVATE_KEY=${WIREGUARD_PRIVATE_KEY}
      - PORT_FORWARD_ONLY=on
      - VPN_PORT_FORWARDING=on
      - VPN_PORT_FORWARDING_UP_COMMAND=/bin/sh -c 'wget -O- --retry-connrefused --post-data "json={\"listen_port\":{{PORTS}}}" http://127.0.0.1:8080/api/v2/app/setPreferences 2>&1'
      - SERVER_COUNTRIES=${SERVER_COUNTRIES}
    volumes:
      - __APP_DIR__/gluetun/config:/gluetun
    restart: unless-stopped

  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent:latest
    container_name: qbittorrent
    depends_on:
      gluetun:
        condition: service_healthy
        restart: true
    environment:
      - PUID=${PUID}
      - PGID=${PGID}
      - TZ=${TZ}
      - WEBUI_PORT=8080
    volumes:
      - __APP_DIR__/qbittorrent/config:/config
      - ${MEDIA_DIR}/qbittorrent/downloads:/downloads
    network_mode: service:gluetun
    restart: unless-stopped
    healthcheck:
      test: ping -c 1 www.google.com || exit 1
      interval: 60s
      retries: 3
      start_period: 20s
      timeout: 10s

  prowlarr:
    image: lscr.io/linuxserver/prowlarr:latest
    container_name: prowlarr
    environment:
      - PUID=${PUID}
      - PGID=${PGID}
      - TZ=${TZ}
    volumes:
      - __APP_DIR__/prowlarr/config:/config
    restart: unless-stopped
    depends_on:
      gluetun:
        condition: service_healthy
        restart: true
    network_mode: service:gluetun
    healthcheck:
      test: curl -f http://localhost:9696/ping || exit 1
      interval: 30s
      timeout: 10s
      start_period: 20s
      retries: 3

  sonarr:
    image: lscr.io/linuxserver/sonarr:latest
    container_name: sonarr
    restart: unless-stopped
    environment:
      - PUID=${PUID}
      - PGID=${PGID}
      - TZ=${TZ}
    volumes:
      - __APP_DIR__/sonarr/config:/config
      - __DATA_DIR__:/data
      - __DATA2_DIR__:/data2
      - ${MEDIA_DIR}/qbittorrent/downloads:/downloads
    ports:
      - 8989:8989
    networks:
      network_hub_multimedia:
        ipv4_address: 172.19.0.6
    healthcheck:
      test: curl -f http://localhost:8989/ping || exit 1
      interval: 30s
      timeout: 10s
      start_period: 20s
      retries: 3

  radarr:
    image: lscr.io/linuxserver/radarr:latest
    container_name: radarr
    restart: unless-stopped
    environment:
      - PUID=${PUID}
      - PGID=${PGID}
      - TZ=${TZ}
    volumes:
      - __APP_DIR__/radarr/config:/config
      - __DATA_DIR__:/data
      - __DATA2_DIR__:/data2
      - ${MEDIA_DIR}/qbittorrent/downloads:/downloads
    ports:
      - 7878:7878
    networks:
      network_hub_multimedia:
        ipv4_address: 172.19.0.5
    healthcheck:
      test: curl -f http://localhost:7878/ping || exit 1
      interval: 30s
      timeout: 10s
      start_period: 20s
      retries: 3

  bazarr:
    image: lscr.io/linuxserver/bazarr:latest
    container_name: bazarr
    restart: unless-stopped
    environment:
      - PUID=${PUID}
      - PGID=${PGID}
      - TZ=${TZ}
    volumes:
      - __APP_DIR__/bazarr/config:/config
      - __DATA_DIR__:/data
      - __DATA2_DIR__:/data2
      - ${MEDIA_DIR}/qbittorrent/downloads:/downloads
    ports:
      - 6767:6767
    networks:
      network_hub_multimedia:
        ipv4_address: 172.19.0.2
    healthcheck:
      test: curl -f http://localhost:6767/api || exit 1
      interval: 30s
      timeout: 10s
      start_period: 20s
      retries: 3

  seerr:
    container_name: seerr
    image: ghcr.io/seerr-team/seerr:latest
    environment:
      - LOG_LEVEL=debug
      - PUID=${PUID}
      - PGID=${PGID}
      - TZ=${TZ}
    healthcheck:
      test: wget --no-verbose --tries=1 --spider http://localhost:5055/api/v1/status || exit 1
      start_period: 20s
      timeout: 3s
      interval: 15s
      retries: 3
    restart: unless-stopped
    volumes:
      - __APP_DIR__/seerr/config:/app/config
    ports:
      - 5055:5055
    networks:
      network_hub_multimedia:
        ipv4_address: 172.19.0.4

  flaresolverr:
    image: ghcr.io/flaresolverr/flaresolverr:latest
    container_name: flaresolverr
    environment:
      - LOG_LEVEL=${LOG_LEVEL:-info}
      - LOG_HTML=${LOG_HTML:-false}
      - CAPTCHA_SOLVER=${CAPTCHA_SOLVER:-none}
      - TZ=${TZ}
    volumes:
      - __APP_DIR__/flaresolverr/config:/config
    depends_on:
      gluetun:
        condition: service_healthy
        restart: true
    network_mode: service:gluetun
    restart: unless-stopped

  cleanuparr:
    image: ghcr.io/cleanuparr/cleanuparr:latest
    container_name: cleanuparr
    depends_on:
      - radarr
      - sonarr
    restart: unless-stopped
    ports:
      - "11011:11011"
    volumes:
      - __APP_DIR__/cleanuparr/config:/config
      - ${MEDIA_DIR}/qbittorrent/downloads:/downloads
    environment:
      - PORT=11011
      - PUID=${PUID}
      - PGID=${PGID}
      - TZ=${TZ}
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:11011/health"]
      interval: 30s
      timeout: 10s
      start_period: 30s
      retries: 3
    networks:
      network_hub_multimedia:
        ipv4_address: 172.19.0.14

  tautulli:
    image: lscr.io/linuxserver/tautulli:latest
    container_name: tautulli
    restart: unless-stopped
    environment:
      - PUID=${PUID}
      - PGID=${PGID}
      - TZ=${TZ}
    volumes:
      - __APP_DIR__/tautulli/config:/config
    ports:
      - 8181:8181
    networks:
      network_hub_multimedia:
        ipv4_address: 172.19.0.15
    healthcheck:
      test: curl -f http://localhost:8181/status || exit 1
      interval: 30s
      timeout: 10s
      start_period: 20s
      retries: 3

  plex:
    image: lscr.io/linuxserver/plex:latest
    container_name: plex
    restart: unless-stopped
    ports:
      - 32400:32400
    environment:
      - PUID=${PUID}
      - PGID=${PGID}
      - TZ=${TZ}
      - VERSION=docker
    volumes:
      - __APP_DIR__/plex/config:/config
      - __DATA_DIR__:/movies
      - __DATA2_DIR__:/series
    networks:
      network_hub_multimedia:
        ipv4_address: 172.19.0.10
    healthcheck:
      test: curl -f http://localhost:32400/identity || exit 1
      interval: 30s
      timeout: 10s
      start_period: 60s
      retries: 3

  portainer:
    image: portainer/portainer-ce:latest
    container_name: portainer
    restart: unless-stopped
    environment:
      - TZ=${TZ}
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - __APP_DIR__/portainer/config:/data
    ports:
      - 9000:9000
    networks:
      network_hub_multimedia:
        ipv4_address: 172.19.0.16
    healthcheck:
      test: wget --no-verbose --tries=1 --spider http://localhost:9000/api/system/status || exit 1
      interval: 30s
      timeout: 10s
      start_period: 20s
      retries: 3
'@

# Remplacer les placeholders par les vrais chemins Windows
$compose = $compose.Replace('__APP_DIR__', $AppDirD).Replace('__DATA_DIR__', $DataDirD).Replace('__DATA2_DIR__', $Data2DirD)

$composePath = Join-Path $DockerDir "docker-compose.yml"
[System.IO.File]::WriteAllText($composePath, $compose, [System.Text.UTF8Encoding]::new($false))

Write-Host "    docker-compose.yml cree." -ForegroundColor Gray
Write-Host ""

# ===========================================================
# ETAPE 6 : Validation
# ===========================================================
Write-Host "  [6/7] Validation du docker-compose..." -ForegroundColor Green

Push-Location $DockerDir
$validateOutput = docker compose config 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "  ERREUR : docker-compose invalide :" -ForegroundColor Red
    Write-Host $validateOutput -ForegroundColor Red
    Pop-Location
    Read-Host "  Appuie sur Entree pour quitter"
    exit 1
}
Pop-Location

Write-Host "    docker-compose.yml valide." -ForegroundColor Gray
Write-Host ""

# ===========================================================
# ETAPE 7 : Deploiement
# ===========================================================
Write-Host "  [7/7] Lancement du Hub Multimedia..." -ForegroundColor Green
Write-Host ""

Push-Location $DockerDir
docker compose up -d
$exitCode = $LASTEXITCODE
Pop-Location

if ($exitCode -ne 0) {
    Write-Host ""
    Write-Host "  ERREUR lors du deploiement." -ForegroundColor Red
    Read-Host "  Appuie sur Entree pour quitter"
    exit 1
}

Write-Host ""

# Etat des containers
Write-Host "  Etat des containers :" -ForegroundColor Cyan
Push-Location $DockerDir
docker compose ps
Pop-Location

Write-Host ""
Write-Host "  =================================================" -ForegroundColor Green
Write-Host "       Deploiement termine !                        " -ForegroundColor Green
Write-Host "  =================================================" -ForegroundColor Green
Write-Host ""
Write-Host "    Acces aux services :" -ForegroundColor Cyan
Write-Host "    - Plex          : http://localhost:32400/web"
Write-Host "    - Sonarr        : http://localhost:8989"
Write-Host "    - Radarr        : http://localhost:7878"
Write-Host "    - Bazarr        : http://localhost:6767"
Write-Host "    - Seerr         : http://localhost:5055"
Write-Host "    - Prowlarr      : http://localhost:9696"
Write-Host "    - qBittorrent   : http://localhost:8080"
Write-Host "    - FlareSolverr  : http://localhost:8191"
Write-Host "    - Tautulli      : http://localhost:8181"
Write-Host "    - Cleanuparr    : http://localhost:11011"
Write-Host "    - Portainer     : http://localhost:9000"
Write-Host ""
Write-Host "    Fichiers : $DockerDir" -ForegroundColor Gray
Write-Host ""
Read-Host "  Appuie sur Entree pour fermer"
