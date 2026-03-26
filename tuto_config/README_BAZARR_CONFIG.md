# 💬 Tutoriel de configuration de Bazarr (version simplifiée)

Bazarr est un outil permettant de gérer automatiquement les sous‑titres de vos films et séries.  
Ce guide présente uniquement les grandes étapes, sans entrer dans les détails techniques.  
Pour toute configuration avancée, veuillez consulter la documentation officielle :  
👉 https://www.bazarr.media/

---

## 1️⃣ Accéder à Bazarr
 
Une fois Bazarr installé, ouvrez l’interface via : http://IP_DE_VOTRE_SERVEUR:6767

Lors de la première ouverture, suivez l’assistant de configuration rapide.

---

## 2️⃣ Associer Bazarr à Sonarr et Radarr

Dans :

Settings → Sonarr
Settings → Radarr

…ajoutez vos instances existantes en renseignant simplement :

- L’adresse du service  
- Le port  
- La clé API  

Les options avancées sont détaillées dans la documentation officielle.

---

## 3️⃣ Définir les langues de sous‑titres

Dans : Settings → Languages


Sélectionnez les langues que vous souhaitez utiliser pour vos sous‑titres.  
Vous pouvez en activer plusieurs selon vos besoins.

---

## 4️⃣ Configurer les fournisseurs de sous‑titres

Dans : Settings → Providers


Activez les fournisseurs que vous souhaitez utiliser.  
Certains nécessitent la création d’un compte ou une clé API.  
Les instructions spécifiques sont disponibles sur le site officiel.

---

## 5️⃣ Finaliser et tester

Une fois les éléments configurés :

- Utilisez **Test** pour vérifier les connexions  
- Cliquez sur **Save** pour enregistrer

---

## 📚 Pour aller plus loin

Ce guide volontairement simplifié ne couvre pas :

- Les réglages avancés de détection  
- Les filtres de qualité  
- Les règles de remplacement  
- Les paramètres de synchronisation  
- Les intégrations avancées avec Sonarr et Radarr  

Pour une configuration complète et toujours à jour :  
👉 https://wiki.bazarr.media/




