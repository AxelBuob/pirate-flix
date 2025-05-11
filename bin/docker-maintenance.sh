#!/bin/bash

# Dossier de log
LOGFILE="/var/log/docker-maintenance.log"
exec >> "$LOGFILE" 2>&1

echo "$(date '+%Y-%m-%d %H:%M:%S') - Début de la maintenance Docker"

# Nettoyage
echo "Nettoyage des images Docker inutilisées..."
/usr/bin/docker system prune -af --filter "until=168h"

# Mise à jour
echo "Mise à jour des images Docker..."
/usr/bin/docker compose -f /srv/media/appdata/docker-compose.yml pull

# Redémarrage
echo "Redémarrage des services..."
/usr/bin/docker compose -f /srv/media/appdata/docker-compose.yml up -d

echo "$(date '+%Y-%m-%d %H:%M:%S') - Maintenance terminée"
echo "---------------------------------------------"
