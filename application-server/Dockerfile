FROM stic/dind

# Copie des applications dans l'image
COPY ./static-website-example /app/static-website-example/
COPY ./simple-webapp-color /app/simple-webapp-color/

COPY compose.yml /app/compose.yml

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]