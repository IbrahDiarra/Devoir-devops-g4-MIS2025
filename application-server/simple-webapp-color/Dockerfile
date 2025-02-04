# Utiliser une image de base Python
FROM python:3.12.0

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier les fichiers de l'application dans le conteneur
COPY . .

# Installer les dépendances
RUN pip install --no-cache-dir -r requirements.txt

# Exposer le port 8080
EXPOSE 8080

# Définir la variable d'environnement par défaut
ENV APP_COLOR=red

# Commande pour lancer l'application
CMD ["python", "app.py"]