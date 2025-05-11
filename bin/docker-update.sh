#!/bin/bash
echo "[INFO] $(date) - Démarrage de la mise à jour Docker" >> /var/log/docker-update.log

# Met à jour toutes les images utilisées
docker compose -f /srv/media/appdata/docker-compose.yml pull >> /var/log/docker-update.log

# Redémarre les conteneurs si une nouvelle image est disponible
docker compose -f /srv/media/appdata/docker-compose.yml up -d >> /var/log/docker-update.log

echo "[INFO] $(date) - Mise à jour Docker terminée" >> /var/log/docker-update.log
