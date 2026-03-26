📺 Tutoriel de configuration de Sonarr (version simplifiée)
Sonarr est un outil permettant d’automatiser la gestion de vos séries TV : ajout, suivi, organisation et import des épisodes.
Ce guide présente uniquement les grandes étapes, sans entrer dans les détails techniques.
Pour toute configuration avancée, merci de vous référer à la documentation officielle de Sonarr :
👉 https://sonarr.tv/

1️⃣ Accéder à Sonarr
Après installation, Sonarr est accessible via :
http://IP_DE_VOTRE_SERVEUR:8989

Lors de la première connexion, configurez simplement votre compte administrateur (nom d’utilisateur + mot de passe).

2️⃣ Définir les dossiers principaux
Sonarr doit connaître :

Le dossier où se trouvent vos séries

Le dossier où arrivent vos téléchargements

Ces paramètres se configurent dans Settings → Media Management et Root Folders.
Pour les chemins exacts, référez‑vous à votre propre structure ou à la documentation officielle.

3️⃣ Ajouter un client de téléchargement
Dans Settings → Download Clients, vous pouvez ajouter votre client (ex. qBittorrent).

Renseignez simplement les informations de connexion habituelles (adresse, port, identifiants).
Les options avancées, catégories, gestion des téléchargements terminés, etc., sont expliquées en détail dans la documentation officielle.

4️⃣ Finaliser et tester
Une fois les dossiers et le client configurés :

Cliquez sur Test pour vérifier la connexion

Enregistrez avec Save

📚 Pour aller plus loin
Ce guide volontairement simplifié ne couvre pas :

Les réglages avancés de Media Management

Les profils de qualité

Les indexers

Les catégories et automatisations

Les options de nettoyage ou de renommage

Les intégrations avec Radarr, Prowlarr, Bazarr, etc.

Pour une configuration complète, détaillée et toujours à jour, consultez :
👉 https://wiki.servarr.com/sonarr
