#!/usr/bin/env bash
set -e

sudo cp -r /tmp/bootstrap/*.service /etc/systemd/system/
sudo cp -r /tmp/letsencrypt /etc/letsencrypt

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install docker.io certbot kitty-terminfo tmux jq nano vim curl wget ca-certificates

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo systemctl daemon-reload
sudo systemctl enable docker
sudo systemctl start docker

sudo mkdir -p /opt/docker-compose
sudo cp -r /tmp/bootstrap/compose/* /opt/docker-compose

# Scan the /opt/docker-compose directory and replace the service name
# with the directory name and prepull all images
for i in $(find /opt/docker-compose -mindepth 1 -maxdepth 1 -type d); do
  pushd "$i"
  sudo docker-compose pull
  popd

  svc=$(basename "$i")
  sudo systemctl enable docker-compose@$svc
done
