#!/bin/bash
###############################################################################
# AIModelHub - Complete System Cleanup Script
# 
# Stops and removes all running services, containers, processes, and temporary files
# to allow a fresh deployment from scratch (as if the computer just started).
#
# Usage: ./cleanup.sh
###############################################################################

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🧹 AIModelHub - Complete System Cleanup${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXT_DIR="$PROJECT_DIR/AIModelHub_Extensiones"

###############################################################################
# Step 1: Kill Backend Node.js Processes
###############################################################################
echo -e "${YELLOW}[1/8]${NC} Stopping backend Node.js processes..."

# Kill all Node.js processes related to runtime-edc-backend
BACKEND_PIDS=$(ps aux | grep "runtime-edc-backend" | grep -v grep | awk '{print $2}')
if [ ! -z "$BACKEND_PIDS" ]; then
    echo "$BACKEND_PIDS" | xargs kill -9 2>/dev/null && echo -e "${GREEN}✅ Backend processes killed${NC}" || echo -e "${YELLOW}⚠️  No backend processes to kill${NC}"
else
    echo -e "${GREEN}✅ No backend processes running${NC}"
fi

# Kill all Node.js processes on port 3000
PORT_3000_PID=$(lsof -ti:3000 2>/dev/null)
if [ ! -z "$PORT_3000_PID" ]; then
    kill -9 $PORT_3000_PID 2>/dev/null && echo -e "${GREEN}✅ Process on port 3000 killed${NC}"
else
    echo -e "${GREEN}✅ Port 3000 is free${NC}"
fi

###############################################################################
# Step 2: Kill Frontend Angular Processes
###############################################################################
echo -e "${YELLOW}[2/8]${NC} Stopping frontend Angular processes..."

# Kill all ng serve processes
NG_PIDS=$(ps aux | grep "ng serve" | grep -v grep | awk '{print $2}')
if [ ! -z "$NG_PIDS" ]; then
    echo "$NG_PIDS" | xargs kill -9 2>/dev/null && echo -e "${GREEN}✅ Angular processes killed${NC}"
else
    echo -e "${GREEN}✅ No Angular processes running${NC}"
fi

# Kill all Node.js processes on port 4200
PORT_4200_PID=$(lsof -ti:4200 2>/dev/null)
if [ ! -z "$PORT_4200_PID" ]; then
    kill -9 $PORT_4200_PID 2>/dev/null && echo -e "${GREEN}✅ Process on port 4200 killed${NC}"
else
    echo -e "${GREEN}✅ Port 4200 is free${NC}"
fi

###############################################################################
# Step 3: Kill Mock Model Server Python Processes
###############################################################################
echo -e "${YELLOW}[3/8]${NC} Stopping mock model server..."

# Kill mock_server.py processes
MOCK_PIDS=$(ps aux | grep "mock_server" | grep python | grep -v grep | awk '{print $2}')
if [ ! -z "$MOCK_PIDS" ]; then
    echo "$MOCK_PIDS" | xargs kill -9 2>/dev/null && echo -e "${GREEN}✅ Mock server processes killed${NC}"
else
    echo -e "${GREEN}✅ No mock server processes running${NC}"
fi

# Kill processes on port 5001
PORT_5001_PID=$(lsof -ti:5001 2>/dev/null)
if [ ! -z "$PORT_5001_PID" ]; then
    kill -9 $PORT_5001_PID 2>/dev/null && echo -e "${GREEN}✅ Process on port 5001 killed${NC}"
else
    echo -e "${GREEN}✅ Port 5001 is free${NC}"
fi

###############################################################################
# Step 4: Stop and Remove Docker Containers
###############################################################################
echo -e "${YELLOW}[4/8]${NC} Stopping and removing Docker containers..."

# Stop all ml-assets containers
docker stop ml-assets-postgres ml-assets-minio ml-assets-minio-setup ml-assets-backend 2>/dev/null && echo -e "${GREEN}✅ Docker containers stopped${NC}" || echo -e "${YELLOW}⚠️  Some containers were not running${NC}"

# Remove all ml-assets containers
docker rm ml-assets-postgres ml-assets-minio ml-assets-minio-setup ml-assets-backend 2>/dev/null && echo -e "${GREEN}✅ Docker containers removed${NC}" || echo -e "${YELLOW}⚠️  Some containers were already removed${NC}"

# Remove any AIModelHub-related containers
AIMODEL_CONTAINERS=$(docker ps -a | grep -i "aimodelhub\|inesdata" | awk '{print $1}')
if [ ! -z "$AIMODEL_CONTAINERS" ]; then
    echo "$AIMODEL_CONTAINERS" | xargs docker rm -f 2>/dev/null && echo -e "${GREEN}✅ Additional containers removed${NC}"
else
    echo -e "${GREEN}✅ No additional containers found${NC}"
fi

###############################################################################
# Step 5: Remove Docker Volumes (Optional - keeps database fresh)
###############################################################################
echo -e "${YELLOW}[5/8]${NC} Cleaning Docker volumes..."

# List volumes
echo "Available volumes:"
docker volume ls | grep -E "ml-assets|inesdata"

read -p "Do you want to remove Docker volumes? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker volume rm ml-assets-postgres-data ml-assets-minio-data 2>/dev/null && echo -e "${GREEN}✅ Docker volumes removed${NC}" || echo -e "${YELLOW}⚠️  Volumes not found or in use${NC}"
else
    echo -e "${BLUE}ℹ️  Keeping Docker volumes (database data preserved)${NC}"
fi

###############################################################################
# Step 6: Clean Log Files
###############################################################################
echo -e "${YELLOW}[6/8]${NC} Cleaning log files..."

cd "$EXT_DIR"
rm -f backend.log model-server.log nohup.out 2>/dev/null && echo -e "${GREEN}✅ Log files cleaned${NC}" || echo -e "${YELLOW}⚠️  No log files to clean${NC}"

###############################################################################
# Step 7: Clean Node.js Build Artifacts
###############################################################################
echo -e "${YELLOW}[7/8]${NC} Cleaning Node.js build artifacts..."

# Clean backend node_modules and package-lock (optional)
read -p "Do you want to clean node_modules? This will require npm install again (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd "$EXT_DIR/runtime-edc-backend"
    rm -rf node_modules package-lock.json 2>/dev/null && echo -e "${GREEN}✅ Backend node_modules removed${NC}"
    
    cd "$PROJECT_DIR/AIModelHub_EDCUI/ml-browser-app"
    rm -rf node_modules package-lock.json .angular 2>/dev/null && echo -e "${GREEN}✅ Frontend node_modules removed${NC}"
else
    echo -e "${BLUE}ℹ️  Keeping node_modules${NC}"
fi

###############################################################################
# Step 8: Clean Python Virtual Environment (if exists)
###############################################################################
echo -e "${YELLOW}[8/8]${NC} Cleaning Python virtual environment..."

cd "$EXT_DIR/model-server"
if [ -d "venv" ]; then
    rm -rf venv && echo -e "${GREEN}✅ Python venv removed${NC}"
else
    echo -e "${GREEN}✅ No Python venv to remove${NC}"
fi

###############################################################################
# Summary
###############################################################################
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ Cleanup Complete!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "System is now clean and ready for fresh deployment."
echo -e "Run ${GREEN}./deploy.sh${NC} to deploy from scratch."
echo ""

# Show port status
echo -e "${BLUE}Port Status:${NC}"
lsof -i:3000 2>/dev/null && echo "Port 3000: IN USE" || echo -e "${GREEN}Port 3000: FREE${NC}"
lsof -i:4200 2>/dev/null && echo "Port 4200: IN USE" || echo -e "${GREEN}Port 4200: FREE${NC}"
lsof -i:5001 2>/dev/null && echo "Port 5001: IN USE" || echo -e "${GREEN}Port 5001: FREE${NC}"
lsof -i:5432 2>/dev/null && echo "Port 5432: IN USE" || echo -e "${GREEN}Port 5432: FREE${NC}"
lsof -i:9000 2>/dev/null && echo "Port 9000: IN USE" || echo -e "${GREEN}Port 9000: FREE${NC}"
echo ""
