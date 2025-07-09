const express = require('express');
const cors = require('cors');
const starkwareCrypto = require('@starkware-industries/starkware-crypto-utils');

const app = express();
const PORT = process.env.PORT || 3001;

// Middleware
app.use(cors());
app.use(express.json());

// Logging middleware
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`);
  next();
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ 
    status: 'OK', 
    service: 'StreetCred StarkEx Signature Service',
    timestamp: new Date().toISOString()
  });
});

// Sign Extended Exchange order
app.post('/sign-order', async (req, res) => {
  console.log('🔐 Received order signing request');
  
  try {
    const {
      privateKey,
      market,
      side,
      qty,
      price,
      nonce,
      expirationTimestamp,
      vaultId
    } = req.body;

    // Validate required fields
    if (!privateKey || !market || !side || !qty || !price || !nonce || !expirationTimestamp || !vaultId) {
      return res.status(400).json({
        error: 'Missing required fields',
        required: ['privateKey', 'market', 'side', 'qty', 'price', 'nonce', 'expirationTimestamp', 'vaultId']
      });
    }

    console.log(`📊 Order: ${side} ${qty} ${market} @ ${price}`);

    // Extended Exchange specific asset IDs (from API documentation)
    const assetIds = {
      'BTC-USD': { synthetic: '0x4254432d38000000000000000000000', collateral: '0x2893294412a4c8f915f75892b395ebbf6859ec246ec365c3b1f56f47c3a0a5d' },
      'ETH-USD': { synthetic: '0x4554482d38000000000000000000000', collateral: '0x2893294412a4c8f915f75892b395ebbf6859ec246ec365c3b1f56f47c3a0a5d' },
      'EUR-USD': { synthetic: '0x4555522d5553442d38000000000000', collateral: '0x2893294412a4c8f915f75892b395ebbf6859ec246ec365c3b1f56f47c3a0a5d' },
      // Add more as needed
    };

    const assets = assetIds[market] || assetIds['BTC-USD']; // Default to BTC-USD

    // Convert amounts to StarkEx format (with proper scaling)
    const amountSynthetic = Math.floor(parseFloat(qty) * Math.pow(10, 10)); // Scale for synthetic asset
    const amountCollateral = Math.floor(parseFloat(price) * parseFloat(qty) * Math.pow(10, 6)); // Scale for USD
    const maxFee = Math.floor(amountCollateral * 0.00025); // 0.025% fee

    let vaultIdSell, vaultIdBuy, amountSell, amountBuy, tokenSell, tokenBuy;

    if (side.toUpperCase() === 'BUY') {
      // Buying synthetic asset with collateral
      vaultIdSell = parseInt(vaultId);
      vaultIdBuy = parseInt(vaultId);
      amountSell = amountCollateral;
      amountBuy = amountSynthetic;
      tokenSell = assets.collateral;
      tokenBuy = assets.synthetic;
    } else {
      // Selling synthetic asset for collateral
      vaultIdSell = parseInt(vaultId);
      vaultIdBuy = parseInt(vaultId);
      amountSell = amountSynthetic;
      amountBuy = amountCollateral;
      tokenSell = assets.synthetic;
      tokenBuy = assets.collateral;
    }

    console.log(`🔢 Amounts: Sell ${amountSell}, Buy ${amountBuy}, Fee ${maxFee}`);

    // Generate limit order message hash with fee
    const msgHash = starkwareCrypto.getLimitOrderMsgHashWithFee(
      vaultIdSell,
      vaultIdBuy,
      amountSell,
      amountBuy,
      tokenSell,
      tokenBuy,
      assets.collateral, // Fee token (always USD)
      maxFee,
      parseInt(nonce),
      Math.floor(expirationTimestamp / 1000 / 3600) // Convert to hours
    );

    console.log(`🔐 Message hash generated: ${msgHash}`);

    // Create key pair from private key
    const cleanPrivateKey = privateKey.startsWith('0x') ? privateKey.slice(2) : privateKey;
    const keyPair = starkwareCrypto.ec.keyFromPrivate(cleanPrivateKey, 'hex');

    // Sign the message
    const signature = starkwareCrypto.sign(keyPair, msgHash);
    
    // Get public key
    const starkKey = starkwareCrypto.privateToStarkKey(cleanPrivateKey);

    console.log('✅ Signature generated successfully');

    res.json({
      success: true,
      signature: {
        r: '0x' + signature.r.toString('hex').padStart(64, '0'),
        s: '0x' + signature.s.toString('hex').padStart(64, '0')
      },
      starkKey: starkKey,
      msgHash: msgHash,
      orderDetails: {
        market,
        side,
        qty,
        price,
        vaultIdSell,
        vaultIdBuy,
        amountSell,
        amountBuy,
        maxFee
      }
    });

  } catch (error) {
    console.error('❌ Signature generation failed:', error);
    res.status(500).json({
      success: false,
      error: error.message,
      stack: process.env.NODE_ENV === 'development' ? error.stack : undefined
    });
  }
});

// Test signature endpoint
app.post('/test-signature', async (req, res) => {
  console.log('🧪 Received test signature request');
  
  try {
    const testPrivateKey = '0x040662bc94150487d65b99006436a6587717f564705b3f011f673efaf9b7814d';
    
    // Simple test signature
    const testMessage = 'test-message-' + Date.now();
    const keyPair = starkwareCrypto.ec.keyFromPrivate(testPrivateKey.slice(2), 'hex');
    const msgHash = starkwareCrypto.pedersen([testMessage]);
    const signature = starkwareCrypto.sign(keyPair, msgHash);
    
    res.json({
      success: true,
      test: true,
      signature: {
        r: '0x' + signature.r.toString('hex'),
        s: '0x' + signature.s.toString('hex')
      },
      starkKey: starkwareCrypto.privateToStarkKey(testPrivateKey.slice(2)),
      msgHash: msgHash
    });

  } catch (error) {
    console.error('❌ Test signature failed:', error);
    res.status(500).json({
      success: false,
      error: error.message
    });
  }
});

// Error handling middleware
app.use((error, req, res, next) => {
  console.error('💥 Unhandled error:', error);
  res.status(500).json({
    success: false,
    error: 'Internal server error',
    message: error.message
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    success: false,
    error: 'Endpoint not found'
  });
});

// Start server
app.listen(PORT, () => {
  console.log('🚀 StreetCred StarkEx Signature Service');
  console.log('======================================');
  console.log(`🌐 Server running on port ${PORT}`);
  console.log(`📊 Health check: http://localhost:${PORT}/health`);
  console.log(`🔐 Sign order: POST http://localhost:${PORT}/sign-order`);
  console.log(`🧪 Test signature: POST http://localhost:${PORT}/test-signature`);
  console.log('✅ Ready to sign Extended Exchange orders');
});