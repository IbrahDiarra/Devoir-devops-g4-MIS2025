FROM docker:27.5.0-dind

# Installer les outils nécessaires (par exemple, curl ou un serveur HTTP)
RUN apk add --no-cache curl openrc bash

# Configurer Docker pour le mode daemon
CMD ["dockerd-entrypoint.sh"]

