# Architecture de la Solution DevOps avec Docker-in-Docker (DinD)

## 1. Aperçu de l'Architecture
L'objectif de ce projet est de mettre en place un environnement DevOps entièrement conteneurisé, basé sur Docker-in-Docker (DinD). Cet environnement permet de gérer un pipeline DevOps complet, incluant la répartition de charge, l'intégration continue, la surveillance des systèmes, la gestion des bases de données, et le déploiement d'applications.

L'architecture est composée de plusieurs serveurs conteneurisés, chacun hébergeant des outils spécifiques pour répondre aux besoins d'un pipeline DevOps moderne.

------------------------------------------------------------------------------------------------------------

## 2. Composants de l'Architecture

### 2.1. Load Balancer (Nginx)
- **Rôle** : Répartir la charge entre les différentes applications et services.
- **Technologie** : Nginx.
- **Ports exposés** : 80 (HTTP).
- **Description** : Le serveur Load Balancer utilise Nginx pour diriger les requêtes vers les applications hébergées sur le serveur d'applications.

### 2.2. Serveur CI/CD (Jenkins et SonarQube)
- **Rôle** : Automatiser les builds, les tests et les déploiements, ainsi qu'analyser la qualité du code.
- **Technologies** :
  - Jenkins : Pour l'automatisation des pipelines CI/CD.
  - SonarQube : Pour l'analyse statique du code et la détection des vulnérabilités.
- **Ports exposés** :
  - Jenkins : 8080.
  - SonarQube : 9000.
- **Description** : Ce serveur permet de gérer les pipelines d'intégration et de déploiement continus, ainsi que d'assurer la qualité du code grâce à SonarQube.

### 2.3. Serveur de Monitoring (Prometheus et Grafana)
- **Rôle** : Collecter et visualiser les métriques des systèmes et des applications.
- **Technologies** :
  - Prometheus : Pour la collecte des métriques.
  - Grafana : Pour la visualisation des données sous forme de tableaux de bord.
- **Ports exposés** :
  - Prometheus : 9090.
  - Grafana : 3000.
- **Description** : Ce serveur permet de surveiller les performances des applications et des services en temps réel.

### 2.4. Serveur de Base de Données (MariaDB et Redis)
- **Rôle** : Stocker les données relationnelles et gérer les caches.
- **Technologies** :
  - MariaDB : Base de données relationnelle.
  - Redis : Base de données clé-valeur pour la gestion des caches.
- **Ports exposés** :
  - MariaDB : 3306.
  - Redis : 6379.
- **Description** : Ce serveur héberge les bases de données nécessaires pour les applications et les services.

### 2.5. Serveur d'Applications
- **Rôle** : Héberger les applications de démonstration.
- **Applications** :
  - `static-website-example` : Une application web statique.
  - `simple-webapp-color` : Une application web simple qui change de couleur.
- **Ports exposés** :
  - `static-website-example` : 8000.
  - `simple-webapp-color` : 5000.
- **Description** : Ce serveur conteneurise et exécute les applications de démonstration.

------------------------------------------------------------------------------------------------------------

## 3. Organisation du projet

L'architecture de notre projet repose sur plusieurs dossiers organisés de la manière suivante :

```
📂 Devoir-devops-g4-mis2025  
 ├── 📂 load-balancer-server  
 │   ├── 📄 compose.yml  
 │   ├── 📄 Dockerfile  
 │   ├── 📄 entrypoint.sh  
 │  
 ├── 📂 cicd-server  
 │   ├── 📄 compose.yml  
 │   ├── 📄 Dockerfile  
 │   ├── 📄 entrypoint.sh  
 │   ├── 📂 jenkins  
 │       ├── 📄 Dockerfile  
 │  
 ├── 📂 monitoring-server  
 │   ├── 📄 compose.yml  
 │   ├── 📄 Dockerfile  
 │   ├── 📄 entrypoint.sh  
 │  
 ├── 📂 database-server  
 │   ├── 📄 compose.yml  
 │   ├── 📄 Dockerfile  
 │   ├── 📄 entrypoint.sh  
 │  
 ├── 📂 application-server  
 │   ├── 📄 compose.yml  
 │   ├── 📄 Dockerfile  
 │   ├── 📄 entrypoint.sh  
 │   ├── 📂 static-website-example
 |   |   ├── 📄 compose.yml  
 |       ├── 📄 Dockerfile
 │   ├── 📂 simple-webapp-color  
 |   |   ├── 📄 compose.yml  
 |       ├── 📄 Dockerfile
 │  
 ├── 📄 compose.yml (fichier global)  
 ├── 📄 Architecture.md (description de l'architecture)  
 ├── 📄 Member.md (liste des membres du groupe)  
```

