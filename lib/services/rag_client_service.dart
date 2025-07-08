import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

/// Client service for communicating with Python RAG backend
class RagClientService {
  static const String _defaultBaseUrl = 'http://localhost:8000';
  
  final String baseUrl;
  final http.Client _client;
  final Duration timeout;
  
  RagClientService({
    this.baseUrl = _defaultBaseUrl,
    http.Client? client,
    this.timeout = const Duration(seconds: 30),
  }) : _client = client ?? http.Client();
  
  /// Search the SDK knowledge base
  Future<RagSearchResult> search(
    String query, {
    int maxResults = 5,
    String? category,
    double minSimilarity = 0.6,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/search'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'query': query,
          'max_results': maxResults,
          'category': category,
          'min_similarity': minSimilarity,
        }),
      ).timeout(timeout);
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return RagSearchResult.fromJson(data);
      } else {
        throw RagException(
          'Search failed with status ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e) {
      if (e is RagException) rethrow;
      throw RagException('Search request failed: $e');
    }
  }
  
  /// Get knowledge base statistics
  Future<RagStats> getStats() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/stats'),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(timeout);
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return RagStats.fromJson(data);
      } else {
        throw RagException(
          'Stats request failed with status ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e) {
      if (e is RagException) rethrow;
      throw RagException('Stats request failed: $e');
    }
  }
  
  /// Get available categories
  Future<List<String>> getCategories() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/categories'),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(timeout);
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<String>.from(data['categories'] ?? []);
      } else {
        throw RagException(
          'Categories request failed with status ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e) {
      if (e is RagException) rethrow;
      throw RagException('Categories request failed: $e');
    }
  }
  
  /// Trigger documentation indexing
  Future<void> indexDocumentation({bool forceReindex = false}) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/index'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'force_reindex': forceReindex,
        }),
      ).timeout(const Duration(seconds: 10)); // Shorter timeout for trigger
      
      if (response.statusCode != 200) {
        throw RagException(
          'Index request failed with status ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e) {
      if (e is RagException) rethrow;
      throw RagException('Index request failed: $e');
    }
  }
  
  /// Check if RAG backend is available
  Future<bool> isAvailable() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/'),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 5));
      
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('RAG backend not available: $e');
      return false;
    }
  }
  
  /// Search with caching for better performance
  Future<RagSearchResult> searchWithCache(
    String query, {
    int maxResults = 5,
    String? category,
    double minSimilarity = 0.6,
    Duration? cacheExpiry,
  }) async {
    final cacheKey = _generateCacheKey(query, maxResults, category, minSimilarity);
    
    // Check cache first
    final cachedResult = await _getCachedResult(cacheKey);
    if (cachedResult != null) {
      return cachedResult;
    }
    
    // Perform search
    final result = await search(
      query,
      maxResults: maxResults,
      category: category,
      minSimilarity: minSimilarity,
    );
    
    // Cache result
    await _setCachedResult(cacheKey, result, cacheExpiry);
    
    return result;
  }
  
  String _generateCacheKey(String query, int maxResults, String? category, double minSimilarity) {
    return 'rag_search_${query.hashCode}_${maxResults}_${category?.hashCode ?? 0}_${minSimilarity.hashCode}';
  }
  
  Future<RagSearchResult?> _getCachedResult(String cacheKey) async {
    // TODO: Implement caching mechanism (SharedPreferences, Hive, etc.)
    return null;
  }
  
  Future<void> _setCachedResult(String cacheKey, RagSearchResult result, Duration? expiry) async {
    // TODO: Implement caching mechanism
  }
  
  void dispose() {
    _client.close();
  }
}

/// RAG search result model
class RagSearchResult {
  final List<RagDocument> results;
  final double queryTime;
  final int totalResults;
  
  RagSearchResult({
    required this.results,
    required this.queryTime,
    required this.totalResults,
  });
  
  factory RagSearchResult.fromJson(Map<String, dynamic> json) {
    return RagSearchResult(
      results: (json['results'] as List<dynamic>?)
          ?.map((item) => RagDocument.fromJson(item as Map<String, dynamic>))
          .toList() ?? [],
      queryTime: (json['query_time'] as num?)?.toDouble() ?? 0.0,
      totalResults: json['total_results'] as int? ?? 0,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'results': results.map((doc) => doc.toJson()).toList(),
      'query_time': queryTime,
      'total_results': totalResults,
    };
  }
}

/// RAG document model
class RagDocument {
  final String content;
  final String title;
  final String category;
  final String? subcategory;
  final double similarity;
  final String? sourceUrl;
  final Map<String, dynamic> metadata;
  
  RagDocument({
    required this.content,
    required this.title,
    required this.category,
    this.subcategory,
    required this.similarity,
    this.sourceUrl,
    required this.metadata,
  });
  
