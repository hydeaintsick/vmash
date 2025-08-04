#!/bin/bash

# WinWeb Windows 11 Startup Script
# This script starts the Windows 11 configuration

set -e

echo "🚀 Starting WinWeb with Windows 11..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is running
check_docker() {
    if ! docker info > /dev/null 2>&1; then
        print_error "Docker is not running. Please start Docker and try again."
        exit 1
    fi
    print_success "Docker is running"
}

# Check if Node.js is installed
check_node() {
    if ! command -v node &> /dev/null; then
        print_error "Node.js is not installed. Please install Node.js 18+ and try again."
        exit 1
    fi
    
    NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 18 ]; then
        print_error "Node.js version 18+ is required. Current version: $(node -v)"
        exit 1
    fi
    print_success "Node.js $(node -v) is installed"
}

# Install dependencies if needed
install_dependencies() {
    if [ ! -d "node_modules" ]; then
        print_status "Installing Node.js dependencies..."
        npm install
        print_success "Dependencies installed"
    else
        print_status "Dependencies already installed"
    fi
}

# Start Docker services for Windows 11
start_docker_services() {
    print_status "Starting Docker services for Windows 11..."
    
    # Stop any existing containers
    docker compose -f docker-compose.win11.yml down > /dev/null 2>&1 || true
    
    # Start services in background
    docker compose -f docker-compose.win11.yml up -d
    
    print_success "Docker services started"
    print_status "Waiting for services to be ready..."
    
    # Wait for PostgreSQL to be ready
    while ! docker exec winweb-postgres pg_isready -U guacamole_user > /dev/null 2>&1; do
        sleep 2
    done
    print_success "PostgreSQL is ready"
    
    # Wait for Guacamole to be ready
    while ! curl -s http://localhost:8080/guacamole > /dev/null 2>&1; do
        sleep 5
    done
    print_success "Guacamole is ready"
}

# Start Next.js development server
start_frontend() {
    print_status "Starting Next.js development server..."
    print_status "Frontend will be available at: http://localhost:3000"
    print_status "Guacamole admin will be available at: http://localhost:8080/guacamole"
    print_status "Guacamole credentials: guacadmin / guacadmin"
    
    # Start Next.js in background
    npm run dev &
    FRONTEND_PID=$!
    
    # Wait a moment for the server to start
    sleep 3
    
    if kill -0 $FRONTEND_PID 2>/dev/null; then
        print_success "Next.js development server started (PID: $FRONTEND_PID)"
    else
        print_error "Failed to start Next.js development server"
        exit 1
    fi
}

# Show status
show_status() {
    echo ""
    echo "📊 Service Status:"
    echo "=================="
    
    # Check Docker containers
    if docker compose -f docker-compose.win11.yml ps | grep -q "Up"; then
        print_success "Docker containers are running"
        docker compose -f docker-compose.win11.yml ps
    else
        print_error "Docker containers are not running"
    fi
    
    # Check frontend
    if curl -s http://localhost:3000 > /dev/null 2>&1; then
        print_success "Frontend is accessible at http://localhost:3000"
    else
        print_warning "Frontend is not yet accessible"
    fi
    
    # Check Guacamole
    if curl -s http://localhost:8080/guacamole > /dev/null 2>&1; then
        print_success "Guacamole is accessible at http://localhost:8080/guacamole"
    else
        print_warning "Guacamole is not yet accessible"
    fi
}

# Cleanup function
cleanup() {
    print_status "Shutting down services..."
    kill $FRONTEND_PID 2>/dev/null || true
    docker compose -f docker-compose.win11.yml down
    print_success "All services stopped"
    exit 0
}

# Set up signal handlers
trap cleanup SIGINT SIGTERM

# Main execution
main() {
    echo "🎯 WinWeb - Windows 11 Remote Desktop Web App"
    echo "============================================="
    
    check_docker
    check_node
    install_dependencies
    start_docker_services
    start_frontend
    
    echo ""
    print_success "🎉 WinWeb with Windows 11 is now running!"
    echo ""
    echo "📱 Access your application:"
    echo "   • Frontend: http://localhost:3000"
    echo "   • Guacamole Admin: http://localhost:8080/guacamole"
    echo ""
    echo "🔑 Default credentials:"
    echo "   • Guacamole: guacadmin / guacadmin"
    echo "   • Windows 11: Administrator / WinWeb2024!"
    echo ""
    echo "⚠️  Note: Windows 11 requires x86_64 architecture"
    echo "⏹️  Press Ctrl+C to stop all services"
    
    show_status
    
    # Keep script running
    while true; do
        sleep 10
        show_status
    done
}

# Run main function
main 