#!/usr/bin/env bash

cat <<EOF > /opt/tapo.yaml
devices:
  tapo-desk: "10.255.0.20"
  tapo-tv: "10.255.0.21"
  tapo-router: "10.255.0.22"
  tapo-server: "10.255.0.23"
  tapo-angie: "10.255.0.24"
EOF

docker run -d \
  -e TAPO_EMAIL="<user>" \
  -e TAPO_PASSWORD="<pass>" \
  -e PORT=9333 \
  -v /opt/tapo.yaml:/app/tapo.yaml:ro \
  -p 0.0.0.0:9333:9333 \
  --restart=unless-stopped \
  --name tapo-P110-exporter \
  povilasid/p110-exporter
