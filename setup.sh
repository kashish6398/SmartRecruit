#!/bin/bash

echo "========================================="
echo "SmartRecruit Setup Script"
echo "========================================="
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check Node.js
echo -e "${YELLOW}Checking Node.js...${NC}"
if command -v node &> /dev/null
then
    echo -e "${GREEN}✓ Node.js $(node -v) found${NC}"
else
    echo "✗ Node.js not found. Please install Node.js >= 16.x"
    exit 1
fi

# Check Python
echo -e "${YELLOW}Checking Python...${NC}"
if command -v python3 &> /dev/null
then
    echo -e "${GREEN}✓ Python $(python3 --version) found${NC}"
else
    echo "✗ Python3 not found. Please install Python >= 3.8"
    exit 1
fi

# Check MongoDB
echo -e "${YELLOW}Checking MongoDB...${NC}"
if command -v mongod &> /dev/null
then
    echo -e "${GREEN}✓ MongoDB $(mongod --version | head -n 1) found${NC}"
else
    echo "⚠ MongoDB not found locally. You can use MongoDB Atlas instead."
fi

echo ""
echo "========================================="
echo "Installing Dependencies"
echo "========================================="
echo ""

# Backend dependencies
echo -e "${YELLOW}Installing backend dependencies...${NC}"
cd backend
npm install
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Backend dependencies installed${NC}"
else
    echo "✗ Failed to install backend dependencies"
    exit 1
fi

# Create .env if not exists
if [ ! -f .env ]; then
    cp .env.example .env
    echo -e "${GREEN}✓ Created backend/.env file${NC}"
    echo -e "${YELLOW}⚠ Please update backend/.env with your configurations${NC}"
fi

cd ..

# AI Engine dependencies
echo -e "${YELLOW}Installing AI engine dependencies...${NC}"
cd ai-engine
pip install -r requirements.txt --break-system-packages
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ AI engine dependencies installed${NC}"
else
    echo "✗ Failed to install AI engine dependencies"
    exit 1
fi
cd ..

# Frontend dependencies
echo -e "${YELLOW}Installing frontend dependencies...${NC}"
cd frontend
npm install
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Frontend dependencies installed${NC}"
else
    echo "✗ Failed to install frontend dependencies"
    exit 1
fi

# Create .env if not exists
if [ ! -f .env ]; then
    cp .env.example .env
    echo -e "${GREEN}✓ Created frontend/.env file${NC}"
fi

cd ..

echo ""
echo "========================================="
echo "Setup Complete!"
echo "========================================="
echo ""
echo "Next Steps:"
echo "1. Update backend/.env with your configurations"
echo "   - MongoDB URI"
echo "   - JWT secret"
echo "   - Email credentials"
echo ""
echo "2. Start the backend:"
echo "   cd backend && npm start"
echo ""
echo "3. Start the frontend (in a new terminal):"
echo "   cd frontend && npm start"
echo ""
echo "4. Open http://localhost:3000 in your browser"
echo ""
echo -e "${GREEN}Happy Recruiting with AI! 🎉${NC}"
