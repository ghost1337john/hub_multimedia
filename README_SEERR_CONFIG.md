# 🎟️ Configuration de Seerr (après installation)

Seerr est l’interface utilisateur qui permet de **faire des demandes de films et séries**.  
Il se connecte directement à Radarr, Sonarr et Plex pour automatiser l’ajout de contenus à ton hub multimédia.

Voici comment le configurer proprement après son installation.

---

## 1️⃣ Accéder à Seerr

Ouvre ton navigateur et rends‑toi sur :

**http://IP_DE_TON_SERVEUR:5055**

Lors de la première connexion, Seerr te demandera de créer un compte administrateur.

---

## 2️⃣ Connecter Seerr à Plex

Cette étape permet à Seerr de récupérer :

- les utilisateurs Plex  
- ta médiathèque  
- les statuts “déjà vu / en cours / disponible”  

### ➤ Étape 1 : Récupérer le token Plex

1. Connecte‑toi à Plex dans ton navigateur  
2. Va dans **Paramètres → Compte**  
3. Le token peut être récupéré via l’URL (ou via les outils Plex)

### ➤ Étape 2 : Ajouter Plex dans Seerr

Dans Seerr :

1. Menu → **Settings**
2. Onglet **Plex**
3. Clique sur **Sign in with Plex**
4. Autorise Seerr à accéder à ton serveur Plex

Seerr détectera automatiquement :

- ton serveur Plex  
- tes bibliothèques  
- tes utilisateurs  

---

## 3️⃣ Connecter Seerr à Radarr

1. Menu → **Settings**
2. Onglet **Services**
3. **Add Service → Radarr**

### ➤ Paramètres recommandés

| Paramètre | Valeur |
|----------|--------|
| Name | Radarr |
| Host | `http://radarr:7878` (Docker) ou `http://IP:7878` |
| API Key | récupérée dans Radarr → Settings → General |
| Quality Profile | ton profil préféré (ex : HD-1080p) |
| Root Folder | `/data/films` |
| Minimum Availability | Released |

Clique sur **Test**, puis **Save**.

---

## 4️⃣ Connecter Seerr à Sonarr

1. Menu → **Settings**
2. Onglet **Services**
3. **Add Service → Sonarr**

### ➤ Paramètres recommandés

| Paramètre | Valeur |
|----------|--------|
| Name | Sonarr |
| Host | `http://sonarr:8989` (Docker) ou `http://IP:8989` |
| API Key | récupérée dans Sonarr → Settings → General |
| Quality Profile | HD-1080p (ou autre) |
| Root Folder | `/data/series` |
| Language Profile | French / English selon ton setup |

Clique sur **Test**, puis **Save**.

---

## 5️⃣ Configurer les permissions utilisateurs

Seerr permet de gérer finement ce que les utilisateurs peuvent faire.

1. Menu → **Users**
2. Sélectionne un utilisateur Plex
3. Choisis les permissions :

- **Request Movies**
- **Request TV Shows**
- **Auto‑approve Movies**
- **Auto‑approve Series**
- **Manage Requests**
- **Admin** (à utiliser avec prudence)

Tu peux aussi définir des règles globales dans :

**Settings → Users → Permissions**

---

## 6️⃣ Configurer les notifications (optionnel)

Seerr peut envoyer des notifications via :

- Discord  
- Telegram  
- Slack  
- Webhooks  
- Email  

Pour cela :

1. Menu → **Settings**
2. Onglet **Notifications**
3. Choisis ton service
4. Configure les paramètres (Webhook, Token, etc.)

---

## 7️⃣ Tester une demande

1. Depuis l’accueil, recherche un film ou une série  
2. Clique sur **Request**  
3. Si tout est bien configuré :
   - Seerr envoie la demande à Radarr ou Sonarr  
   - Radarr/Sonarr envoient la recherche à Prowlarr  
   - qBittorrent télécharge  
   - Plex met à jour la bibliothèque  

---

# 🎉 Configuration terminée

Tu as maintenant un Seerr :

- connecté à Plex  
- synchronisé avec Radarr et Sonarr  
- capable de gérer les demandes automatiquement  
- avec permissions utilisateurs  
- avec notifications optionnelles  

Ton hub multimédia est maintenant complet et user‑friendly.

---


