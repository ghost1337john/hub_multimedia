#!/bin/bash

# === CONFIGURATION ===
BACKUP_DIR="/opt/backups/hub_multimedia"
SOURCE_DIR="/opt/hub_multimedia"
DATE=$(date +"%Y-%m-%d_%H-%M")
ARCHIVE="$BACKUP_DIR/backup_$DATE.tar.gz"

# Dossiers à sauvegarder (ajuste selon ton arborescence)
FOLDERS=(
    "$SOURCE_DIR/config"
    "$SOURCE_DIR/data"
    "$SOURCE_DIR/docker-compose.yml"
    "$SOURCE_DIR/.env"
)

echo "📦 Sauvegarde du Hub Multimédia"
echo "📅 Date : $DATE"
echo "📁 Destination : $ARCHIVE"
echo "----------------------------------------"

# Création du dossier de backup
mkdir -p "$BACKUP_DIR"

# Arrêt propre des conteneurs
echo "🛑 Arrêt des conteneurs Docker..."
docker compose -f "$SOURCE_DIR/docker-compose.yml" down

# Création de l’archive
echo "🗜️ Compression des fichiers..."
tar -czvf "$ARCHIVE" "${FOLDERS[@]}"

# Redémarrage des conteneurs
echo "🚀 Redémarrage des conteneurs..."
docker compose -f "$SOURCE_DIR/docker-compose.yml" up -d

echo "----------------------------------------"
echo "🎉 Sauvegarde terminée avec succès !"
echo "📦 Archive créée : $ARCHIVE"
