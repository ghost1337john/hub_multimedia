# 🧹 Tutoriel de configuration de CleanUpArr (version simplifiée)

CleanUpArr est un outil permettant de maintenir propre et cohérente votre bibliothèque multimédia en automatisant certaines tâches de nettoyage.  
Ce guide présente uniquement les grandes étapes, sans entrer dans les détails techniques.  
Pour toute configuration avancée, veuillez consulter la documentation officielle du projet.

https://github.com/cleanuparr/cleanuparr

---

## 1️⃣ Accéder à CleanUpArr

Une fois CleanUpArr installé, ouvrez l'interface via l'adresse configurée dans votre environnement.  
Selon votre installation, cela peut ressembler à : http://IP_DE_VOTRE_SERVEUR:PORT

---

## 2️⃣ Associer CleanUpArr à vos services *Arr

Dans :

Settings → Services


Ajoutez les applications que vous souhaitez intégrer (Sonarr, Radarr, etc.) en renseignant :

- L'adresse du service  
- Le port  
- La clé API  

CleanUpArr utilisera ces connexions pour analyser et nettoyer les éléments concernés.

---

## 3️⃣ Configurer les règles de nettoyage

Dans :

Settings → Queue Cleaner
Settings → Download Cleaner

Vous pouvez activer ou désactiver les règles proposées par CleanUpArr.  
Chaque règle peut être ajustée selon vos préférences.  
Les explications détaillées sont disponibles dans la documentation officielle.

---

## 4️⃣ Lancer une analyse

Dans :

Dashboard → Jobs → Run Now

Vous pouvez lancer une analyse manuelle pour vérifier l'état de votre bibliothèque.  
Les actions proposées dépendront des règles activées.

---

## 5️⃣ Finaliser et automatiser

Une fois la configuration terminée :

- Vérifiez que les services sont bien connectés  
- Activez l'automatisation si souhaité  
- Enregistrez avec **Save**

---

## 📚 Pour aller plus loin

Ce guide volontairement simplifié ne couvre pas :

- Les règles avancées  
- Les actions automatiques complexes  
- Les intégrations externes supplémentaires  
- Les paramètres de logs ou de diagnostic  

Pour une configuration complète et toujours à jour, référez‑vous à la documentation officielle du projet.
https://github.com/cleanuparr/cleanuparr
