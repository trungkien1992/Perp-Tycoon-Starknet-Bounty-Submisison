#!/bin/bash

# Real Contract Deployment Script
# This script actually deploys Cairo contracts to Starknet testnet

set -e

echo "🚀 Real Starknet Contract Deployment"
echo "===================================="

# Load environment
if [ -f "deployment/.env.real" ]; then
    source deployment/.env.real
    echo "✅ Loaded real environment configuration"
else
    echo "❌ Real environment not found. Run setup_real_starknet.sh first."
    exit 1
fi

# Check if account is deployed
if [ "$ACCOUNT_DEPLOYED" != "true" ]; then
    echo "❌ Account not deployed. Please deploy your account first:"
    echo "   starkli account deploy --rpc $STARKNET_RPC --account $STARKNET_ACCOUNT"
    exit 1
fi

# Contract deployment function
deploy_contract() {
    local contract_name=$1
    local contract_dir=$2
    
    echo ""
    echo "📦 Deploying $contract_name..."
    echo "Directory: $contract_dir"
    
    # Navigate to contract directory
    cd "$contract_dir"
    
    # Build contract
    echo "🔨 Building contract..."
    scarb build
    
    if [ ! -f "target/dev/${contract_name}.contract_class.json" ]; then
        echo "❌ Contract build failed - contract class not found"
        return 1
    fi
    
    # Declare contract
    echo "📋 Declaring contract..."
    CLASS_HASH=$(starkli declare \
        --rpc "$STARKNET_RPC" \
        --account "$STARKNET_ACCOUNT" \
        --keystore "$STARKNET_KEYSTORE" \
        "target/dev/${contract_name}.contract_class.json" \
        2>/dev/null | tail -1)
    
    if [ -z "$CLASS_HASH" ]; then
        echo "❌ Contract declaration failed"
        return 1
    fi
    
    echo "✅ Contract declared with class hash: $CLASS_HASH"
    
    # Deploy contract
    echo "🚀 Deploying contract..."
    DEPLOY_RESULT=$(starkli deploy \
        --rpc "$STARKNET_RPC" \
        --account "$STARKNET_ACCOUNT" \
        --keystore "$STARKNET_KEYSTORE" \
        "$CLASS_HASH" \
        2>/dev/null)
    
    CONTRACT_ADDRESS=$(echo "$DEPLOY_RESULT" | grep "Contract deployed:" | cut -d' ' -f3)
    
    if [ -z "$CONTRACT_ADDRESS" ]; then
        echo "❌ Contract deployment failed"
        return 1
    fi
    
    echo "✅ Contract deployed at: $CONTRACT_ADDRESS"
    
    # Store deployment info
    echo "CONTRACT_${contract_name^^}_ADDRESS=$CONTRACT_ADDRESS" >> "../deployment/.env.real"
    echo "CONTRACT_${contract_name^^}_CLASS_HASH=$CLASS_HASH" >> "../deployment/.env.real"
    
    # Return to original directory
    cd - > /dev/null
    
    return 0
}

# Start deployment
echo "🎯 Starting contract deployment..."
echo "Account: $ACCOUNT_ADDRESS"
echo "RPC: $STARKNET_RPC"
echo ""

# Deploy XP Contract
if deploy_contract "streetcred_xp" "contracts/streetcred_xp"; then
    echo "✅ XP Contract deployment successful"
else
    echo "❌ XP Contract deployment failed"
    exit 1
fi

# Deploy NFT Contract
if deploy_contract "street_art_nft" "contracts/street_art_nft"; then
    echo "✅ NFT Contract deployment successful"
else
    echo "❌ NFT Contract deployment failed"
    exit 1
fi

# Deploy Paymaster Contract
if deploy_contract "streetcred_paymaster" "contracts/streetcred_paymaster"; then
    echo "✅ Paymaster Contract deployment successful"
else
    echo "❌ Paymaster Contract deployment failed"
    exit 1
fi

echo ""
echo "🎉 All contracts deployed successfully!"
echo ""
echo "📋 Deployment Summary:"
echo "======================"
source deployment/.env.real
echo "Account: $ACCOUNT_ADDRESS"
echo "XP Contract: $CONTRACT_STREETCRED_XP_ADDRESS"
echo "NFT Contract: $CONTRACT_STREET_ART_NFT_ADDRESS"
echo "Paymaster Contract: $CONTRACT_STREETCRED_PAYMASTER_ADDRESS"
echo ""
echo "🔍 Verify on Starkscan:"
echo "XP Contract: https://sepolia.starkscan.co/contract/$CONTRACT_STREETCRED_XP_ADDRESS"
echo "NFT Contract: https://sepolia.starkscan.co/contract/$CONTRACT_STREET_ART_NFT_ADDRESS"
echo "Paymaster Contract: https://sepolia.starkscan.co/contract/$CONTRACT_STREETCRED_PAYMASTER_ADDRESS"
echo ""
echo "🔧 Next: Update Flutter app configuration with real addresses"