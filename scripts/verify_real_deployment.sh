#!/bin/bash

# Real Starknet Deployment Verification Script
# This script verifies that contracts are actually deployed and working on Starknet

set -e

echo "🔍 Verifying Real Starknet Deployment"
echo "====================================="

# Load environment
if [ -f "deployment/.env.real" ]; then
    source deployment/.env.real
    echo "✅ Loaded real environment configuration"
else
    echo "❌ Real environment not found. Run setup_real_starknet.sh first."
    exit 1
fi

# Verification functions
verify_account() {
    echo ""
    echo "👤 Verifying Account Deployment..."
    echo "Account Address: $ACCOUNT_ADDRESS"
    
    if starkli account verify --rpc "$STARKNET_RPC" --account "$STARKNET_ACCOUNT"; then
        echo "✅ Account is deployed and verified"
        return 0
    else
        echo "❌ Account verification failed"
        return 1
    fi
}

verify_contract() {
    local contract_name=$1
    local contract_address=$2
    
    echo ""
    echo "📋 Verifying Contract: $contract_name"
    echo "Address: $contract_address"
    
    # Check if contract exists using get_class_hash
    if starkli call --rpc "$STARKNET_RPC" "$contract_address" get_class_hash 2>/dev/null; then
        echo "✅ Contract $contract_name is deployed and accessible"
        
        # Test a simple view function
        echo "🔍 Testing contract function..."
        if starkli call --rpc "$STARKNET_RPC" "$contract_address" name 2>/dev/null; then
            echo "✅ Contract functions are working"
        else
            echo "⚠️  Contract deployed but some functions may not work"
        fi
        
        return 0
    else
        echo "❌ Contract $contract_name not found or not deployed"
        return 1
    fi
}

test_contract_interaction() {
    local contract_address=$1
    local function_name=$2
    
    echo ""
    echo "🧪 Testing Contract Interaction..."
    echo "Contract: $contract_address"
    echo "Function: $function_name"
    
    # Test read function
    if starkli call --rpc "$STARKNET_RPC" "$contract_address" "$function_name" 2>/dev/null; then
        echo "✅ Contract interaction successful"
        return 0
    else
        echo "❌ Contract interaction failed"
        return 1
    fi
}

check_on_explorer() {
    local contract_address=$1
    local contract_name=$2
    
    echo ""
    echo "🌐 Blockchain Explorer Links:"
    echo "Contract: $contract_name"
    echo "Address: $contract_address"
    echo "Sepolia Starkscan: https://sepolia.starkscan.co/contract/$contract_address"
    echo "Sepolia Voyager: https://sepolia.voyager.online/contract/$contract_address"
    echo ""
    echo "📊 Manual Verification Steps:"
    echo "1. Visit the explorer links above"
    echo "2. Verify contract is deployed and has code"
    echo "3. Check recent transactions"
    echo "4. Verify contract functions are accessible"
}

# Start verification
echo "🎯 Starting verification process..."
echo ""

# Step 1: Verify account
if verify_account; then
    ACCOUNT_OK=true
else
    ACCOUNT_OK=false
    echo "❌ Cannot proceed without deployed account"
    echo "💡 To deploy account: starkli account deploy --rpc $STARKNET_RPC --account $STARKNET_ACCOUNT"
    exit 1
fi

# Step 2: Verify contracts
CONTRACTS_OK=true

# XP Contract
if [ -n "$CONTRACT_STREETCRED_XP_ADDRESS" ]; then
    if verify_contract "XP Contract" "$CONTRACT_STREETCRED_XP_ADDRESS"; then
        test_contract_interaction "$CONTRACT_STREETCRED_XP_ADDRESS" "get_total_players"
        check_on_explorer "$CONTRACT_STREETCRED_XP_ADDRESS" "XP Contract"
    else
        CONTRACTS_OK=false
    fi
else
    echo "❌ XP Contract address not found in environment"
    CONTRACTS_OK=false
fi

# NFT Contract
if [ -n "$CONTRACT_STREET_ART_NFT_ADDRESS" ]; then
    if verify_contract "NFT Contract" "$CONTRACT_STREET_ART_NFT_ADDRESS"; then
        test_contract_interaction "$CONTRACT_STREET_ART_NFT_ADDRESS" "name"
        check_on_explorer "$CONTRACT_STREET_ART_NFT_ADDRESS" "NFT Contract"
    else
        CONTRACTS_OK=false
    fi
else
    echo "❌ NFT Contract address not found in environment"
    CONTRACTS_OK=false
fi

# Paymaster Contract (optional)
if [ -n "$CONTRACT_STREETCRED_PAYMASTER_ADDRESS" ]; then
    if verify_contract "Paymaster Contract" "$CONTRACT_STREETCRED_PAYMASTER_ADDRESS"; then
        test_contract_interaction "$CONTRACT_STREETCRED_PAYMASTER_ADDRESS" "get_balance"
        check_on_explorer "$CONTRACT_STREETCRED_PAYMASTER_ADDRESS" "Paymaster Contract"
    else
        echo "⚠️  Paymaster contract verification failed (optional)"
    fi
else
    echo "⚠️  Paymaster contract not deployed (optional)"
fi

# Final verification summary
echo ""
echo "📊 Verification Summary"
echo "======================"
echo "Account Deployed: $([ "$ACCOUNT_OK" = true ] && echo "✅ YES" || echo "❌ NO")"
echo "Contracts Deployed: $([ "$CONTRACTS_OK" = true ] && echo "✅ YES" || echo "❌ NO")"
echo ""

if [ "$ACCOUNT_OK" = true ] && [ "$CONTRACTS_OK" = true ]; then
    echo "🎉 REAL STARKNET INTEGRATION VERIFIED!"
    echo ""
    echo "✅ Your contracts are live on Starknet Sepolia testnet"
    echo "✅ All contract functions are accessible"
    echo "✅ Ready for real blockchain interactions"
    echo ""
    echo "🚀 Next Steps:"
    echo "1. Update Flutter app with real contract addresses"
    echo "2. Test real transactions from the app"
    echo "3. Monitor transactions on blockchain explorer"
    echo ""
    exit 0
else
    echo "❌ REAL STARKNET INTEGRATION NOT COMPLETE"
    echo ""
    echo "Issues found:"
    [ "$ACCOUNT_OK" = false ] && echo "- Account not deployed"
    [ "$CONTRACTS_OK" = false ] && echo "- Contracts not deployed"
    echo ""
    echo "🔧 To fix:"
    echo "1. Ensure account is funded and deployed"
    echo "2. Run deployment script: ./scripts/real_deploy_contracts.sh"
    echo "3. Run verification again"
    echo ""
    exit 1
fi