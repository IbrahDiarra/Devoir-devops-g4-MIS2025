# Étape de base avec DinD
FROM stic/dind

# Copier le fichier compose.yml dans l'image
COPY compose.yml /app/compose.yml

# Ajouter un script d'entrée
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Définir le point d'entrée
ENTRYPOINT ["/entrypoint.sh"]