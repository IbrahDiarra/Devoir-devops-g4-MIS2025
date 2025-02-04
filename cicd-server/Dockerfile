FROM stic/dind

# Créer le répertoire de travail
COPY ./jenkins/Dockerfile /app/jenkins/Dockerfile

# Copier le fichier compose.yml
COPY compose.yml /app/compose.yml

# Ajouter un script d’entrée
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Définir le point d’entrée
ENTRYPOINT ["/entrypoint.sh"]
