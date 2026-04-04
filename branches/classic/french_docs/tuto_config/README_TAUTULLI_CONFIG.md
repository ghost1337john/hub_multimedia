# 📊 Tutoriel de configuration de Tautulli (version simplifiée)

Tautulli est un outil permettant de surveiller l'activité de votre serveur Plex et de consulter des statistiques détaillées.  
Ce guide présente uniquement les grandes étapes, sans entrer dans les détails techniques.  
Pour toute configuration avancée, veuillez consulter la documentation officielle :  
👉 https://tautulli.com/

---

## 1️⃣ Accéder à Tautulli

Une fois Tautulli installé, ouvrez l'interface via : http://IP_DE_VOTRE_SERVEUR:8181

Lors de la première ouverture, suivez l'assistant de configuration rapide.

---

## 2️⃣ Associer Tautulli à Plex

L'assistant vous demandera de connecter votre serveur Plex.  
Renseignez simplement :

- L'adresse de votre serveur Plex  
- Le port (par défaut : 32400)  
- Votre identifiant Plex (connexion via compte Plex)  

Une fois connecté, sélectionnez le serveur Plex que vous souhaitez surveiller.

---

## 3️⃣ Configurer les notifications (optionnel)

Dans : Settings → Notification Agents

Vous pouvez configurer des notifications pour être alerté lors de certains événements :

- Lecture / pause / arrêt d'un média  
- Ajout de nouveaux contenus  
- Problèmes sur le serveur  

Plusieurs agents sont disponibles (Discord, Telegram, Email, etc.).  
Renseignez les informations de connexion propres à chaque agent.

---

## 4️⃣ Consulter l'activité et les statistiques

Depuis le tableau de bord, vous pouvez visualiser :

- Les lectures en cours en temps réel  
- L'historique des lectures  
- Les statistiques par utilisateur, bibliothèque ou média  

Ces informations sont disponibles directement sans configuration supplémentaire.

---

## 5️⃣ Finaliser et tester

Une fois les éléments configurés :

- Vérifiez que l'activité Plex remonte correctement sur le tableau de bord  
- Utilisez **Test Notification** pour vérifier vos agents de notification  
- Cliquez sur **Save** pour enregistrer

---

## 📚 Pour aller plus loin

Ce guide volontairement simplifié ne couvre pas :

- Les newsletters automatiques  
- Les réglages avancés de surveillance  
- Les scripts personnalisés  
- L'export de statistiques  
- Les intégrations avancées avec Plex  

Pour une configuration complète et toujours à jour :  
👉 https://github.com/Tautulli/Tautulli/wiki
