#!/bin/bash

# === CONFIGURATION ===
BACKUP_DIR="/opt/backups/hub_multimedia"
DEPLOY_DIR="/opt/hub_multimedia"
CONFIG_DIR="/app"
DATE=$(date +"%Y-%m-%d_%H-%M")
ARCHIVE="$BACKUP_DIR/backup_$DATE.tar.gz"
MAX_BACKUPS=5

# Dossiers de configuration des containers à sauvegarder
CONFIG_FOLDERS=(
    "$CONFIG_DIR/gluetun/config"
    "$CONFIG_DIR/qbittorrent/config"
    "$CONFIG_DIR/prowlarr/config"
    "$CONFIG_DIR/sonarr/config"
    "$CONFIG_DIR/radarr/config"
    "$CONFIG_DIR/bazarr/config"
    "$CONFIG_DIR/seerr/config"
    "$CONFIG_DIR/flaresolverr/config"
    "$CONFIG_DIR/cleanuparr/config"
    "$CONFIG_DIR/tautulli/config"
    "$CONFIG_DIR/plex/config"
)

# Fichiers de déploiement à sauvegarder
DEPLOY_FILES=(
    "$DEPLOY_DIR/docker-compose.yml"
    "$DEPLOY_DIR/.env"
)

echo "📦 Sauvegarde des configurations du Hub Multimédia"
echo "📅 Date : $DATE"
echo "📁 Destination : $ARCHIVE"
echo "----------------------------------------"

# --- Vérification des droits root ---
if [ "$EUID" -ne 0 ]; then
  echo "❌ Ce script doit être exécuté en root (sudo)."
  exit 1
fi

# --- Création du dossier de backup ---
mkdir -p "$BACKUP_DIR"

# --- Vérification des dossiers existants ---
EXISTING_FOLDERS=()
for folder in "${CONFIG_FOLDERS[@]}" "${DEPLOY_FILES[@]}"; do
  if [ -e "$folder" ]; then
    EXISTING_FOLDERS+=("$folder")
  else
    echo "⚠️  Ignoré (introuvable) : $folder"
  fi
done

if [ ${#EXISTING_FOLDERS[@]} -eq 0 ]; then
  echo "❌ Aucun dossier de configuration trouvé. Rien à sauvegarder."
  exit 1
fi

# --- Arrêt propre des conteneurs ---
echo "🛑 Arrêt des conteneurs Docker..."
docker compose -f "$DEPLOY_DIR/docker-compose.yml" down

# --- Création de l'archive ---
echo "🗜️ Compression des configurations..."
tar -czf "$ARCHIVE" "${EXISTING_FOLDERS[@]}"

# --- Redémarrage des conteneurs ---
echo "🚀 Redémarrage des conteneurs..."
docker compose -f "$DEPLOY_DIR/docker-compose.yml" up -d

# --- Rotation des anciennes sauvegardes ---
echo "🧹 Nettoyage des anciennes sauvegardes (conservation des $MAX_BACKUPS dernières)..."
ls -t "$BACKUP_DIR"/backup_*.tar.gz 2>/dev/null | tail -n +$((MAX_BACKUPS + 1)) | xargs -r rm -f

# --- Résumé ---
ARCHIVE_SIZE=$(du -h "$ARCHIVE" | awk '{print $1}')
echo ""
echo "----------------------------------------"
echo "🎉 Sauvegarde terminée avec succès !"
echo "📦 Archive : $ARCHIVE ($ARCHIVE_SIZE)"
echo "📂 Éléments sauvegardés : ${#EXISTING_FOLDERS[@]}"
echo "----------------------------------------"
