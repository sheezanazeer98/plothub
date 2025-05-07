
# SecureHub Token Project

This is a Hardhat project for deploying and managing Ethereum smart contracts.

## Prerequisites

Ensure you have the following installed:
- Node.js (>= 14.x)
- npm (comes with Node.js)

## Setup

1. Clone the repository to your local machine:
   ```bash
   git clone <repository_url>
   ```

2. Navigate to the project directory:
   ```bash
   cd <project_directory>
   ```

3. Install the dependencies:
   ```bash
   npm install
   ```

## Commands

### Compile the Contracts
To compile the smart contracts:
```bash
npx hardhat compile
```

### Deploy the Contracts
To deploy the contracts:
```bash
npx hardhat run scripts/deploy.js
```

After deploying, copy the deployed contract addresses from the terminal output.

### Update Backend `.env`
Paste the deployed addresses into the backend's `.env` file. The `.env` file should look like this:
```env
TOKEN_CONTRACT_ADDRESS=<Deployed Token Contract Address>
RS_CONTRACT_ADDRESS=<Deployed Real Estate Contract Address>
```

Example:
```env
TOKEN_CONTRACT_ADDRESS=0x5FbDB2315678afecb367f032d93F642f64180aa3
RS_CONTRACT_ADDRESS=0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
```

## Directory Structure

- `contracts/`: Contains the Solidity smart contract files.
- `scripts/`: Deployment and utility scripts for the project.
- `test/`: Test scripts for the contracts.
- `hardhat.config.js`: Configuration file for Hardhat.

## Important Notes

- Ensure your `.env` file is correctly configured in the backend before running the application.
- Use the same Hardhat network for deployment and backend interaction to ensure consistency.

## Resources

For more information about Hardhat, refer to the [official documentation](https://hardhat.org/docs).

---

Happy coding! 🚀
