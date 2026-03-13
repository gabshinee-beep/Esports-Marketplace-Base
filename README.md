# Esports Marketplace - Base Layer

A decentralized NFT Marketplace implementation designed for the **Blockchain Accelerator Portfolio**. This project focuses on the core exchange logic between ERC-721 assets and native Ether.

## Technical Specifications
* **Solidity Version:** 0.8.24
* **Framework:** Foundry (Forge)
* **Security:** Integrated `ReentrancyGuard` to mitigate external call vulnerabilities.
* **Dependencies:** OpenZeppelin Contracts (Standard IERC721 interface).

## Core Architecture
1. **Asset Listing:** Verified ownership check through `ownerOf` before storage updates.
2. **Atomic Settlement:** Direct value transfer during the `buyNFT` execution ensuring atomic swaps.
3. **State Management:** Efficient mapping-based storage for listing data to optimize gas consumption.

## Build & Test
```bash
# Compile contracts
./forge build

# Execute test suite
./forge test -vv