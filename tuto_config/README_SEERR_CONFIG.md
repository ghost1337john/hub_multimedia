# ⭐ Tutoriel de configuration de Seerr (version simplifiée)

Seerr est une interface permettant aux utilisateurs de faire des demandes de films et séries, et de suivre l'état de leur ajout dans votre bibliothèque.  
Ce guide présente uniquement les grandes étapes, sans entrer dans les détails techniques.  
Pour toute configuration avancée, veuillez consulter la documentation officielle :  
👉 https://docs.seerr.dev/

---

## 1️⃣ Accéder à Seerr

Une fois Seerr installé, ouvrez l'interface via : http://IP_DE_VOTRE_SERVEUR:5055


Lors de la première ouverture, suivez l'assistant de configuration rapide et créez votre compte administrateur.

---

## 2️⃣ Associer Seerr à Radarr et Sonarr

Dans :

Settings → Services


Ajoutez vos instances Radarr et Sonarr en renseignant :

- L'adresse du service  
- Le port  
- La clé API  

Les options avancées sont détaillées dans la documentation officielle.

---

## 3️⃣ Configurer l'authentification

Dans :

Settings → Users


Vous pouvez :

- Activer l'authentification via un fournisseur externe (ex. Plex, Jellyfin, Emby)  
- Gérer les utilisateurs et leurs permissions  

Les méthodes d'authentification sont expliquées en détail dans la documentation officielle.

---

## 4️⃣ Définir les permissions et rôles

Dans :

Settings → Permissions


Vous pouvez définir :

- Les actions autorisées pour les utilisateurs  
- Les limites de demandes  
- Les rôles personnalisés  

Ces paramètres dépendent de votre organisation et de vos besoins.

---

## 5️⃣ Finaliser et tester

Une fois les éléments configurés :

- Vérifiez la connexion à Radarr et Sonarr via **Test**  
- Enregistrez avec **Save**  
- Faites une demande test pour valider le fonctionnement

---

## 📚 Pour aller plus loin

Ce guide volontairement simplifié ne couvre pas :

- Les notifications  
- Les intégrations avancées  
- Les webhooks  
- Les paramètres de quotas  
- Les personnalisations d'interface  

Pour une configuration complète et toujours à jour :  
👉 https://docs.seerr.dev/
