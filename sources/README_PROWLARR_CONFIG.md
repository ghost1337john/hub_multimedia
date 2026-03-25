# 🧭 Tutoriel de configuration de Prowlarr (après installation)

Prowlarr est le gestionnaire d’indexers de ton hub multimédia. Il centralise tous les indexers et les synchronise automatiquement avec Radarr, Sonarr, Lidarr, Readarr, etc.

Voici comment le configurer correctement après l’installation.

---

# 1️⃣ Accéder à Prowlarr

Ouvre ton navigateur et va sur :

👉 **http://IP_DE_TON_SERVEUR:9696**

---

# 2️⃣ Configurer les indexers

C’est la partie la plus importante.

### ➤ Étape 1 : Ajouter un indexer
1. Dans le menu de gauche, clique sur **Indexers**
2. Clique sur **+ Add Indexer**
3. Choisis un indexer dans la liste :
   - **Publics** : 1337x, Nyaa, RARBG (si dispo), etc.
   - **Privés** : trackers nécessitant un compte
   - **Torznab** : pour les indexers compatibles NZBHydra / Jackett
4. Configure les champs demandés :
   - URL de l’indexer
   - Clé API (si nécessaire)
   - Catégories (Films, Séries, etc.)
   - Ratio de confiance (optionnel)

### ➤ Étape 2 : Tester l’indexer
Clique sur **Test**  
→ Si tout est vert, c’est bon.

### ➤ Étape 3 : Sauvegarder
Clique sur **Save**

---

# 3️⃣ Connecter Prowlarr à Radarr & Sonarr

C’est ce qui permet la synchronisation automatique des indexers.

### ➤ Étape 1 : Aller dans *Settings → Apps*
1. Menu de gauche → **Settings**
2. Onglet **Apps**
3. Clique sur **+ Add Application**

### ➤ Étape 2 : Ajouter Radarr
1. Choisis **Radarr**
2. Renseigne :
   - **Name** : Radarr
   - **Sync Level** : *Full Sync* (recommandé)
   - **URL** :  
     `http://radarr:7878` (si même réseau Docker)  
     ou  
     `http://IP_DE_TON_SERVEUR:7878`
   - **API Key** : récupérable dans Radarr → Settings → General

3. Clique sur **Test**
4. Clique sur **Save**

### ➤ Étape 3 : Ajouter Sonarr
Même procédure que Radarr :

- **URL** :  
  `http://sonarr:8989` (Docker)  
  ou  
  `http://IP_DE_TON_SERVEUR:8989`
- **API Key** : Sonarr → Settings → General

---

# 4️⃣ Vérifier la synchronisation

Une fois Radarr et Sonarr ajoutés :

1. Retourne dans **Indexers**
2. Tu verras une colonne **Sync** avec :
   - Radarr
   - Sonarr

Si tout est vert → la synchro fonctionne.

---

# 5️⃣ Configurer FlareSolverr (si Cloudflare)

Si tu utilises FlareSolverr (souvent nécessaire pour les indexers publics) :

1. Menu → **Settings**
2. Onglet **Indexers**
3. Section **Proxy**
4. Active **Use Proxy**
5. Renseigne :
   - **Proxy Type** : FlareSolverr
   - **URL** :  
     `http://flaresolverr:8191` (Docker)  
     ou  
     `http://IP_DE_TON_SERVEUR:8191`

6. Clique sur **Test**
7. Clique sur **Save**

---

# 6️⃣ Ajuster les catégories (important)

Prowlarr utilise des catégories standardisées.  
Vérifie que les catégories correspondent bien à :

| Type | Catégorie |
|------|-----------|
| Films | 2000 |
| Séries | 5000 |
| Anime | 5070 |
| Musique | 3000 |

Tu peux les modifier dans chaque indexer si nécessaire.

---

# 7️⃣ Vérifier le fonctionnement global

Pour tester :

1. Va dans Radarr ou Sonarr
2. Cherche un film ou une série
3. Lance une recherche manuelle

Si les résultats apparaissent → Prowlarr fonctionne parfaitement.

---

# 🎉 Configuration terminée

Tu as maintenant un Prowlarr entièrement opérationnel :

- Indexers configurés  
- Synchronisation automatique avec Radarr/Sonarr  
- FlareSolverr intégré  
- Catégories propres  
- Tests OK  

---
