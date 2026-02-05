#!/bin/bash

echo "🐳 Browser Automation Docker Setup"
echo "===================================="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

echo "✅ Docker is installed"
echo ""

# Step 1: Build image
echo "Step 1️⃣  Building Docker image..."
docker build -t browser-automation .

if [ $? -ne 0 ]; then
    echo "❌ Build failed"
    exit 1
fi

echo "✅ Image built successfully"
echo ""

# Step 2: Run container
echo "Step 2️⃣  Running container..."
docker run --rm -v "$(pwd):/app" browser-automation

if [ $? -ne 0 ]; then
    echo "❌ Container failed"
    exit 1
fi

echo ""
echo "✅ All done!"
echo "📸 Check screenshot.png in the current directory"
