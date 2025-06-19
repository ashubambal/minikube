#!/bin/bash

set -e

echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "📦 Installing dependencies..."
sudo apt install -y curl wget apt-transport-https ca-certificates gnupg lsb-release software-properties-common

echo "🐳 Installing Docker..."
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

echo "👥 Adding user to docker group..."
sudo usermod -aG docker $USER

echo "🧼 Applying group changes (you may need to logout/login if this fails)..."
newgrp docker || echo "⚠️ Please log out and log back in for docker group to take effect."

echo "📦 Installing kubectl..."
KUBECTL_VERSION=$(curl -s https://dl.k8s.io/release/stable.txt)
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/${KUBECTL_VERSION}/bin/linux/amd64/kubectl.sha256"

echo "🔐 Verifying kubectl checksum..."
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client

echo "📦 Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64  # cleanup after install
minikube version

echo "🚀 Starting Minikube with Docker driver..."
minikube start --driver=docker

echo "✅ Setup complete! Run 'kubectl get nodes' to check your cluster."
