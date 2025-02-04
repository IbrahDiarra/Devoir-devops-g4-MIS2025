#!/bin/bash

# Assure-toi que Docker est lancé
dockerd &

# Attendre que le démon Docker soit prêt
while ! docker info > /dev/null 2>&1; do
    echo "Attente du démarrage de Docker..."
    sleep 1
done

# Aller dans le dossier où se trouve compose.yml
cd /app

# Lancer docker-compose
docker compose up