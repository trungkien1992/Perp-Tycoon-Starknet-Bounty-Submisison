# 🚀 Real Starknet Deployment Guide

This guide provides step-by-step instructions for deploying StreetCred Minimal with **actual Starknet contracts** on the blockchain.

## ⚠️ Important Notice

**Previous Status**: The project was using mock/simulated Starknet integration.

**Current Status**: This guide enables **real blockchain deployment** with actual contracts on Starknet testnet.

## 📋 Prerequisites

- **starkli** CLI tool installed
- **scarb** Cairo compiler installed
- **Flutter** 3.10+ with web support
- **Testnet ETH** for deployment (from faucet)

## 🔧 Step 1: Setup Real Starknet Account

Run the automated setup script:

```bash
./scripts/setup_real_starknet.sh
```

This will:
- Create a new Starknet keystore with encrypted private key
- Initialize account descriptor 
- Generate environment configuration
- Provide funding instructions

**Manual Alternative:**
```bash
# Create keystore
starkli signer keystore new ~/.starkli-wallets/streetcred_keystore.json

# Initialize account
starkli account oz init ~/.starkli-wallets/streetcred_account.json \
  --keystore ~/.starkli-wallets/streetcred_keystore.json

# Get account address
starkli account address --account ~/.starkli-wallets/streetcred_account.json
```

## 💰 Step 2: Fund Account

1. **Get your account address** from Step 1 output
2. **Visit Starknet faucet**: https://starknet-faucet.vercel.app/
3. **Request testnet ETH** for your account address
4. **Deploy account contract**:
   ```bash
   starkli account deploy \
     --rpc https://starknet-sepolia.public.blastapi.io \
     --account ~/.starkli-wallets/streetcred_account.json
   ```

## 🏗️ Step 3: Deploy Contracts

Run the real deployment script:

```bash
./scripts/real_deploy_contracts.sh
```

This will:
- Compile all Cairo contracts using `scarb build`
- Declare contracts to get class hashes
- Deploy XP, NFT, and Paymaster contracts
- Update environment configuration with real addresses

**Manual Alternative:**
```bash
# Deploy XP Contract
cd contracts/streetcred_xp
scarb build
starkli declare --rpc https://starknet-sepolia.public.blastapi.io \
  --account ~/.starkli-wallets/streetcred_account.json \
  --keystore ~/.starkli-wallets/streetcred_keystore.json \
  target/dev/streetcred_xp.contract_class.json

# Deploy using returned class hash
starkli deploy --rpc https://starknet-sepolia.public.blastapi.io \
  --account ~/.starkli-wallets/streetcred_account.json \
  --keystore ~/.starkli-wallets/streetcred_keystore.json \
  <CLASS_HASH>

# Repeat for other contracts...
```

## ✅ Step 4: Verify Deployment

Run the verification script:

```bash
./scripts/verify_real_deployment.sh
```

This will:
- Verify account deployment
- Check all contracts are accessible
- Test contract functions
- Provide blockchain explorer links

## 🌐 Step 5: Blockchain Explorer Verification

Visit these links to verify your contracts are live:

- **Sepolia Starkscan**: https://sepolia.starkscan.co/
- **Sepolia Voyager**: https://sepolia.voyager.online/

Search for your contract addresses to see:
- Contract deployment transactions
- Contract code and functions
- Recent activity

## 📱 Step 6: Update Flutter App

Update your Flutter app to use real contract addresses:

```bash
# Load real environment
source deployment/.env.real

# Run app in real mode
flutter run -d web \
  --dart-define=APP_MODE=real \
  --dart-define=XP_CONTRACT_ADDRESS=$CONTRACT_STREETCRED_XP_ADDRESS \
  --dart-define=NFT_CONTRACT_ADDRESS=$CONTRACT_STREET_ART_NFT_ADDRESS
```

## 🧪 Step 7: Test Real Transactions

1. **Login** to the app
2. **Execute a trade** (this will call `gainXP`)
3. **Check console** for real transaction hash
4. **Verify on explorer** using the transaction hash

Expected flow:
```
Flutter App → XPNotifier.gainXP() → ContractService.addXPToContract() 
→ RealStarknetService.addXPToContract() → starkli invoke → Starknet RPC 
→ Contract execution → Transaction hash → Blockchain explorer
```

## 📂 Generated Files

After successful deployment, you'll have:

```
deployment/
├── .env.real                    # Real environment configuration
├── contracts_deployed.json     # Deployment metadata
└── deployment_receipt.json     # Transaction receipts

~/.starkli-wallets/
├── streetcred_keystore.json    # Encrypted private key
└── streetcred_account.json     # Account descriptor
```

## 🔐 Security Considerations

### ✅ What's Secure
- Private keys are encrypted in keystore
- Account deployment uses real Starknet account contracts
- Transactions are signed with real cryptographic signatures
- Contract interactions use actual RPC calls

### ⚠️ Development Notice
- This is for **testnet only** - no real money at risk
- Private keys are generated for testing purposes
- For production, integrate with ArgentX/Braavos wallets

## 🎯 Real vs Mock Comparison

| Component | Mock Mode | Real Mode |
|-----------|-----------|-----------|
| **Private Key** | Random test key | Encrypted keystore |
| **Account** | Simulated | Deployed contract |
| **Transactions** | Simulated | Actual blockchain |
| **Signatures** | Mock crypto | Real ECDSA |
| **Contract Calls** | Fake responses | RPC to Starknet |
| **Explorer** | None | Visible on Starkscan |

## 🚨 Troubleshooting

### Account Not Deployed
```bash
# Check deployment status
starkli account verify --rpc https://starknet-sepolia.public.blastapi.io \
  --account ~/.starkli-wallets/streetcred_account.json

# If not deployed, ensure account is funded then:
starkli account deploy --rpc https://starknet-sepolia.public.blastapi.io \
  --account ~/.starkli-wallets/streetcred_account.json
```

### Contract Declaration Failed
```bash
# Check if contract compiled
cd contracts/streetcred_xp
scarb build
ls target/dev/

# Check if keystore is accessible
starkli signer keystore inspect ~/.starkli-wallets/streetcred_keystore.json
```

### Transaction Failed
```bash
# Check account balance
starkli account balance --rpc https://starknet-sepolia.public.blastapi.io \
  --account ~/.starkli-wallets/streetcred_account.json

# Check transaction status
starkli transaction get --rpc https://starknet-sepolia.public.blastapi.io <TX_HASH>
```

## 🎉 Success Criteria

You have **real Starknet integration** when:

✅ **Account is deployed** on Starknet testnet
✅ **Contracts are deployed** and visible on blockchain explorer  
✅ **Contract functions** can be called via starkli
✅ **Flutter app** executes real transactions
✅ **Transaction hashes** are visible on explorer
✅ **XP gains** are written to actual blockchain
✅ **Leaderboard** is read from actual contract state

## 🔄 Migration from Mock to Real

If you have existing mock data:

1. **Backup** any important test data
2. **Run real deployment** following this guide
3. **Update app configuration** with real addresses
4. **Test thoroughly** before production use

## 📞 Support

If you encounter issues:

1. **Check logs** in deployment scripts
2. **Verify prerequisites** are installed
3. **Ensure testnet funding** is sufficient
4. **Consult Starknet documentation**

---

**This guide transforms your StreetCred Minimal app from mock blockchain integration to real Starknet deployment with actual contracts on the blockchain.**