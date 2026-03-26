# 🎬 Tutoriel de configuration de Radarr (version simplifiée)

Radarr est un outil permettant d’automatiser la gestion et l’organisation de vos films.  
Ce guide présente uniquement les grandes étapes, sans entrer dans les détails techniques.  
Pour toute configuration avancée, veuillez consulter la documentation officielle :  
👉 https://radarr.video/

---

## 1️⃣ Accéder à Radarr

Une fois Radarr installé, ouvrez l’interface via : http://IP_DE_VOTRE_SERVEUR:7878

Lors de la première ouverture, créez simplement votre compte administrateur si demandé.

---

## 2️⃣ Définir les dossiers principaux

Radarr doit connaître les emplacements où se trouvent :

- Vos films  
- Les fichiers en cours de traitement  

Ces paramètres se configurent dans :

Settings → Media Management
Settings → Root Folders

Les chemins exacts dépendent de votre propre organisation.

---

## 3️⃣ Ajouter un client externe

Dans :

Settings → Download Clients


…vous pouvez ajouter un service externe compatible (ex. qBittorrent).

Renseignez uniquement les informations de connexion nécessaires (adresse, port, identifiants).  
Les options avancées sont détaillées dans la documentation officielle.

---

## 4️⃣ Configurer les indexers (optionnel)

Dans :

Settings → Indexers

Vous pouvez ajouter des indexers compatibles pour permettre à Radarr de rechercher des informations sur les films.  
Les configurations spécifiques dépendent de vos sources et sont expliquées dans la documentation officielle.

---

## 5️⃣ Finaliser et tester

Une fois les éléments configurés :

- Utilisez **Test** pour vérifier les connexions  
- Cliquez sur **Save** pour enregistrer

---

## 📚 Pour aller plus loin

Ce guide volontairement simplifié ne couvre pas :

- Les profils de qualité  
- Les règles d’importation  
- Les paramètres avancés de Media Management  
- Les automatisations  
- Les intégrations avec Sonarr, Prowlarr, Bazarr, etc.

Pour une configuration complète et toujours à jour :  
👉 https://wiki.servarr.com/radarr

