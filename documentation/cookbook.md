## **Setup Guide**

### **Prerequisites**
Ensure you have the following installed:

```sh
# Dependencies 
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release


# Install Docker && Docker compose 
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.gpg > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable docker
sudo systemctl start docker
sudo docker --version

## Test docker
docker run hello-world


# Install Node.js & npm
sudo apt update && sudo apt install nodejs npm -y

# Install Python 3 & Poetry
sudo apt install python3 python3-pip -y
curl -sSL https://install.python-poetry.org | python3 -

# Install Git
sudo apt install git -y
```
## Git clone all repositories
Clone the repositories so your folder looks like this : 

├── Workchain-be

├── Workchain-fe

├── Workchain-local

├── Workchain-sc

├── Workchain-tx

├── Workchain-auth

└── ogmios


### **Backend (FastAPI with Poetry)**

```sh
# Install dependencies
poetry install

# Run the FastAPI server
sudo chmod +x start_dev.sh
./start_dev.sh
```

### **Frontend (React with TypeScript)**

```sh
# Install dependencies
npm install

# Start the development server
npm start
```

### **Smart Contracts (Aiken)**

```sh
# Install Aiken
curl --proto '=https' --tlsv1.2 -LsSf https://install.aiken-lang.org | sh

# Install aiken to PATH by following terminal instructions

## Run this command
aikup

# Verify installation
aiken --version

# Build the contract
aiken build

# Run tests
aiken check
```
### **Cardano Node**

```sh
#Clone Ogmios repository
git clone git@github.com:CardanoSolutions/ogmios.git

#Get the cardano node file configs from : 
https://developers.cardano.org/docs/get-started/cardano-node/running-cardano
```

#### If the project is running in TESTNET environment


##### Get PREVIEW file configs 
```
sudo curl -O -J https://book.play.dev.cardano.org/environments/preview/config.json
sudo curl -O -J https://book.play.dev.cardano.org/environments/preview/db-sync-config.json
sudo curl -O -J https://book.play.dev.cardano.org/environments/preview/submit-api-config.json
sudo curl -O -J https://book.play.dev.cardano.org/environments/preview/topology.json
sudo curl -O -J https://book.play.dev.cardano.org/environments/preview/byron-genesis.json
sudo curl -O -J https://book.play.dev.cardano.org/environments/preview/shelley-genesis.json
sudo curl -O -J https://book.play.dev.cardano.org/environments/preview/alonzo-genesis.json
sudo curl -O -J https://book.play.dev.cardano.org/environments/preview/conway-genesis.json
```
##### Place the file configs inside :
/cardano-job-marketplace/ogmios/server/config/network/preview/cardano-node


### ENV VARIABLES
Get the environment variables .env for the local repository from the env variables Thread inside discord.

Place the .env file in the root of local repository

### **Databases and Docker**
```sh 
#RUN 
./start_local_env.sh

#inside Workchain-local repository to initialize :
  - MongoDB database
  - PostgresSQL database
  - Cardano-node
  - Ogmios
  - Authorization Microservice
  - Txwatcher Microservice
  - Frontend
  - Backend

#IF YOU HAVE PERMISSIONS ISSUES RUNNING THE SCRIPTS RUN 
sudo chmod +x start_local_env.sh
```
