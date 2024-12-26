#!/bin/bash

set -e

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

handle_error() {
    log_message "Error occurred in line $1"
    exit 1
}

trap 'handle_error $LINENO' ERR

log_message "Starting post-create setup..."

# Backend setup
if [ -d "backend" ]; then
    log_message "Setting up backend..."
    cd backend
    if [ -f "requirements.txt" ]; then
        log_message "Installing Python dependencies..."
        pip install --user -r requirements.txt
    else
        log_message "Error: requirements.txt not found in backend directory"
        exit 1
    fi
    cd ..
else
    log_message "Error: backend directory not found"
    exit 1
fi

# Frontend setup
if [ -d "frontend" ]; then
    log_message "Setting up frontend..."
    cd frontend
    if [ -f "package.json" ]; then
        log_message "Installing Node.js dependencies..."
        npm install
    else
        log_message "Error: package.json not found in frontend directory"
        exit 1
    fi
    cd ..
else
    log_message "Error: frontend directory not found"
    exit 1
fi

log_message "Post-create setup completed successfully"