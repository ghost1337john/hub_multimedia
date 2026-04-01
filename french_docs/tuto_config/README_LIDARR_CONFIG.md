# 🎵 Tutoriel de configuration de Lidarr (version simplifiée)

Lidarr est un outil permettant d'automatiser la gestion et l'organisation de votre musique.  
Ce guide présente uniquement les grandes étapes, sans entrer dans les détails techniques.  
Pour toute configuration avancée, veuillez consulter la documentation officielle :  
👉 https://lidarr.audio/

---

## 1️⃣ Accéder à Lidarr

Une fois Lidarr installé, ouvrez l'interface via : http://IP_DE_VOTRE_SERVEUR:8686

Lors de la première ouverture, vous serez guidé par l'assistant de configuration.

---

## 2️⃣ Définir les dossiers principaux

Lidarr doit connaître les emplacements où se trouvent :

- Votre bibliothèque musicale  
- Les fichiers en cours de traitement  

Ces paramètres se configurent dans :

Settings → Media Management
Settings → Root Folders

Les chemins exacts dépendent de votre propre organisation.

---

## 3️⃣ Ajouter un client de téléchargement

Dans :

Settings → Download Clients

…vous pouvez ajouter un service externe compatible (ex. qBittorrent).

Renseignez uniquement les informations de connexion nécessaires (adresse, port, identifiants).  
Les options avancées sont détaillées dans la documentation officielle.

---

## 4️⃣ Configurer les indexers (optionnel)

Dans :

Settings → Indexers

Vous pouvez ajouter des indexers compatibles pour permettre à Lidarr de rechercher des informations sur les artistes et albums.  
Les configurations spécifiques dépendent de vos sources et sont expliquées dans la documentation officielle.

---

## 5️⃣ Ajouter des artistes et albums

Une fois configuré, vous pouvez :

1. Rechercher des artistes via `Add Artists`
2. Sélectionner les albums que vous souhaitez télécharger
3. Lidarr s'occupera automatiquement du reste

---

## 6️⃣ Finaliser et tester

Une fois les éléments configurés :

- Utilisez **Test** pour vérifier les connexions  
- Cliquez sur **Save** pour enregistrer

---

## 📚 Pour aller plus loin

Ce guide volontairement simplifié ne couvre pas :

- Les profils de qualité  
- Les règles d'importation  
- Les paramètres avancés de Media Management  
- Les automatisations  
- Les intégrations avec Prowlarr, etc.

Pour une configuration complète et toujours à jour :  
👉 https://wiki.servarr.com/lidarr
