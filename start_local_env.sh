#!/bin/bash

NETWORK=preview docker compose up -d --build

# Wait for the container to be up and the socket to exist
while ! docker exec freelance_cardano_node test -S /ipc/node.socket; do
  echo "Waiting for /ipc/node.socket to be created..."
  sleep 1
done

echo "Running chmod 777 on /ipc/node.socket"
# Change permissions inside the container
docker exec freelance_cardano_node chmod 777 /ipc/node.socket

