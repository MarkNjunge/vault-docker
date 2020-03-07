# Vault + Docker

Run [Vault](https://www.vaultproject.io/) in a Docker container.  

Requires Vault CLI.

## Installation

1. Clone the repository.

2. Modify [`config.hcl`](config.hcl).

3. Add policies to `./policies/`

4. Add secrets in json format to `./secrets/`

## Usage

### 1. Start the Vault container

```
docker build -t marknjunge/vault .
docker run --name vault -p 8200:8200 --cap-add IPC_LOCK marknjunge/vault
```

OR

```
docker-compose up -d
```

### 2. Unseal Vault

Use the [Vault ui](http://localhost:8200/ui/) to generate keys and unseal or use the following command.

```
./1-unseal.sh
```

### 3. Run setup

This script enables userpass, create an admin user, creates your policies and creates your secrets.

```
./2-setup.sh
```

### 4. Login

Login to [Vault ui](http://localhost:8200/ui/) using:

```
username: admin
password: admin
```
