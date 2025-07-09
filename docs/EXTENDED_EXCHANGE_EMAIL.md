# Email to Extended Exchange Support Team

**To**: support@extended.exchange (or api-support@extended.exchange)  
**Subject**: StreetCred Mobile App Integration - Order Creation 400 Error - Need API Format Help

---

**Dear Extended Exchange API Team,**

I'm developing **StreetCred**, a gamified mobile trading app for Gen-Z users, and I'm integrating with Extended Exchange as our primary trading backend. Our integration is 95% complete and working perfectly, but I'm stuck on the final step: order creation.

## 🚀 **Integration Status**

**What's Working Perfectly**:
- ✅ Authentication with API key f1894fcb909e3619449c01a1f16ddde3
- ✅ Account balance detection (9.959254 USD showing correctly)
- ✅ Market data fetching (all 63 markets accessible)
- ✅ Real-time market stats and order books

**What's Not Working**:
- ❌ Order creation (POST /api/v1/user/order returns 400 with empty body)

## 🔍 **The Problem**

Every order creation attempt returns **HTTP 400 with an empty response body**, making it impossible to debug what's wrong with my request format.

**Current Request**:
```json
POST /api/v1/user/order
Content-Type: application/json
X-Api-Key: f1894fcb909e3619449c01a1f16ddde3

{
  "id": "order_1751983535554",
  "market": "BTC-USD",
  "type": "limit", 
  "side": "buy",
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
    "collateralPosition": "1"
  },
  "selfTradeProtectionLevel": "ACCOUNT"
}
```

## ❓ **What I Need**

**Option 1**: A complete working example of a successful order creation request

**Option 2**: Detailed error messages (instead of empty 400 responses) so I can debug the issue

**Option 3**: Specific feedback on what's wrong with my current request format

## 📱 **Why This Matters**

StreetCred is ready to launch and will drive significant trading volume to Extended Exchange from mobile users. We just need this final piece working to complete the integration.

**Ready to Test**: I have a live account with USD balance and can test any corrections immediately.

## 🙏 **Request**

Could you please help me identify what's wrong with my order format? I'm very close to completing this integration and launching our mobile trading app with Extended Exchange.

**Thank you for your support!**

**Best regards,**  
StreetCred Development Team

**P.S.**: Happy to provide additional logs, code, or jump on a call to resolve this quickly.

---

**Account**: Vault 101420 | API Key: f1894fcb...9e3619449c01a1f16ddde3 | Balance: 9.96 USD