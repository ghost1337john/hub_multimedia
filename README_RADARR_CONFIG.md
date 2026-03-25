# 📘 Configuration de Radarr (après installation)

Radarr est l’outil chargé d’automatiser la gestion de tes **films** : recherche, téléchargement, renommage, tri et mise à jour.  
Voici comment le configurer proprement après son installation.

---

## 1️⃣ Accéder à Radarr

Ouvre ton navigateur et rends‑toi sur :

**http://IP_DE_TON_SERVEUR:7878**

---

## 2️⃣ Configurer les dossiers

Radarr doit connaître :

- le dossier où stocker les films  
- le dossier où qBittorrent dépose les téléchargements  

### ➤ Dossier de la médiathèque

1. Menu → **Movies**  
2. **Add Root Folder**  
3. Sélectionne ton dossier films, par exemple :  
   **/data/films**

### ➤ Dossier des téléchargements

Ce dossier est surveillé pour importer automatiquement les films :

**/data/qbittorrent/downloads**

Il sera utilisé lors de la configuration du client torrent.

---

## 3️⃣ Ajouter qBittorrent comme client de téléchargement

1. Menu → **Settings**  
2. Onglet **Download Clients**  
3. **Add → qBittorrent**

### ➤ Paramètres recommandés

| Paramètre | Valeur |
|----------|--------|
| Name | qBittorrent |
| Host | `qbittorrent` (Docker) ou `IP_DU_SERVEUR` |
| Port | 8080 |
| Username | admin (ou le tien) |
| Password | ton mot de passe |
| Category | radarr |
| Completed Download Folder | `/data/qbittorrent/downloads` |

### ➤ Test & Save

- Clique sur **Test**  
- Si OK → **Save**

---

## 4️⃣ Connecter Radarr à Prowlarr

Pour que Radarr utilise automatiquement tous tes indexers.

### ➤ Étape 1 : Récupérer la clé API de Radarr

Dans Radarr :

- Menu → **Settings → General**
- Copie la **API Key**

### ➤ Étape 2 : Ajouter Radarr dans Prowlarr

Dans Prowlarr :

1. Menu → **Settings**
2. Onglet **Apps**
3. **Add Application**
4. Choisir **Radarr**

### ➤ Paramètres à renseigner

| Paramètre | Valeur |
|----------|--------|
| Name | Radarr |
| Sync Level | Full Sync |
| URL | `http://radarr:7878` (Docker) ou `http://IP:7878` |
| API Key | celle copiée dans Radarr |

Clique sur **Test**, puis **Save**.

---

## 5️⃣ Configurer les profils de qualité

1. Menu → **Settings**
2. Onglet **Quality**
3. Choisis un profil :
   - **HD-1080p**
   - **HD-720p**
   - **WEB-DL**
   - **Remux**
   - **Bluray**

Tu peux ajuster :
- tailles max/min  
- priorités  
- formats acceptés  

---

## 6️⃣ Configurer le renommage et l’organisation

1. Menu → **Settings**
2. Onglet **Media Management**
3. Active :
   - **Rename Movies**
   - **Replace Illegal Characters**

Tu peux personnaliser :
- format des noms de fichiers  
- format des dossiers  
- ajout de l’année, qualité, etc.  

---

## 7️⃣ Ajouter un film

1. Menu → **Movies**
2. **Add New Movie**
3. Recherche ton film
4. Choisis :
   - le dossier racine (`/data/films`)
   - le profil de qualité
   - le monitoring (Yes/No)
   - la langue (si applicable)

Clique sur **Add Movie**

Radarr va :
- scanner ta médiathèque  
- rechercher les films manquants  
- envoyer les requêtes à Prowlarr  
- lancer les téléchargements via qBittorrent  

---

## 8️⃣ Vérifier le fonctionnement

Pour tester :

1. Ajoute un film  
2. Va dans la fiche du film  
3. Clique sur **Search → Manual Search**

Si des résultats apparaissent → tout fonctionne.

---

# 🎉 Configuration terminée

Tu as maintenant un Radarr :

- connecté à Prowlarr  
- lié à qBittorrent  
- configuré pour importer automatiquement  
- avec dossiers propres  
- profils de qualité optimisés  

Ton hub multimédia est opérationnel pour les films.

---
