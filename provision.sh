#!/usr/bin/env bash
set -e

echo "=== 1. Actualizando sistema e instalando dependencias base ==="
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg fontconfig openjdk-21-jre git

echo "=== 2. Instalando Docker Engine y Docker Compose ==="
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "=== 3. Instalando Jenkins LTS ==="
sudo curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key -o /etc/apt/keyrings/jenkins-keyring.asc
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y jenkins

echo "=== 4. Permisos Docker para vagrant y jenkins ==="
sudo usermod -aG docker vagrant
sudo usermod -aG docker jenkins
sudo systemctl enable --now docker
sudo systemctl restart jenkins

echo "=== 5. Pre-descargando imagen Nginx para acelerar la demo ==="
sudo docker pull nginx:1.27-alpine

echo "============================================================"
echo " LISTO! Accede a Jenkins en: http://192.168.33.20:8080"
echo " Contrasena inicial:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo "============================================================"