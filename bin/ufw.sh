#!/bin/bash

# Activer le logging
sudo ufw logging on

# Définir les politiques par défaut
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw default deny routed

# Ouvrir les ports HTTP/HTTPS pour tout le monde
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Autoriser SSH depuis le réseau local
sudo ufw allow from 192.168.1.0/24 to any port 22 proto tcp

# Ouvrir les ports Jellyfin, Radarr, Sonarr, Bazarr etc. pour le LAN uniquement
sudo ufw allow from 192.168.1.0/24 to any port 7878 proto tcp  # Radarr
sudo ufw allow from 192.168.1.0/24 to any port 8989 proto tcp  # Sonarr
sudo ufw allow from 192.168.1.0/24 to any port 9696 proto tcp  # Prowlarr
sudo ufw allow from 192.168.1.0/24 to any port 6767 proto tcp  # Bazarr
sudo ufw allow from 192.168.1.0/24 to any port 8096 proto tcp  # Jellyfin

# Autoriser les interfaces Docker br-* (ajuster si nécessaire)
sudo ufw allow in on br-6d6b46a36232 from 172.18.0.0/16
sudo ufw allow in on br-f70b706ad329 from 172.19.0.0/16

# Réactiver UFW
sudo ufw enable

# Afficher l'état
sudo ufw status verbose

