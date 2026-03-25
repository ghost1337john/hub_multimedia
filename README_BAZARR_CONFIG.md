# 💬 Configuration de Bazarr (après installation)

Bazarr est l’outil chargé de gérer automatiquement les **sous‑titres** de tes films et séries.  
Il s’intègre directement avec Radarr et Sonarr pour télécharger, mettre à jour et organiser les sous‑titres dans les bonnes langues.

Voici comment le configurer proprement après son installation.

---

## 1️⃣ Accéder à Bazarr

Ouvre ton navigateur et rends‑toi sur :

**http://IP_DE_TON_SERVEUR:6767**

---

## 2️⃣ Configurer les chemins des bibliothèques

Bazarr doit connaître l’emplacement de tes films et séries pour pouvoir y déposer les sous‑titres.

### ➤ Dossier des films

1. Menu → **Settings**  
2. Onglet **Movies**  
3. **Add Movie Root Folder**  
4. Sélectionne ton dossier films :  
   **/data/films**

### ➤ Dossier des séries

1. Menu → **Settings**  
2. Onglet **Series**  
3. **Add Series Root Folder**  
4. Sélectionne ton dossier séries :  
   **/data/series**

---

## 3️⃣ Connecter Bazarr à Radarr & Sonarr

C’est indispensable pour que Bazarr sache quels films/séries tu possèdes.

### ➤ Ajouter Radarr

1. Menu → **Settings**
2. Onglet **Radarr**
3. Clique sur **Add Radarr Server**

Renseigne :

| Paramètre | Valeur |
|----------|--------|
| URL | `http://radarr:7878` (Docker) ou `http://IP:7878` |
| API Key | récupérée dans Radarr → Settings → General |
| Movies Root Folder | `/data/films` |

Clique sur **Test**, puis **Save**.

### ➤ Ajouter Sonarr

1. Menu → **Settings**
2. Onglet **Sonarr**
3. **Add Sonarr Server**

Renseigne :

| Paramètre | Valeur |
|----------|--------|
| URL | `http://sonarr:8989` (Docker) ou `http://IP:8989` |
| API Key | récupérée dans Sonarr → Settings → General |
| Series Root Folder | `/data/series` |

Clique sur **Test**, puis **Save**.

---

## 4️⃣ Configurer les langues des sous‑titres

1. Menu → **Settings**
2. Onglet **Languages**
3. Choisis les langues que tu veux télécharger, par exemple :
   - **French**
   - **English**
4. Active :
   - **Hearing Impaired** (si tu veux les versions sourds/malentendants)
   - **Forced Subtitles** (si tu veux les sous‑titres forcés)

---

## 5️⃣ Configurer les fournisseurs de sous‑titres

Bazarr utilise des sites spécialisés pour télécharger les sous‑titres.

1. Menu → **Settings**
2. Onglet **Providers**
3. Active les fournisseurs que tu veux utiliser :
   - **OpenSubtitles**
   - **Addic7ed**
   - **Subscene**
   - **Podnapisi**
   - etc.

### ➤ OpenSubtitles (recommandé)

1. Clique sur **OpenSubtitles**
2. Renseigne ton **username** et **password**
3. Clique sur **Test**
4. **Save**

---

## 6️⃣ Configurer les préférences de téléchargement

1. Menu → **Settings**
2. Onglet **Subtitles**
3. Paramètres recommandés :

- **Minimum Score** : 80  
- **Upgrade Subtitles** : ON  
- **Download Only One Subtitle** : OFF  
- **Use Hearing Impaired** : selon tes besoins  
- **Use Forced Subtitles** : ON si tu veux les sous‑titres forcés  

---

## 7️⃣ Lancer un scan de ta médiathèque

1. Menu → **Movies**  
2. Clique sur **Scan Disk**

Puis :

1. Menu → **Series**  
2. Clique sur **Scan Disk**

Bazarr va analyser tous tes films et séries et détecter les sous‑titres manquants.

---

## 8️⃣ Vérifier le fonctionnement

Pour tester :

1. Va dans **Movies** ou **Series**
2. Choisis un film ou un épisode
3. Clique sur **Search Subtitles**

Si des sous‑titres apparaissent → tout fonctionne.

---

# 🎉 Configuration terminée

Tu as maintenant un Bazarr :

- connecté à Radarr et Sonarr  
- configuré pour télécharger automatiquement les sous‑titres  
- avec les bonnes langues  
- avec des fournisseurs fiables  
- capable de mettre à jour les sous‑titres existants  

Ton hub multimédia est maintenant complet.

---
