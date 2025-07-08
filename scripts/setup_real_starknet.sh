#!/bin/bash

# Real Starknet Setup Script
# This script sets up actual Starknet testnet deployment

set -e

echo "🔧 Setting up Real Starknet Integration..."

# Configuration
WALLET_DIR="$HOME/.starkli-wallets"
KEYSTORE_FILE="$WALLET_DIR/streetcred_keystore.json"
ACCOUNT_FILE="$WALLET_DIR/streetcred_account.json"
RPC_URL="https://starknet-sepolia.public.blastapi.io"

# Create wallet directory
mkdir -p "$WALLET_DIR"

echo "📁 Wallet directory: $WALLET_DIR"

# Step 1: Create keystore (if not exists)
if [ ! -f "$KEYSTORE_FILE" ]; then
    echo "🔐 Creating new keystore..."
    echo "You will be prompted to enter a password for your keystore."
    starkli signer keystore new "$KEYSTORE_FILE"
    echo "✅ Keystore created: $KEYSTORE_FILE"
else
    echo "✅ Keystore already exists: $KEYSTORE_FILE"
fi

# Step 2: Initialize account descriptor (if not exists)
if [ ! -f "$ACCOUNT_FILE" ]; then
    echo "👤 Initializing account descriptor..."
    starkli account oz init "$ACCOUNT_FILE" --keystore "$KEYSTORE_FILE"
    echo "✅ Account descriptor created: $ACCOUNT_FILE"
else
    echo "✅ Account descriptor already exists: $ACCOUNT_FILE"
fi

# Step 3: Get account address
echo "📋 Getting account address..."
ACCOUNT_ADDRESS=$(starkli account address --account "$ACCOUNT_FILE")
echo "🏠 Account Address: $ACCOUNT_ADDRESS"

# Step 4: Check account deployment status
echo "🔍 Checking account deployment status..."
if starkli account verify --rpc "$RPC_URL" --account "$ACCOUNT_FILE" 2>/dev/null; then
    echo "✅ Account is already deployed"
    ACCOUNT_DEPLOYED=true
else
    echo "❌ Account not deployed yet"
    ACCOUNT_DEPLOYED=false
fi

# Step 5: Generate environment configuration
echo "📝 Generating environment configuration..."
cat > "deployment/.env.real" << EOF
# Real Starknet Configuration
STARKNET_KEYSTORE=$KEYSTORE_FILE
STARKNET_ACCOUNT=$ACCOUNT_FILE
STARKNET_RPC=$RPC_URL
ACCOUNT_ADDRESS=$ACCOUNT_ADDRESS
ACCOUNT_DEPLOYED=$ACCOUNT_DEPLOYED

# Export these for starkli commands
export STARKNET_KEYSTORE=$KEYSTORE_FILE
export STARKNET_ACCOUNT=$ACCOUNT_FILE
export STARKNET_RPC=$RPC_URL
EOF

echo "✅ Configuration saved to deployment/.env.real"

# Step 6: Instructions for next steps
echo ""
echo "🎯 Next Steps:"
echo ""
if [ "$ACCOUNT_DEPLOYED" = false ]; then
    echo "1. Fund your account with testnet ETH:"
    echo "   Visit: https://starknet-faucet.vercel.app/"
    echo "   Address: $ACCOUNT_ADDRESS"
    echo ""
    echo "2. Deploy your account:"
    echo "   starkli account deploy --rpc $RPC_URL --account $ACCOUNT_FILE"
    echo ""
fi

echo "3. Compile and deploy contracts:"
echo "   ./scripts/real_deploy_contracts.sh"
echo ""
echo "4. Verify deployment:"
echo "   Check on Starkscan: https://sepolia.starkscan.co/contract/$ACCOUNT_ADDRESS"
echo ""

echo "🔧 Setup complete! Your Starknet infrastructure is ready."