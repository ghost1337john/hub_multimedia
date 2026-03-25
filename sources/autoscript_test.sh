#!/bin/bash

set -e

echo "🚀 Déploiement du Hub Multimédia sur Debian"
echo "-------------------------------------------"

# --- 1. Mise à jour du système ---
echo "📦 Mise à jour du système..."
apt update && apt upgrade -y

# --- 2. Installation de Docker ---
echo "🐳 Installation de Docker..."
apt install -y ca-certificates curl gnupg lsb-release

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" \
  | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl enable docker
systemctl start docker

echo "✔ Docker installé"

# --- 3. Création de l’arborescence ---
echo "📁 Création des dossiers..."
mkdir -p /opt/hub_multimedia
mkdir -p /opt/hub_multimedia/config
mkdir -p /opt/hub_multimedia/data

# --- 4. Copie des fichiers ---
echo "📄 Copie du docker-compose et du .env..."
cp docker_compose.yml /opt/hub_multimedia/docker-compose.yml
cp .env /opt/hub_multimedia/.env

# --- 5. Vérification du compose ---
echo "🔍 Vérification du fichier docker-compose..."
docker compose -f /opt/hub_multimedia/docker-compose.yml config >/dev/null

echo "✔ docker-compose.yml valide"

# --- 6. Lancement du stack ---
echo "🚀 Lancement du Hub Multimédia..."
cd /opt/hub_multimedia
docker compose up -d

echo "✔ Stack lancée"

# --- 7. Activation au démarrage ---
echo "🔧 Activation du redémarrage automatique..."
systemctl enable docker

echo "-------------------------------------------"
echo "🎉 Déploiement terminé !"
echo "📌 Accès aux services :"
echo " - Seerr : http://IP:port"
echo " - Radarr : http://IP:7878"
echo " - Sonarr : http://IP:8989"
echo " - Prowlarr : http://IP:9696"
echo " - qBittorrent : http://IP:8080"
echo " - Plex : http://IP:32400/web"
echo "-------------------------------------------"
