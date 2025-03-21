#!/bin/bash

# Run docker compose in the current directory
docker compose up -d

# Store the current directory
CURRENT_DIR=$(pwd)

# Define the path to the other docker-compose folder
OGMIOS_DIR="../ogmios/"  # Adjust this path

# Navigate to the other folder
cd "$OGMIOS_DIR" || { echo "Directory not found"; exit 1; }

# Run docker compose with NETWORK=preview
NETWORK=preview docker compose up -d

# Return to the original directory
cd "$CURRENT_DIR"
