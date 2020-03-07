#!/bin/sh

# exit when any command fails
set -e

ADMIN_USERNAME=admin
ADMIN_PASSWORD=admin

# Configure local environment
echo "[*] Configure local environment..."
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=$(grep 'Initial Root Token:' ./keys.txt | awk '{print substr($NF, 1, length($NF))}')

# Create policies
echo "[*] Create policies..."
for f in ./policies/*
do
  filename=$(basename -- "$f")
  filename="${filename%.*}"
  vault policy write $filename $f
done

# Enable userpass & create admin
echo "[*] Enable userpass & create admin..."
vault auth enable userpass
vault write auth/userpass/users/$ADMIN_USERNAME password=$ADMIN_PASSWORD policies=admin

# Create secrets
echo "[*] Create secrets..."
for f in ./secrets/*
do
  filename=$(basename -- "$f")
  filename="${filename%.*}"
  vault secrets enable -path=$filename kv-v2
  vault kv put $filename/config @./secrets/$filename.json
done