#!/bin/bash
set -e

# Redirect output to log file
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "🚀 Starting System Setup..."

# 1. Update and Install Dependencies
apt-get update -y
apt-get install -y docker.io unzip curl

# 2. Start and Enable Docker
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu

# 3. Install Docker Compose
DOCKER_COMPOSE_VERSION="v2.20.2"
curl -L "https://github.com/docker/compose/releases/download/$${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# 4. Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm -rf awscliv2.zip ./aws

# 5. Create Monitoring Directory Structure
MONITORING_DIR="/home/ubuntu/monitoring"
mkdir -p $MONITORING_DIR/prometheus
mkdir -p $MONITORING_DIR/grafana/provisioning/datasources
mkdir -p $MONITORING_DIR/grafana/provisioning/dashboards

# 6. Create Monitoring Configuration Files
cat <<'COMPOSE' > $MONITORING_DIR/docker-compose.yml
${docker_compose_content}
COMPOSE

cat <<'PROM' > $MONITORING_DIR/prometheus/prometheus.yml
${prometheus_yml_content}
PROM

cat <<'DS' > $MONITORING_DIR/grafana/provisioning/datasources/datasource.yml
${datasource_yml_content}
DS

cat <<'DB' > $MONITORING_DIR/grafana/provisioning/dashboards/dashboards.yml
${dashboards_yml_content}
DB

cat <<'INFRA' > $MONITORING_DIR/grafana/provisioning/dashboards/infrastructure.json
${infra_dash_content}
INFRA

cat <<'APP' > $MONITORING_DIR/grafana/provisioning/dashboards/application.json
${app_dash_content}
APP

# 7. Set Permissions
chown -R ubuntu:ubuntu $MONITORING_DIR

# 8. Start Monitoring Stack
cd $MONITORING_DIR
docker-compose up -d

echo "✅ Monitoring stack is up and running!"
