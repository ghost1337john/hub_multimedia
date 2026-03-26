# 🐳 Tutoriel de configuration de Portainer (version simplifiée)

Portainer est une interface graphique permettant de gérer, surveiller et administrer vos containers Docker depuis un navigateur.  
Ce guide présente uniquement les grandes étapes, sans entrer dans les détails techniques.  
Pour toute configuration avancée, veuillez consulter la documentation officielle :  
👉 https://docs.portainer.io/

---

## 1️⃣ Accéder à Portainer

Une fois Portainer installé, ouvrez l'interface via : http://IP_DE_VOTRE_SERVEUR:9000

Lors de la première ouverture, vous devrez créer un compte administrateur.

---

## 2️⃣ Créer le compte administrateur

Renseignez :

- Un nom d'utilisateur (par défaut : `admin`)  
- Un mot de passe sécurisé (minimum 12 caractères)  

Cliquez sur **Create user** pour valider.

> ⚠️ Si vous attendez trop longtemps avant de créer le compte, Portainer se verrouille par sécurité. Redémarrez le container pour recommencer.

---

## 3️⃣ Connecter l'environnement Docker

Après la création du compte, Portainer vous propose de connecter un environnement.

Sélectionnez **Docker** → **Connect via socket** (déjà configuré via le docker-compose).

Cliquez sur **Connect** pour finaliser.

---

## 4️⃣ Gérer vos containers

Depuis le menu de gauche, accédez à :

- **Containers** : voir l'état de tous vos containers (Running, Stopped, etc.)  
- **Stacks** : gérer vos docker-compose directement depuis l'interface  
- **Images** : voir les images Docker téléchargées  
- **Volumes** : consulter les volumes persistants  
- **Networks** : visualiser les réseaux Docker  

Vous pouvez démarrer, arrêter, redémarrer ou supprimer un container en un clic.

---

## 5️⃣ Déployer une stack (docker-compose)

Dans : **Stacks** → **Add Stack**

- Donnez un nom à votre stack (ex : `hub_multimedia`)  
- Collez le contenu de votre fichier `docker_compose.yml` dans le Web editor  
- Ajoutez vos variables d'environnement via **Add an environment file**  
- Cliquez sur **Deploy the stack**  

---

## 6️⃣ Consulter les logs d'un container

Pour diagnostiquer un problème :

- Allez dans **Containers**  
- Cliquez sur le nom du container concerné  
- Cliquez sur **Logs** pour voir les messages du container en temps réel  

---

## 7️⃣ Finaliser et tester

Une fois connecté à votre environnement Docker :

- Vérifiez que tous les containers du hub apparaissent dans la liste  
- Testez le redémarrage d'un container depuis l'interface  
- Consultez les logs pour vous assurer que tout fonctionne  

---

## 📚 Pour aller plus loin

Ce guide volontairement simplifié ne couvre pas :

- La gestion multi-environnements (plusieurs serveurs)  
- Les templates d'applications  
- La gestion des utilisateurs et des rôles  
- Les registres Docker privés  
- Les Edge Agents pour la gestion à distance  

Pour une configuration complète et toujours à jour :  
👉 https://docs.portainer.io/
