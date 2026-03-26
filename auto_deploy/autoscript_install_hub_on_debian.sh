#!/bin/bash

set -e

# === VARIABLES ===
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
DEPLOY_DIR="/opt/hub_multimedia"
COMPOSE_SRC="$REPO_DIR/sources/docker_compose.yml"
SERVER_IP=$(hostname -I | awk '{print $1}')

echo "🚀 Déploiement du Hub Multimédia sur Debian 13 (Trixie)"
echo "-------------------------------------------"

# --- 0. Vérification des droits root ---
if [ "$EUID" -ne 0 ]; then
  echo "❌ Ce script doit être exécuté en root (sudo)."
  exit 1
fi

# --- 1. Mise à jour du système ---
echo "📦 Mise à jour du système..."
apt update && apt upgrade -y

# --- 2. Installation des prérequis ---
echo "📦 Installation des prérequis..."
apt install -y ca-certificates curl gnupg

# --- 3. Installation de Docker ---
if command -v docker &> /dev/null; then
  echo "✔ Docker est déjà installé ($(docker --version))"
else
  echo "🐳 Installation de Docker..."
  install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
  chmod a+r /etc/apt/keyrings/docker.asc

  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
    https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
    | tee /etc/apt/sources.list.d/docker.list > /dev/null

  apt update
  apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  echo "✔ Docker installé"
fi

systemctl enable docker
systemctl start docker

# --- 4. Création de l'arborescence des configs ---
echo "📁 Création des dossiers de configuration..."
mkdir -p \
  /app/gluetun/config \
  /app/qbittorrent/config \
  /app/prowlarr/config \
  /app/sonarr/config \
  /app/radarr/config \
  /app/bazarr/config \
  /app/seerr/config \
  /app/flaresolverr/config \
  /app/cleanuparr/config \
  /app/tautulli/config \
  /app/plex/config \
  /app/portainer/config

# --- 5. Création des dossiers de données ---
echo "📁 Création des dossiers de données..."
mkdir -p /data
mkdir -p /data2

# --- 6. Attribution des droits ---
echo "🔐 Attribution des droits (PUID/PGID 1000)..."
chown -R 1000:1000 /app
chown -R 1000:1000 /data
chown -R 1000:1000 /data2

# --- 7. Préparation du répertoire de déploiement ---
echo "📄 Préparation du déploiement..."
mkdir -p "$DEPLOY_DIR"
cp "$COMPOSE_SRC" "$DEPLOY_DIR/docker-compose.yml"

if [ -f "$REPO_DIR/sources/.env" ]; then
  cp "$REPO_DIR/sources/.env" "$DEPLOY_DIR/.env"
elif [ -f "$DEPLOY_DIR/.env" ]; then
  echo "✔ Fichier .env existant conservé"
else
  echo "⚠️  Aucun fichier .env trouvé !"
  echo "   Crée-le dans $DEPLOY_DIR/.env avant de lancer la stack."
  echo "   Variables requises : PUID, PGID, TZ, MEDIA_DIR, OPENVPN_USER,"
  echo "   OPENVPN_PASSWORD, WIREGUARD_PRIVATE_KEY, SERVER_COUNTRIES"
  exit 1
fi

# --- 8. Vérification du docker-compose ---
echo "🔍 Vérification du fichier docker-compose..."
docker compose -f "$DEPLOY_DIR/docker-compose.yml" --env-file "$DEPLOY_DIR/.env" config > /dev/null

echo "✔ docker-compose.yml valide"

# --- 9. Lancement de la stack ---
echo "🚀 Lancement du Hub Multimédia..."
cd "$DEPLOY_DIR"
docker compose up -d

echo "✔ Stack lancée"

# --- 10. Vérification des containers ---
echo "🔍 État des containers :"
docker compose ps

echo ""
echo "-------------------------------------------"
echo "🎉 Déploiement terminé !"
echo "-------------------------------------------"
echo "📌 Accès aux services :"
echo " - Plex          : http://$SERVER_IP:32400/web"
echo " - Sonarr        : http://$SERVER_IP:8989"
echo " - Radarr        : http://$SERVER_IP:7878"
echo " - Bazarr        : http://$SERVER_IP:6767"
echo " - Seerr         : http://$SERVER_IP:5055"
echo " - Prowlarr      : http://$SERVER_IP:9696"
echo " - qBittorrent   : http://$SERVER_IP:8080"
echo " - FlareSolverr  : http://$SERVER_IP:8191"
echo " - Tautulli      : http://$SERVER_IP:8181"
echo " - Cleanuparr    : http://$SERVER_IP:11011"
echo " - Portainer     : http://$SERVER_IP:9000"
echo "-------------------------------------------"
