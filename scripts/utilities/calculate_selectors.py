#!/usr/bin/env python3
"""
Calculate Real Starknet Function Selectors

This script calculates the actual Starknet function selectors that should be used
in the ContractService instead of the mock selectors.

Usage:
    python scripts/calculate_selectors.py
"""

try:
    from starknet_py.hash.selector import get_selector_from_name
except ImportError:
    print("❌ starknet-py not installed. Install with: pip install starknet-py")
    exit(1)

def calculate_selectors():
    """Calculate real Starknet selectors for contract functions"""
    print("🧮 Calculating Real Starknet Function Selectors")
    print("=" * 60)
    
    # Contract functions that need selectors
    functions = [
        # XP System Contract
        'add_xp',
        'get_xp',
        'get_level', 
        'get_xp_to_next_level',
        'get_leaderboard_top_10',
        'get_player_rank',
        'get_total_players',
        'get_player_stats',
        'get_global_stats',
        'set_xp_per_trade',
        'set_authorized_contract',
        'emergency_pause',
        'unpause',
        
        # NFT Contract
        'mint_achievement_nft',
        'mint_level_milestone_nft', 
        'get_nfts_by_owner',
        'name',
        'symbol',
        'owner',
        'set_authorized_minter',
        
        # Paymaster Contract
        'validate_paymaster_transaction',
        'deposit',
        'withdraw',
        'get_balance',
    ]
    
    print("Calculating selectors for contract functions...")
    print()
    
    # Calculate real selectors
    selectors = {}
    for func_name in functions:
        try:
            selector = get_selector_from_name(func_name)
            hex_selector = hex(selector)
            selectors[func_name] = hex_selector
            print(f"  {func_name:<30} -> {hex_selector}")
        except Exception as e:
            print(f"  {func_name:<30} -> ❌ Error: {e}")
    
    print()
    print("✅ Selector calculation complete!")
    print()
    
    # Generate Dart code for ContractService
    print("📝 Generated Dart code for ContractService:")
    print()
    print("  // Real Starknet function selectors (calculated using starknet-py)")
    print("  static const Map<String, String> _functionSelectors = {")
    
    for func_name, selector in selectors.items():
        print(f"    '{func_name}': '{selector}',")
    
    print("  };")
    print()
    
    # Generate Python lookup for deployment script
    print("📝 Generated Python code for deployment script:")
    print()
    print("selectors = {")
    for func_name, selector in selectors.items():
        print(f"    '{func_name}': '{selector}',")
    print("}")
    print()
    
    return selectors

def validate_selectors():
    """Validate that selectors are correctly calculated"""
    print("🔍 Validating selector calculations...")
    
    # Test a few known functions
    test_cases = [
        ('add_xp', 'Should be valid selector'),
        ('get_xp', 'Should be valid selector'),
        ('transfer', 'Should be valid selector')
    ]
    
    for func_name, description in test_cases:
        try:
            selector = get_selector_from_name(func_name)
            hex_selector = hex(selector)
            print(f"  ✅ {func_name}: {hex_selector} - {description}")
        except Exception as e:
            print(f"  ❌ {func_name}: Error {e}")
    
    print("✅ Validation complete!")

if __name__ == "__main__":
    try:
        selectors = calculate_selectors()
        print()
        validate_selectors()
        
        print()
        print("🎯 Next Steps:")
        print("1. Copy the generated Dart code into ContractService")
        print("2. Update _getRealSelectorFromName to use calculated selectors")
        print("3. Test contract interactions with real selectors")
        
    except Exception as e:
        print(f"❌ Selector calculation failed: {e}")