  factory RagDocument.fromJson(Map<String, dynamic> json) {
    return RagDocument(
      content: json['content'] as String? ?? '',
      title: json['title'] as String? ?? '',
      category: json['category'] as String? ?? '',
      subcategory: json['subcategory'] as String?,
      similarity: (json['similarity'] as num?)?.toDouble() ?? 0.0,
      sourceUrl: json['source_url'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'title': title,
      'category': category,
      'subcategory': subcategory,
      'similarity': similarity,
      'source_url': sourceUrl,
      'metadata': metadata,
    };
  }
  
  /// Get importance level based on metadata
  String get importanceLevel {
    return metadata['importance'] as String? ?? 'medium';
  }
  
  /// Get source type
  String get sourceType {
    return metadata['source'] as String? ?? 'unknown';
  }
  
  /// Get complexity level (for examples)
  String get complexityLevel {
    return metadata['complexity'] as String? ?? 'intermediate';
  }
  
  /// Check if this is a code example
  bool get isCodeExample {
    return category == 'examples' || 
           metadata['type'] == 'example' ||
           content.contains('```') ||
           content.contains('class ') ||
           content.contains('function ');
  }
  
  /// Check if this is API documentation
  bool get isApiDoc {
    return category == 'api' || 
           metadata['type'] == 'class' ||
           metadata['type'] == 'method';
  }
  
  /// Get formatted content for display
  String get formattedContent {
    if (content.length <= 300) return content;
    
    // Find a good breaking point
    final words = content.split(' ');
    final buffer = StringBuffer();
    var currentLength = 0;
    
    for (final word in words) {
      if (currentLength + word.length > 300) {
        buffer.write('...');
        break;
      }
      buffer.write('$word ');
      currentLength += word.length + 1;
    }
    
    return buffer.toString();
  }
}

/// RAG statistics model
class RagStats {
  final int totalDocuments;
  final Map<String, int> categories;
  final String lastUpdated;
  final String embeddingModel;
  
  RagStats({
    required this.totalDocuments,
    required this.categories,
    required this.lastUpdated,
    required this.embeddingModel,
  });
  
  factory RagStats.fromJson(Map<String, dynamic> json) {
    return RagStats(
      totalDocuments: json['total_documents'] as int? ?? 0,
      categories: Map<String, int>.from(json['categories'] as Map<String, dynamic>? ?? {}),
      lastUpdated: json['last_updated'] as String? ?? '',
      embeddingModel: json['embedding_model'] as String? ?? '',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'total_documents': totalDocuments,
      'categories': categories,
      'last_updated': lastUpdated,
      'embedding_model': embeddingModel,
    };
  }
}

/// RAG service exception
class RagException implements Exception {
  final String message;
  
  RagException(this.message);
  
  @override
  String toString() => 'RagException: $message';
}

/// RAG search filters
class RagSearchFilters {
  final String? category;
  final double minSimilarity;
  final int maxResults;
  final String? sourceType;
  final String? importanceLevel;
  final bool includeCodeExamples;
  final bool includeApiDocs;
  
  RagSearchFilters({
    this.category,
    this.minSimilarity = 0.6,
    this.maxResults = 5,
    this.sourceType,
    this.importanceLevel,
    this.includeCodeExamples = true,
    this.includeApiDocs = true,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'min_similarity': minSimilarity,
      'max_results': maxResults,
      'source_type': sourceType,
      'importance_level': importanceLevel,
      'include_code_examples': includeCodeExamples,
      'include_api_docs': includeApiDocs,
    };
  }
}

/// Utility functions for RAG search
class RagUtils {
  /// Extract key terms from a query
  static List<String> extractKeyTerms(String query) {
    final words = query.toLowerCase().split(RegExp(r'\s+'));
    final stopWords = {
      'the', 'a', 'an', 'and', 'or', 'but', 'in', 'on', 'at', 'to', 'for',
      'of', 'with', 'by', 'how', 'what', 'when', 'where', 'why', 'which',
      'can', 'should', 'would', 'could', 'is', 'are', 'was', 'were', 'be',
      'been', 'being', 'have', 'has', 'had', 'do', 'does', 'did', 'will',
      'would', 'could', 'should', 'may', 'might', 'must', 'shall'
    };
    
    return words.where((word) => 
      word.length > 2 && 
      !stopWords.contains(word) &&
      RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(word)
    ).toList();
  }
  
  /// Generate search suggestions based on query
  static List<String> generateSearchSuggestions(String query) {
    final keyTerms = extractKeyTerms(query);
    final suggestions = <String>[];
    
    // Add variations
    for (final term in keyTerms) {
      suggestions.add('$term example');
      suggestions.add('how to $term');
      suggestions.add('$term tutorial');
      suggestions.add('$term implementation');
    }
    
    // Add common SDK-related suggestions
    if (query.toLowerCase().contains('account')) {
      suggestions.addAll([
        'create account',
        'account management',
        'deploy account',
        'account balance',
      ]);
    }
    
    if (query.toLowerCase().contains('contract')) {
      suggestions.addAll([
        'contract deployment',
        'contract interaction',
        'call contract',
        'invoke contract',
      ]);
    }
    
    if (query.toLowerCase().contains('transaction')) {
      suggestions.addAll([
        'transaction status',
        'send transaction',
        'transaction fee',
        'transaction history',
      ]);
    }
    
    return suggestions.take(5).toList();
  }
  
  /// Format similarity score for display
  static String formatSimilarity(double similarity) {
    final percentage = (similarity * 100).toInt();
    return '$percentage%';
  }
  
  /// Get relevance badge based on similarity
  static String getRelevanceBadge(double similarity) {
    if (similarity >= 0.9) return 'Highly Relevant';
    if (similarity >= 0.8) return 'Very Relevant';
    if (similarity >= 0.7) return 'Relevant';
    if (similarity >= 0.6) return 'Somewhat Relevant';
    return 'Low Relevance';
  }
}