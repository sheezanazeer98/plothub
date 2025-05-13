# PlotHub

---

**PlotHub** is a decentralized property management platform that enables transparent registration, ownership transfer, and verification of real estate plots using blockchain technology. Built with Solidity and Hardhat, it leverages an ERC-20 token system for secure access control and verification.

## Repository Structure

- `contracts/`
    - `RealTok.sol`: Smart contract managing plot registration and ownership.
    - `SecureEstate.sol`: ERC-20 token used for access control and verification.
- `scripts/`: Deployment and interaction scripts (if applicable).
- `test/`: Unit tests (to be implemented).
- `hardhat.config.js`: Hardhat configuration.

---

## Smart Contracts

### 🔹 RealTok.sol

A smart contract that manages:

- **Plot Registration**: Adds metadata for plots like size, location, utility status, and ownership.
- **Ownership Transfer**: Allows admin or current owner to transfer ownership securely.
- **Data Access**: Restricts plot data visibility to verified token holders or the contract owner.
- **Society Grouping**: Organizes plots under `societyId` for better management.
- **Token-Based Access**: Uses `SecureEstate` ERC-20 token to verify users.

### Key Functions:

- `addPlot(...)`: Admin registers a new plot.
- `transferPlotOwnership(...)`: Transfers ownership to another user.
- `getPlotByIdVerified(...)`: Returns plot data for verified token holders.
- `getPlotsBySocietyId(...)`: Fetch plots for a specific society.
- `updateTokenContractAddress(...)`: Update the ERC-20 contract reference.

---

### 🔹 SecureEstate.sol

An ERC-20 utility token contract with:

- **Token Minting**: Admin mints new tokens.
- **Token Transfer**: Users can send tokens or admins can force transfers.
- **Access Control**: Plot data visibility in `RealTok` depends on token ownership.

### Key Functions:

- `mint(address, uint256)`: Owner-only minting.
- `transferTokens(...)`: Transfers tokens with logging.
- `adminTransfer(...)`: Owner can transfer tokens between accounts.
- `hasTokens(address)`: Utility function to check token balance.

---

## Getting Started

### Prerequisites

- Node.js ≥ 16.x
- Hardhat

### Installation

```bash
git clone https://github.com/yourusername/plothub.git
cd plothub
npm install
```

### Compile Contracts

```bash
bash
npx hardhat compile
```

### Deployment (Example)

```bash
bash
npx hardhat run scripts/deploy.js --network localhost
```

---

## Security

- Plot ownership and sensitive access require either admin rights or token verification.
- ERC-20 token interactions are logged via events for transparency.
- All critical functions use `onlyOwner` from OpenZeppelin for role-based access control.

---

## Use Cases

- Decentralized property registration platforms
- Private housing societies
- Real estate verification tools
- Blockchain-based land registry systems

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

## Author

**PlotHub** is developed by [Your Name or Organization].
