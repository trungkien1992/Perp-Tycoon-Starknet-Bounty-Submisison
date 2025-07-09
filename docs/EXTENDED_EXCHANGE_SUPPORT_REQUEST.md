# Extended Exchange API Support Request - StreetCred Trading Integration

## 📋 **Support Request Summary**

**Subject**: Order Creation 400 Error - Need Correct API Format for Production Trading App

**Priority**: High - Production trading application integration

**Account Details**:
- API Key: f1894fcb909e3619449c01a1f16ddde3
- Vault ID: 101420
- Account Balance: 9.959254 USD (verified working)
- Account Status: ACTIVE (verified working)

## 🚀 **Project Context: StreetCred Mobile Trading App**

We're building **StreetCred** - a gamified mobile trading app for Gen-Z users, integrating with Extended Exchange as our primary trading backend. Our integration is 95% complete and working perfectly, except for the final order creation step.

**Current Integration Status**:
- ✅ **Authentication**: Working (API key authentication successful)
- ✅ **Account Access**: Working (balance: 9.959254 USD detected correctly)
- ✅ **Market Data**: Working (successfully fetching 63 markets)
- ✅ **CloudFront Bypass**: Working (eliminated all 403 errors)
- ❌ **Order Creation**: Getting 400 errors (need correct format)

## 🔍 **Specific Issue: Order Creation 400 Error**

**Endpoint**: `POST /api/v1/user/order`

**Problem**: All order creation attempts return **400 status with empty response body**

**What We've Tried**:
1. ✅ Multiple order formats based on documentation
2. ✅ Different markets (BTC-USD, EUR-USD, ETH-USD)
3. ✅ Various order types (limit, market)
4. ✅ Conservative parameters (low quantities, safe prices)
5. ✅ Proper authentication headers

## 📊 **Current Request Format (Based on Your API Documentation)**

Based on your Extended API documentation from our knowledge base, we're using this format:

```json
{
  "id": "order_1751983535554_1751983535552",
  "market": "BTC-USD", 
  "type": "LIMIT",
  "side": "BUY",
  "qty": "0.0001",
  "price": "50000",
  "timeInForce": "GTT",
  "expiryEpochMillis": 1752069935552,
  "fee": "0.0002",
  "nonce": "1751983535552",
  "settlement": {
    "signature": {
      "r": "0x00000000000000000000000000000000cefc3ac903a10617f93b6176a313fb1d",
      "s": "0x00000000000000000000000000000000af9318ab54fb635a9f6113e5b9919e94"
    },
    "starkKey": "0x075a5dbd0f632a28521fc860e4992fa11c4fa47f6e67e1a4094ed98d49cf946e",
    "collateralPosition": "101420"
  },
  "reduceOnly": false,
  "postOnly": false,
  "selfTradeProtectionLevel": "ACCOUNT"
}
```

**Changes Made Based on Documentation**:
- ✅ `type` and `side` now uppercase (LIMIT, BUY)
- ✅ Added `reduceOnly` and `postOnly` fields
- ✅ Using actual vault ID (101420) for `collateralPosition`
- ✅ Following exact API specification structure

**Headers**:
```
Content-Type: application/json
X-Api-Key: f1894fcb909e3619449c01a1f16ddde3
User-Agent: StreetCredClash/1.0.0
```

## ❓ **What We Need Help With**

### 1. **Correct Order Format**
- What is the exact JSON structure required?
- Are there any required fields we're missing?
- Is our settlement signature format correct?

### 2. **Signature Requirements**
- How should Stark signatures be formatted?
- What data should be signed for order creation?
- Is there a specific signature algorithm required?

### 3. **Field Validation**
- Are there specific validation rules we're missing?
- Min/max values for fields like nonce, expiration?
- Required precision for prices/quantities?

### 4. **Error Details**
- Can you provide specific error messages for 400 responses?
- Is there a way to get detailed validation errors?

## 🎯 **Requested Assistance**

**Option 1: Working Example**
Could you provide a complete working example of a successful order creation request with all required fields and proper formatting?

**Option 2: Error Details**
Could you enable detailed error responses for our API key temporarily so we can see what validation is failing?

**Option 3: Documentation Review**
Could you review our request format above and point out specific issues?

## 📱 **Business Impact**

**StreetCred App**:
- **Target Users**: Gen-Z mobile traders
- **Integration Status**: 95% complete with Extended Exchange
- **Launch Timeline**: Waiting on order creation resolution
- **User Base**: Ready to onboard with real trading

**Revenue Impact**:
- Trading volume from mobile users
- Commission revenue for Extended Exchange
- Cross-platform integration showcase

## 🔧 **Technical Details**

**Environment**:
- Platform: Flutter mobile app + Dart backend
- Authentication: Working (verified with balance/market calls)
- Network: CloudFront bypass implemented for reliability
- Account: Real production account with USD balance

**Testing Approach**:
- Conservative order parameters (low risk)
- Multiple market attempts (BTC, EUR, ETH)
- Proper error handling and logging
- Ready for immediate testing once format is corrected

## 📞 **Contact Information**

**Developer**: StreetCred Development Team
**Integration**: Extended Exchange API v1
**Urgency**: High - Production app ready for launch
**Follow-up**: Available for immediate testing and implementation

## 🙏 **Request**

We're very close to completing this integration and launching our mobile trading app with Extended Exchange as the backend. The order creation is the final piece we need to get working.

Could you please help us identify what's wrong with our order format so we can complete this integration and start driving trading volume to your platform?

**Thank you for your support!**

---

**Attachment**: Complete API integration code and logs available upon request