- **`compose.yml`** : Définit les services Docker pour le serveur.  
- **`Dockerfile`** : Définit l’image utilisée pour le conteneur du serveur.  
- **`entrypoint.sh`** : Script d’exécution au démarrage du conteneur.  

Les particularités :  

- **`cicd-server`** contient un dossier `jenkins/` avec un `Dockerfile` spécifique pour la configuration de Jenkins.  
- **`application-server`** héberge deux applications :  
  - **`static-website-example`** : Une application web statique.  
  - **`simple-webapp-color`** : Une application web dynamique.  


## 3. Architecture Globale
L'architecture globale repose sur Docker-in-Docker (DinD), ce qui permet à chaque serveur d'exécuter des conteneurs Docker indépendamment. Nous présentons ici un schéma simplifié de l'architecture :

```
+----------------------+
| load-balancer-server |
| (Nginx)              |
| Port: 80             |
+----------------------+
          |
          v
+----------------------+
|   cicd-server        |
| (Jenkins, SonarQ.)   |
| Ports: 8080, 9000    |
+----------------------+
          |
          v
+----------------------+
| monitoring-server    |
|(Prometheus, Graf.)   |
| Ports: 9090, 3000    |
+----------------------+
          |
          v
+----------------------+
| database-server      |
| (MariaDB, Redis)     |
| Ports: 3306, 6379    |
+----------------------+
          |
          v
+----------------------+
| application-server   |
| (static-website,     |
| simple-webapp)       |
| Ports: 8000, 5000    |
+----------------------+
```

------------------------------------------------------------------------------------------------------------

## 4. Fonctionnement de Docker-in-Docker (DinD)
Chaque serveur est basé sur une image Docker-in-Docker (DinD), ce qui permet à chaque conteneur d'exécuter d'autres conteneurs Docker. Cela est rendu possible grâce à l'utilisation du mode `--privileged` lors du lancement des conteneurs DinD.

### 4.1. Avantages de DinD
- **Isolation des environnements** : Chaque serveur fonctionne de manière indépendante.
- **Flexibilité** : Possibilité d'exécuter des conteneurs Docker à l'intérieur d'autres conteneurs.
- **Facilité de déploiement** : Les serveurs peuvent être déployés rapidement grâce à Docker Compose.


### 4.2. Limitations de DinD
- **Complexité** : La gestion des conteneurs imbriqués peut être complexe.
- **Performances** : L'utilisation de DinD peut entraîner une surcharge due à la virtualisation imbriquée.

------------------------------------------------------------------------------------------------------------

## 5. Déploiement avec Docker Compose
L'ensemble de l'infrastructure est déployé à l'aide d'un fichier `compose.yml` global, qui permet de lancer tous les serveurs en une seule commande. Chaque serveur est configuré pour exposer les ports nécessaires et utiliser les images Docker appropriées.


------------------------------------------------------------------------------------------------------------


## 6. Conclusion
Cette architecture offre une solution complète et moderne pour la mise en place d'un environnement DevOps entièrement conteneurisé. Elle permet d'automatiser les processus de développement, de surveillance et de déploiement, tout en assurant une gestion centralisée des conteneurs grâce à Docker-in-Docker.

------------------------------------------------------------------------------------------------------------