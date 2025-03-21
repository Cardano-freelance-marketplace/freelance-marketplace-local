### Deployment & Infrastructure

- **Frontend Hosting:** TBD
- **Backend Hosting:** TBD
- **Smart Contracts:** Deployed on Cardano Testnet → Mainnet

## **Setup Guide**

### **Prerequisites**
Ensure you have the following installed:

```sh
# Install Node.js & npm
sudo apt update && sudo apt install nodejs npm -y

# Install Python 3 & Poetry
sudo apt install python3 python3-pip -y
curl -sSL https://install.python-poetry.org | python3 -

# Install Git
sudo apt install git -y
```

### **Backend (FastAPI with Poetry)**

```sh
# Clone the repository
git clone https://github.com/yourusername/cardano-marketplace.git
cd cardano-marketplace/backend

# Install dependencies
poetry install

# Run the FastAPI server
poetry run uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

### **Frontend (React with TypeScript)**

```sh
cd ../frontend

# Install dependencies
npm install

# Start the development server
npm run dev
```

### **Smart Contracts (Aiken)**

```sh
# Install Aiken
curl --proto '=https' --tlsv1.2 -LsSf https://install.aiken-lang.org | sh

# Install aiken to PATH by following terminal instructions

# Verify installation
aiken --version

# Initialize the Aiken project
cd ../smart-contracts
aiken new marketplace-contract
cd marketplace-contract

# Build the contract
aiken build

# Run tests
aiken check
```
### **Cardano Node**

Clone Ogmios repository
```sh
git clone git@github.com:CardanoSolutions/ogmios.git
```

Get the cardano node file configs from : 

https://developers.cardano.org/docs/get-started/cardano-node/running-cardano

Into /server/config/network/preview/cardano-node

```sh
NETWORK=preview docker compose up -d
```

---