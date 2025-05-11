#!/bin/bash
echo "[INFO] $(date) - Début de la mise à jour système" >> /var/log/update-and-reboot.log

# Mise à jour système
apt update && apt -y upgrade >> /var/log/update-and-reboot.log

echo "[INFO] $(date) - Mise à jour terminée, redémarrage..." >> /var/log/update-and-reboot.log

# Redémarrage
/sbin/shutdown -r now
