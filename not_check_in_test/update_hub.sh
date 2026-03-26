#!/bin/bash

set -e

# === CONFIGURATION ===
DEPLOY_DIR="/opt/hub_multimedia"
BACKUP_DIR="/opt/backups/hub_multimedia"
DATE=$(date +"%Y-%m-%d_%H-%M")

echo "🔄 Mise à jour du Hub Multimédia"
echo "----------------------------------------"

# --- Vérification des droits root ---
if [ "$EUID" -ne 0 ]; then
  echo "❌ Ce script doit être exécuté en root (sudo)."
  exit 1
fi

# --- Vérification du docker-compose ---
if [ ! -f "$DEPLOY_DIR/docker-compose.yml" ]; then
  echo "❌ docker-compose.yml introuvable dans $DEPLOY_DIR"
  exit 1
fi

# --- Sauvegarde avant mise à jour ---
echo "💾 Sauvegarde préventive avant mise à jour..."
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ -f "$SCRIPT_DIR/../auto_deploy/save_hub.sh" ]; then
  bash "$SCRIPT_DIR/../auto_deploy/save_hub.sh"
  echo "✔ Sauvegarde effectuée"
elif [ -f "$SCRIPT_DIR/save_hub.sh" ]; then
  bash "$SCRIPT_DIR/save_hub.sh"
  echo "✔ Sauvegarde effectuée"
else
  echo "⚠️  Script de sauvegarde introuvable, sauvegarde ignorée."
  read -rp "   Continuer sans sauvegarde ? (o/N) : " CONFIRM
  if [[ "$CONFIRM" != "o" && "$CONFIRM" != "O" ]]; then
    echo "❌ Mise à jour annulée."
    exit 0
  fi
fi

# --- Téléchargement des nouvelles images ---
echo ""
echo "📥 Téléchargement des nouvelles images Docker..."
cd "$DEPLOY_DIR"
docker compose pull

# --- Redéploiement avec les nouvelles images ---
echo "🚀 Redéploiement des containers..."
docker compose up -d --remove-orphans

# --- Nettoyage des anciennes images ---
echo "🧹 Nettoyage des images Docker inutilisées..."
docker image prune -f

# --- Vérification ---
echo ""
echo "🔍 État des containers :"
docker compose ps

echo ""
echo "----------------------------------------"
echo "🎉 Mise à jour terminée !"
echo "----------------------------------------"
