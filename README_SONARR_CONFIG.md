---

# 📺 Tutoriel de configuration de Sonarr (après installation)

Sonarr est l’outil qui automatise la gestion de tes **séries TV** : recherche, téléchargement, renommage, tri, mise à jour…  
Voici comment le configurer proprement après l’installation.

---

# 1️⃣ Accéder à Sonarr

Ouvre ton navigateur et va sur :

👉 **http://IP_DE_TON_SERVEUR:8989**

---

# 2️⃣ Configurer les dossiers

Avant toute chose, Sonarr doit savoir **où stocker tes séries** et **où récupérer les téléchargements**.

### ➤ Dossier de la médiathèque
Dans Sonarr :

1. Menu → **Series**
2. Clique sur **Add Root Folder**
3. Choisis ton dossier séries, par exemple :  
   **/data/series**

### ➤ Dossier des téléchargements
Ce dossier est surveillé pour importer automatiquement les épisodes :

- **/data/qbittorrent/downloads**

Il sera utilisé lors de la configuration du client torrent.

---

# 3️⃣ Ajouter un client torrent (qBittorrent)

1. Menu → **Settings**
2. Onglet **Download Clients**
3. Clique sur **+ Add**
4. Choisis **qBittorrent**

### ➤ Paramètres recommandés

| Paramètre | Valeur |
|----------|--------|
| Name | qBittorrent |
| Host | `qbittorrent` (Docker) ou `IP_DU_SERVEUR` |
| Port | 8080 |
| Username | admin (ou le tien) |
| Password | ton mot de passe |
| Category | sonarr |
| Completed Download Folder | `/data/qbittorrent/downloads` |

### ➤ Test & Save
- Clique sur **Test**  
- Si OK → **Save**

---

# 4️⃣ Connecter Sonarr à Prowlarr

C’est ce qui permet à Sonarr d’utiliser automatiquement tous tes indexers.

### ➤ Étape 1 : Récupérer l’URL et la clé API de Sonarr
Dans Sonarr :

- Menu → **Settings → General**
- Copie la **API Key**

### ➤ Étape 2 : Dans Prowlarr
1. Menu → **Settings**
2. Onglet **Apps**
3. **Add Application**
4. Choisir **Sonarr**

### ➤ Paramètres à renseigner

| Paramètre | Valeur |
|----------|--------|
| Name | Sonarr |
| Sync Level | Full Sync |
| URL | `http://sonarr:8989` (Docker) ou `http://IP:8989` |
| API Key | celle copiée dans Sonarr |

Clique sur **Test**, puis **Save**.

---

# 5️⃣ Configurer les profils de qualité

1. Menu → **Settings**
2. Onglet **Quality**
3. Choisis un profil :
   - **HD-1080p**
   - **HD-720p**
   - **WEB-DL**
   - etc.

Tu peux personnaliser :
- les tailles max/min
- les priorités
- les formats acceptés

---

# 6️⃣ Configurer les langues (si besoin)

1. Menu → **Settings**
2. Onglet **Media Management**
3. Section **Episode Naming**
4. Active :
   - **Rename Episodes**
   - **Replace Illegal Characters**

Tu peux aussi définir :
- Langue préférée
- Format du nom des fichiers
- Format des dossiers

---

# 7️⃣ Ajouter une série

1. Menu → **Series**
2. **Add New Series**
3. Tape le nom de la série
4. Choisis :
   - le dossier racine (`/data/series`)
   - le profil de qualité
   - la langue
   - le monitoring (All / Future / None)

Clique sur **Add**

Sonarr va :
- scanner ta médiathèque  
- rechercher les épisodes manquants  
- envoyer les requêtes à Prowlarr  
- lancer les téléchargements via qBittorrent  

---

# 8️⃣ Vérifier le fonctionnement

Pour tester :

1. Ajoute une série
2. Va dans la série → **Search → Season Search**
3. Si des résultats apparaissent → tout fonctionne

---

# 🎉 Configuration terminée

Tu as maintenant un Sonarr :

- connecté à Prowlarr  
- lié à qBittorrent  
- configuré pour importer automatiquement  
- avec dossiers propres  
- profils de qualité optimisés  

Ton hub multimédia est opérationnel pour les séries.

---

