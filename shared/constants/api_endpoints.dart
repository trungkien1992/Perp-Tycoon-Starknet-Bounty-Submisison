/// API endpoint constants shared across services
class ApiEndpoints {
  // Base URLs
  static const String extendedExchangeBase = 'https://api.extended.exchange/api/v1';
  static const String extendedExchangeWs = 'wss://api.extended.exchange/stream.extended.exchange/v1';
  static const String ragBackendBase = 'http://localhost:8000';
  static const String tradingServiceBase = 'http://localhost:8001';
  static const String signatureServiceBase = 'http://localhost:8002';
  
  // Extended Exchange endpoints
  static const String marketData = '/market/data';
  static const String orderbook = '/orderbook';
  static const String trades = '/trades';
  static const String orders = '/orders';
  static const String orderHistory = '/orders/history';
  static const String accountBalance = '/account/balance';
  static const String accountInfo = '/account/info';
  static const String positions = '/positions';
  static const String funding = '/funding';
  static const String feeInfo = '/fee/info';
  static const String systemStatus = '/system/status';
  
  // Trading service endpoints
  static const String placeOrder = '/place-order';
  static const String cancelOrder = '/cancel-order';
  static const String getOrderStatus = '/order-status';
  static const String getBalance = '/balance';
  static const String getPositions = '/positions';
  static const String testConnection = '/test-connection';
  static const String signMessage = '/sign-message';
  
  // RAG backend endpoints
  static const String ragSearch = '/search';
  static const String ragIndex = '/index';
  static const String ragCategories = '/categories';
  static const String ragDocuments = '/documents';
  static const String ragHealth = '/health';
  static const String ragOptimize = '/optimize';
  static const String ragStats = '/stats';
  
  // Signature service endpoints
  static const String generateSignature = '/generate-signature';
  static const String verifySignature = '/verify-signature';
  static const String healthCheck = '/health';
  
  // Blockchain endpoints
  static const String blockchainDeploy = '/blockchain/deploy';
  static const String blockchainCall = '/blockchain/call';
  static const String blockchainTransaction = '/blockchain/transaction';
  static const String blockchainBalance = '/blockchain/balance';
  static const String blockchainStatus = '/blockchain/status';
  
  // WebSocket endpoints
  static const String wsMarketData = '/market-data';
  static const String wsOrderUpdates = '/order-updates';
  static const String wsPositionUpdates = '/position-updates';
  static const String wsAccountUpdates = '/account-updates';
  
  // API versioning
  static const String v1 = '/v1';
  static const String v2 = '/v2';
  
  // Query parameters
  static const String symbolParam = 'symbol';
  static const String limitParam = 'limit';
  static const String offsetParam = 'offset';
  static const String startTimeParam = 'start_time';
  static const String endTimeParam = 'end_time';
  static const String orderIdParam = 'order_id';
  static const String statusParam = 'status';
  static const String sideParam = 'side';
  static const String typeParam = 'type';
  
  // Headers
  static const String apiKeyHeader = 'X-API-Key';
  static const String contentTypeHeader = 'Content-Type';
  static const String authorizationHeader = 'Authorization';
  static const String userAgentHeader = 'User-Agent';
  static const String signatureHeader = 'X-Signature';
  static const String timestampHeader = 'X-Timestamp';
  static const String nonceHeader = 'X-Nonce';
  
  // Content types
  static const String jsonContentType = 'application/json';
  static const String formContentType = 'application/x-www-form-urlencoded';
  
  // Default values
  static const int defaultLimit = 100;
  static const int defaultTimeout = 30000; // milliseconds
  static const int maxRetries = 3;
  
  // Trading symbols
  static const String ethUsdSymbol = 'ETH-USD';
  static const String btcUsdSymbol = 'BTC-USD';
  static const String ethBtcSymbol = 'ETH-BTC';
  
  // Order types
  static const String marketOrder = 'market';
  static const String limitOrder = 'limit';
  static const String stopOrder = 'stop';
  static const String stopLimitOrder = 'stop_limit';
  
  // Order sides
  static const String buyOrder = 'buy';
  static const String sellOrder = 'sell';
  
  // Order statuses
  static const String pendingStatus = 'pending';
  static const String filledStatus = 'filled';
  static const String cancelledStatus = 'cancelled';
  static const String rejectedStatus = 'rejected';
  static const String partiallyFilledStatus = 'partially_filled';
  
  // Time in force
  static const String goodTillCancelled = 'GTC';
  static const String immediateOrCancel = 'IOC';
  static const String fillOrKill = 'FOK';
  
  // Asset symbols
  static const String eth = 'ETH';
  static const String usdc = 'USDC';
  static const String btc = 'BTC';
  static const String usdt = 'USDT';
  
  // Blockchain networks
  static const String mainnet = 'mainnet';
  static const String testnet = 'testnet';
  static const String sepolia = 'sepolia';
  static const String starknetMainnet = 'starknet-mainnet';
  static const String starknetTestnet = 'starknet-testnet';
  
  // Build full URL
  static String buildUrl(String baseUrl, String endpoint, {Map<String, String>? params}) {
    final url = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
    final cleanEndpoint = endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;
    
    var fullUrl = '$url$cleanEndpoint';
    
    if (params != null && params.isNotEmpty) {
      final queryString = params.entries
          .map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value)}')
          .join('&');
      fullUrl += '?$queryString';
    }
    
    return fullUrl;
  }
  
  // Build WebSocket URL
  static String buildWsUrl(String baseUrl, String endpoint, {Map<String, String>? params}) {
    final url = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
    final cleanEndpoint = endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;
    
    var fullUrl = '$url$cleanEndpoint';
    
    if (params != null && params.isNotEmpty) {
      final queryString = params.entries
          .map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value)}')
          .join('&');
      fullUrl += '?$queryString';
    }
    
    return fullUrl;
  }
  
  // Validate endpoint
  static bool isValidEndpoint(String endpoint) {
    return endpoint.isNotEmpty && endpoint.startsWith('/');
  }
  
  // Get endpoint category
  static String getEndpointCategory(String endpoint) {
    if (endpoint.startsWith('/market') || endpoint.startsWith('/orderbook') || endpoint.startsWith('/trades')) {
      return 'market_data';
    } else if (endpoint.startsWith('/orders') || endpoint.startsWith('/positions')) {
      return 'trading';
    } else if (endpoint.startsWith('/account') || endpoint.startsWith('/balance')) {
      return 'account';
    } else if (endpoint.startsWith('/blockchain')) {
      return 'blockchain';
    } else if (endpoint.startsWith('/search') || endpoint.startsWith('/index')) {
      return 'rag';
    } else if (endpoint.startsWith('/sign') || endpoint.startsWith('/verify')) {
      return 'signature';
    } else {
      return 'unknown';
    }
  }
}