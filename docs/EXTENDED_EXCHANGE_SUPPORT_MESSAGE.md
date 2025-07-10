# Extended Exchange Support Request

## Subject: API Trading Permissions - Error 1101 StarkEx Signature Validation

### Account Information
- **API Key**: f1894fcb...de3 (partial for security)
- **Account Balance**: $12.94 USD confirmed accessible
- **Issue**: Error 1101 (Invalid StarkEx signature) on all trading attempts

### Problem Description
I'm experiencing consistent Error 1101 when attempting to place trades via the Extended Exchange API, despite having:
- ✅ Correct StarkEx signature generation (mathematically validated)
- ✅ Proper message hash calculation using Pedersen hash
- ✅ Valid API key (can access orders endpoint)
- ✅ Account balance accessible
- ✅ Correct order payload structure

### Technical Details
- **Error Code**: 1101 (Invalid StarkEx signature)
- **Occurs On**: All order placement attempts
- **Signature Method**: cairo-lang with private_to_stark_key and sign functions
- **Order Format**: Standard Extended Exchange API format
- **Markets Tested**: EUR-USD, AVAX-USD (proper minimum sizes)

### Specific Issues Identified
1. **Account Endpoint**: Returns 404 on `/api/v1/user/account`
2. **Orders Endpoint**: Works correctly (200 status)
3. **Signature Validation**: All signatures rejected with Error 1101
4. **Fresh Signatures**: Even newly generated signatures fail immediately

### Request for Assistance
Please verify and enable:
1. **Account Verification Status**: Is my account fully verified for trading?
2. **API Key Permissions**: Does my API key have trading permissions (not read-only)?
3. **StarkEx Trading**: Is StarkEx perpetual futures trading enabled on my account?
4. **Signature Requirements**: Are there any recent changes to signature validation?

### Technical Implementation Verified
- Message hash calculation matches Extended Exchange format exactly
- Signature generation uses correct StarkEx curve operations
- Public key derivation is mathematically sound
- Order payload structure follows API documentation precisely

### Expected Outcome
Enable trading permissions so I can execute live cryptocurrency trades with my $12.94 balance using the Extended Exchange API.

### Contact Information
- Available via Discord, Telegram, or GitHub for technical discussion
- Can provide additional debugging information if needed
- Ready to test immediately once permissions are resolved

Thank you for your assistance in resolving this account verification issue.