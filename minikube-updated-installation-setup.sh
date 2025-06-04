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
curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client

echo "📦 Installing minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube version

echo "🚀 Starting minikube with docker driver..."
minikube start --driver=docker

echo "✅ Installation complete! Run 'kubectl get nodes' to check the cluster."
