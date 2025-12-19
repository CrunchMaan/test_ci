apt update && apt upgrade -y
apt install curl wget git vim htop tmux unzip zip jq tree net-tools rsync lsof iotop iftop nethogs sysstat dstat glances btop ncdu duf nginx apache2 haproxy caddy certbot postgresql postgresql-contrib redis-server build-essential python3-pip python3-venv nodejs npm neofetch screenfetch ranger mc iptables-persistent wireguard openvpn nfs-common cifs-utils mosh docker.io
curl -fsSL https://get.docker.com | sh

# Настройка UFW firewall    
apt install -y ufw
ufw allow OpenSSH               # Или ufw allow 2222/tcp для кастомного порта
ufw allow 80/tcp                # HTTP, если нужно
ufw allow 443/tcp               # HTTPS, если нужно
ufw default deny incoming
ufw default allow outgoing
ufw enable
ufw status verbose



# на клиенте
ssh-keygen -t ed25519 -C "your_email@example.com"
cat ~/.ssh/id_ed25519.pub

#ssh-copy-id -i ~/.ssh/id_ed25519.pub your_email@example.com

# доступные ключи
mkdir -p ~/.ssh
nano ~/.ssh/authorized_keys   # Вставьте ключ
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys


# Установка Docker  
curl -fsSL https://get.docker.com | sh
docker --version

# Установка Docker Compose
apt install docker-compose-plugin -y


mkdir -p /opt/test_ci

echo 'DATABASE_URL=postgresql://app_user:very_strong_assword@db:5432/app_db' > /opt/test_ci/.env

sudo systemctl start docker
sudo systemctl enable docker

git clone https://github.com/CrunchMaan/test_ci.git /opt/test_ci
cd /opt/test_ci && docker compose up -d 



docker build -t ghcr.io/crunchmaan/test_ci:latest .

# локально
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0