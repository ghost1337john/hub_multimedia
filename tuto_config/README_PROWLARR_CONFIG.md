# 🧭 Tutoriel de configuration de Prowlarr (version simplifiée)

Prowlarr est un gestionnaire d'indexers centralisé, conçu pour fonctionner avec Sonarr, Radarr et les autres applications de l'écosystème *Arr.  
Ce guide présente uniquement les grandes étapes, sans entrer dans les détails techniques.  
Pour toute configuration avancée, veuillez consulter la documentation officielle :  
👉 https://wiki.servarr.com/prowlarr

---

## 1️⃣ Accéder à Prowlarr

Une fois Prowlarr installé, ouvrez l'interface via : http://IP_DE_VOTRE_SERVEUR:9696


Lors de la première ouverture, configurez simplement votre compte administrateur si demandé.

---

## 2️⃣ Ajouter des indexers

Dans :

Indexers → Add Indexer


…ajoutez les indexers de votre choix.

Chaque indexer peut nécessiter :

- Une clé API  
- Un identifiant  
- Un mot de passe  
- Une URL spécifique  

Les instructions détaillées sont disponibles dans la documentation officielle ou sur le site de chaque indexer.

---

## 3️⃣ Connecter Prowlarr à Sonarr et Radarr

Dans :

Settings → Apps


Ajoutez vos applications *Arr (Sonarr, Radarr, etc.) en renseignant :

- L'adresse du service  
- Le port  
- La clé API  

Prowlarr synchronisera automatiquement les indexers avec ces applications.

---

## 4️⃣ Configurer les catégories (optionnel)

Dans :

Indexers → (Sélectionner un indexer) → Categories


Vous pouvez ajuster les catégories pour correspondre à vos préférences.  
Les valeurs par défaut conviennent dans la majorité des cas.

---

## 5️⃣ Finaliser et tester

Une fois les éléments configurés :

- Utilisez **Test** pour vérifier les connexions  
- Cliquez sur **Save** pour enregistrer  
- Vérifiez que les indexers apparaissent bien dans Sonarr et Radarr

---

## 📚 Pour aller plus loin

Ce guide volontairement simplifié ne couvre pas :

- Les proxys  
- Les indexers privés avancés  
- Les paramètres de ratio  
- Les filtres personnalisés  
- Les intégrations complexes avec d'autres services  

Pour une configuration complète et toujours à jour :  
👉 https://wiki.servarr.com/prowlarr
