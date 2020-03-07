#!/bin/sh

# exit when any command fails
set -e

# Configure local environment
echo "[*] Configure local environment..."
export VAULT_ADDR=http://127.0.0.1:8200

# Initialize vault
echo "[*] Initialize vault..."
vault operator init > ./keys.txt
export VAULT_TOKEN=$(grep 'Initial Root Token:' ./keys.txt | awk '{print substr($NF, 1, length($NF))}')

# Unseal vault
echo "[*] Unseal vault..."
vault operator unseal $(grep 'Key 1:' ./keys.txt | awk '{print $NF}')
vault operator unseal $(grep 'Key 2:' ./keys.txt | awk '{print $NF}')
vault operator unseal $(grep 'Key 3:' ./keys.txt | awk '{print $NF}')
