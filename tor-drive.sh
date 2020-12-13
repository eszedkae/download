#!/bin/bash

apk add unzip
mkdir /downloads
curl https://rclone.org/install.sh | sudo bash
rclone config
mount drive:/Downloads /downloads
docker run -d \
  --name=qbittorrent \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e UMASK_SET=022 \
  -e WEBUI_PORT=8080 \
  -p 6881:6881 \
  -p 6881:6881/udp \
  -p 8080:8080 \
  -v /downloads:/downloads \
  --restart unless-stopped \
  ghcr.io/linuxserver/qbittorrent
