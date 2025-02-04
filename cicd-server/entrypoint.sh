#!/bin/bash
dockerd &
while ! docker info > /dev/null 2>&1; do
    echo "Attente du démarrage de Docker..."
    sleep 1
done
cd /app
docker compose up