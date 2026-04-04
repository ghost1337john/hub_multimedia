# 📺 Tutoriel de configuration de Plex (version simplifiée)

Plex est un serveur multimédia permettant de centraliser, organiser et diffuser vos films, séries et musiques sur tous vos appareils.  
Ce guide présente uniquement les grandes étapes, sans entrer dans les détails techniques.  
Pour toute configuration avancée, veuillez consulter la documentation officielle :  
👉 https://support.plex.tv/

---

## 1️⃣ Accéder à Plex

Une fois Plex installé, ouvrez l'interface via : http://IP_DE_VOTRE_SERVEUR:32400/web

Lors de la première ouverture, vous serez redirigé vers la page de connexion Plex.

---

## 2️⃣ Créer ou connecter un compte Plex

- Connectez-vous avec votre compte Plex (ou créez-en un sur https://plex.tv)  
- Acceptez les conditions d'utilisation  
- Plex détectera automatiquement le serveur local  

> ⚠️ Si le serveur n'est pas détecté, vérifiez que le port 32400 n'est pas bloqué par un firewall.

---

## 3️⃣ Nommer le serveur

L'assistant de configuration vous propose de nommer votre serveur Plex.

- Choisissez un nom facilement identifiable (ex : `SRV-PLEX`)
- Cochez ou décochez l'option **Autoriser l'accès à distance** selon vos besoins

---

## 4️⃣ Ajouter les bibliothèques

C'est l'étape principale. Ajoutez vos bibliothèques en pointant vers les dossiers montés dans le container :

| Type de bibliothèque | Chemin dans le container |
|----------------------|--------------------------|
| Films                | `/movies`                |
| Séries               | `/series`                |

Pour chaque bibliothèque :

- Cliquez sur **Ajouter une bibliothèque**  
- Sélectionnez le type (Films, Séries TV, Musique, etc.)  
- Parcourez les dossiers et sélectionnez le chemin correspondant  
- Validez  

> 💡 Les chemins `/movies` et `/series` correspondent aux volumes `/data` et `/data2` montés dans le docker-compose.

---

## 5️⃣ Configurer la langue et les agents

Dans : Paramètres → Bibliothèques → (votre bibliothèque) → Gérer

- Définissez la langue de préférence pour les métadonnées (ex : Français)  
- Plex téléchargera automatiquement les affiches, résumés et informations  

---

## 6️⃣ Configurer l'accès à distance (optionnel)

Dans : Paramètres → Accès à distance

- Activez l'accès à distance pour accéder à Plex depuis l'extérieur  
- Plex tentera de configurer automatiquement le port 32400  
- Si nécessaire, configurez une redirection de port sur votre routeur  

> ⚠️ Plex utilise `network_mode: host` dans le docker-compose, donc les ports sont directement exposés sur le serveur.

---

## 7️⃣ Inviter des utilisateurs (optionnel)

Dans : Paramètres → Utilisateurs et partage

- Cliquez sur **Inviter un ami**  
- Renseignez l'adresse email ou le nom d'utilisateur Plex  
- Choisissez les bibliothèques à partager  
- L'utilisateur recevra une invitation par email  

---

## 8️⃣ Finaliser et tester

Une fois les bibliothèques ajoutées :

- Lancez un scan des bibliothèques : Bibliothèques → (votre bibliothèque) → Scanner les fichiers  
- Vérifiez que les films et séries apparaissent avec les bonnes métadonnées  
- Testez la lecture sur un appareil (navigateur, TV, mobile)  
- Vérifiez que Tautulli détecte l'activité si configuré  

---

## 📚 Pour aller plus loin

Ce guide volontairement simplifié ne couvre pas :

- La configuration du transcodage matériel (GPU)  
- Les sous-titres intégrés et les paramètres de lecture  
- Les playlists et collections  
- L'optimisation des performances serveur  
- Plex Pass et les fonctionnalités premium  

Pour une configuration complète et toujours à jour :  
👉 https://support.plex.tv/articles/
