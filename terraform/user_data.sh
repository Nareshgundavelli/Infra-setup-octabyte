#!/bin/bash
set -e

# Redirect output to log file
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "🚀 Starting Fast System Setup..."

# 1. Update and Install Minimal Dependencies
apt-get update -y
apt-get install -y docker.io unzip curl

# 2. Install/Update AWS CLI (Required for ECR login)
if command -v aws &> /dev/null; then
    echo "AWS CLI already installed. Updating..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip -q -o awscliv2.zip
    sudo ./aws/install --update
else
    echo "Installing AWS CLI..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip -q -o awscliv2.zip
    sudo ./aws/install
fi
rm -rf awscliv2.zip ./aws
echo "✅ AWS CLI ready."

# 3. Start and Enable Docker
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu

# 4. Install Docker Compose
DOCKER_COMPOSE_VERSION="v2.20.2"
curl -L "https://github.com/docker/compose/releases/download/$${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# 5. Create Monitoring Directory Structure
MONITORING_DIR="/home/ubuntu/monitoring"
mkdir -p $MONITORING_DIR/prometheus
mkdir -p $MONITORING_DIR/grafana/provisioning/datasources
mkdir -p $MONITORING_DIR/grafana/provisioning/dashboards

# 6. Create Monitoring Configuration Files (Cleaned of Windows CRLF)
cat <<'COMPOSE' | tr -d '\r' > $MONITORING_DIR/docker-compose.yml
${docker_compose_content}
COMPOSE

cat <<'PROM' | tr -d '\r' > $MONITORING_DIR/prometheus/prometheus.yml
${prometheus_yml_content}
PROM

cat <<'DS' | tr -d '\r' > $MONITORING_DIR/grafana/provisioning/datasources/datasource.yml
${datasource_yml_content}
DS

cat <<'DB' | tr -d '\r' > $MONITORING_DIR/grafana/provisioning/dashboards/dashboards.yml
${dashboards_yml_content}
DB

cat <<'INFRA' | tr -d '\r' > $MONITORING_DIR/grafana/provisioning/dashboards/infrastructure.json
${infra_dash_content}
INFRA

cat <<'APP' | tr -d '\r' > $MONITORING_DIR/grafana/provisioning/dashboards/application.json
${app_dash_content}
APP

# 7. Start Monitoring Stack
chown -R ubuntu:ubuntu $MONITORING_DIR
cd $MONITORING_DIR
docker-compose up -d

echo "✅ Monitoring stack is starting!"
echo "🚀 Setup script finished."
