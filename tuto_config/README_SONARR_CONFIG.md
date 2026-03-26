📺 Tutoriel de configuration de Sonarr (version simplifiée)
Sonarr est un outil permettant d’automatiser la gestion et l’organisation de vos séries TV.
Ce guide présente uniquement les grandes étapes, sans entrer dans les détails techniques.
Pour toute configuration avancée, veuillez consulter la documentation officielle :
👉 https://sonarr.tv

1️⃣ Accéder à Sonarr
Une fois Sonarr installé, ouvrez l’interface via :

Code
http://IP_DE_VOTRE_SERVEUR:8989
Lors de la première ouverture, créez simplement votre compte administrateur.

2️⃣ Définir les dossiers principaux
Sonarr doit connaître les emplacements où se trouvent :

Vos séries

Les fichiers en cours de traitement

Ces paramètres se configurent dans :

Code
Settings → Media Management
Settings → Root Folders
Les chemins exacts dépendent de votre propre organisation.

3️⃣ Ajouter un client externe
Dans :

Code
Settings → Download Clients
…vous pouvez ajouter un service externe compatible (ex. qBittorrent).

Renseignez uniquement les informations de connexion nécessaires (adresse, port, identifiants).
Les options avancées sont détaillées dans la documentation officielle.

4️⃣ Finaliser et tester
Une fois les éléments configurés :

Utilisez Test pour vérifier la connexion

Cliquez sur Save pour enregistrer

📚 Pour aller plus loin
Ce guide volontairement simplifié ne couvre pas :

Les réglages avancés de Media Management

Les profils de qualité

Les indexers

Les automatisations

Le renommage

Les intégrations avec Radarr, Prowlarr, Bazarr, etc.

Pour une configuration complète et toujours à jour :
👉 https://wiki.servarr.com/sonarr
