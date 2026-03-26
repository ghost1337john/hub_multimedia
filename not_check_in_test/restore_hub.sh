#!/bin/bash

set -e

# === CONFIGURATION ===
BACKUP_DIR="/opt/backups/hub_multimedia"
DEPLOY_DIR="/opt/hub_multimedia"

echo "🔄 Restauration d'une sauvegarde du Hub Multimédia"
echo "----------------------------------------"

# --- Vérification des droits root ---
if [ "$EUID" -ne 0 ]; then
  echo "❌ Ce script doit être exécuté en root (sudo)."
  exit 1
fi

# --- Lister les sauvegardes disponibles ---
BACKUPS=($(ls -t "$BACKUP_DIR"/backup_*.tar.gz 2>/dev/null))

if [ ${#BACKUPS[@]} -eq 0 ]; then
  echo "❌ Aucune sauvegarde trouvée dans $BACKUP_DIR"
  exit 1
fi

echo ""
echo "📦 Sauvegardes disponibles :"
echo ""
for i in "${!BACKUPS[@]}"; do
  SIZE=$(du -h "${BACKUPS[$i]}" | awk '{print $1}')
  NAME=$(basename "${BACKUPS[$i]}")
  echo "  [$((i+1))] $NAME ($SIZE)"
done

echo ""
read -rp "👉 Choisis le numéro de la sauvegarde à restaurer (1-${#BACKUPS[@]}) : " CHOICE

# --- Validation du choix ---
if ! [[ "$CHOICE" =~ ^[0-9]+$ ]] || [ "$CHOICE" -lt 1 ] || [ "$CHOICE" -gt ${#BACKUPS[@]} ]; then
  echo "❌ Choix invalide."
  exit 1
fi

SELECTED="${BACKUPS[$((CHOICE-1))]}"
echo ""
echo "📦 Sauvegarde sélectionnée : $(basename "$SELECTED")"

# --- Confirmation ---
read -rp "⚠️  Cette opération va écraser les configurations actuelles. Continuer ? (o/N) : " CONFIRM
if [[ "$CONFIRM" != "o" && "$CONFIRM" != "O" ]]; then
  echo "❌ Restauration annulée."
  exit 0
fi

# --- Arrêt des containers ---
echo ""
echo "🛑 Arrêt des conteneurs Docker..."
docker compose -f "$DEPLOY_DIR/docker-compose.yml" down 2>/dev/null || true

# --- Restauration ---
echo "📂 Restauration des fichiers..."
tar -xzf "$SELECTED" -C /

# --- Redémarrage ---
echo "🚀 Redémarrage des conteneurs..."
docker compose -f "$DEPLOY_DIR/docker-compose.yml" up -d

echo ""
echo "----------------------------------------"
echo "🎉 Restauration terminée avec succès !"
echo "📦 Archive restaurée : $(basename "$SELECTED")"
echo "----------------------------------------"
