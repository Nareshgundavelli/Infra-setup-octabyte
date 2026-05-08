#!/bin/bash
set -e

echo "🚀 Starting Monitoring Stack Installation..."

# 1. Install Docker Compose if not present
if ! command -v docker-compose &> /dev/null; then
    echo "Installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

# 2. Wait for Docker to be ready
until sudo docker info &> /dev/null; do
  echo "Waiting for Docker to start..."
  sleep 2
done

# 3. Create Splunk HEC Token (Heuristic)
# Note: In a real production environment, this would be more robust.
# For now, we'll rely on the Splunk container starting up.

# 4. Start Monitoring Stack
cd /home/ubuntu/monitoring
sudo docker-compose up -d

echo "✅ Monitoring stack is up and running!"
echo "Grafana: http://localhost:3000 (admin/admin)"
echo "Prometheus: http://localhost:9090"
echo "Splunk: http://localhost:8000 (admin/SplunkAdmin123)"
