Sonarr : version 4.0.17.2952

# 📺 Tutoriel de configuration de Sonarr (après installation)

Sonarr est l’outil qui automatise la gestion de tes **séries TV** : recherche, téléchargement, renommage, tri, mise à jour…  
Voici comment le configurer proprement après l’installation.

# 1️⃣ Accéder à Sonarr

Ouvre ton navigateur et va sur :

👉 **http://IP_DE_TON_SERVEUR:8989**

A la premiere connexion, il faudra configurer ton **UserAdmin** et **Password** avec Authentification type **Forms**

---

# 2️⃣ Configurer les dossiers

Avant toute chose, Sonarr doit savoir **où stocker tes séries** et **où récupérer les téléchargements**.

### ➤ Dossier de la médiathèque
Dans Sonarr :

1. Menu  → **Settings** → **Media Management**
2. Active **Rename Episodes** et **Replace Illegal Characters**
3. Active **Delete Empty Folders**
4. Active **Unmonitor Deleted Episode**
5. Clique sur **Add Root Folder** dans la catégorie **Root Folders**
6. Choisis ton dossier séries, par exemple :  
   **/data/series**

### ➤ Dossier des téléchargements

Il a été configuré au moment du déploiement du container.
Ce dossier est surveillé pour importer automatiquement les épisodes :

- **/data/qbittorrent/downloads**

Il sera utilisé lors de la configuration du client torrent.

<img width="500" height="500" alt="image" src="https://github.com/user-attachments/assets/26985f2d-2c9c-4407-b652-8b38dd3866cf" />



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
| Host | `qBittorrent` (Docker) ou `IP_DU_SERVEUR` |
| Port | 8080 |
| Username | admin (ou le tien) |
| Password | ton mot de passe |
| Category | sonarr |
| Completed Download Handling | Remove Completed → Active

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

# 5️⃣ Configurer les profils de qualité dans Sonarr

1. Menu → **Settings**
2. Onglet **Profiles**
3. Choisis ou ajout un **Quality profil** et modifier le à ta convenance :
   - **HD-1080p**
   - **HD-720p**
   - **WEB-DL**
   - etc
  Tu peux personnaliser :
   - les tailles max/min
   - les priorités
   - les formats acceptés
4. Pour pouvoir supprimer un profil il faut activé l'affichage **Avancé** et afficher le profil puis **Delete*
5. Choisis ou ajout un **Release profil** et modifier le à ta convenance puis **Enable Profile** : (exemple)
   - Name : French Multi
   - Must Contain : multi, french, truefrench, vf, vfi...

---

# 6️⃣ Configurer des customs formats (si besoin)

1. Menu → **Settings**
2. Onglet **Custom Formats**
3. Choisis ou ajout un **Custom Format**
4. Exemple pour s'assurer d'aller chercher un film contenant du français :
   - Name : French
   - Add Condition **Release Title**
      - Name : FRENCH
      - Regular Expression : FRENCH
      - Required : Enable
5. Retourne dans **Profiles** et selectionne un **Qualiity Profile** et tu verras que tu peux prioriser le **Custom Format** que tu as créé.

---

# 7️⃣ Ajouter une série (qui sera automatiser par la suite via des requêtes depuis Seer)

1. Menu → **Series**
2. **Add New Series**
3. Tape le nom de la série
4. Choisis :
   - le dossier racine (`/data/series`)
   - le profil de qualité
   - ...
5. Clique sur **Add**

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

