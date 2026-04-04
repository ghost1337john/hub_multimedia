# Installer Portainer séparément

Portainer ne doit pas être inclus dans le docker-compose du hub classique, car il sert à gérer les stacks Docker (y compris ce hub) et ne doit pas s’auto-gérer.

## Installation rapide de Portainer

```bash
sudo docker volume create portainer_data
sudo docker run -d \
  -p 9000:9000 \
  --name=portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest
```

Accédez ensuite à l’interface : http://IP_DE_VOTRE_SERVEUR:9000

Créez le compte administrateur à la première connexion.

> Pour déployer le hub multimédia, utilisez l’interface Stacks de Portainer et collez le contenu du docker-compose classique (sans Portainer).
