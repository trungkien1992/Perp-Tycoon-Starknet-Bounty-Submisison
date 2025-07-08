import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../services/rag_client_service.dart';

/// Provider for RAG client service
final ragClientProvider = Provider<RagClientService>((ref) {
  return RagClientService();
});

/// Provider for RAG availability status
final ragAvailabilityProvider = FutureProvider<bool>((ref) async {
  final ragClient = ref.watch(ragClientProvider);
  return await ragClient.isAvailable();
});

/// Provider for RAG statistics
final ragStatsProvider = FutureProvider<RagStats>((ref) async {
  final ragClient = ref.watch(ragClientProvider);
  return await ragClient.getStats();
});

/// Provider for available categories
final ragCategoriesProvider = FutureProvider<List<String>>((ref) async {
  final ragClient = ref.watch(ragClientProvider);
  return await ragClient.getCategories();
});

/// State for RAG search
class RagSearchState {
  final String query;
  final RagSearchResult? result;
  final bool isLoading;
  final String? error;
  final RagSearchFilters filters;
  
  RagSearchState({
    this.query = '',
    this.result,
    this.isLoading = false,
    this.error,
    this.filters = const RagSearchFilters(),
  });
  
  RagSearchState copyWith({
    String? query,
    RagSearchResult? result,
    bool? isLoading,
    String? error,
    RagSearchFilters? filters,
  }) {
    return RagSearchState(
      query: query ?? this.query,
      result: result ?? this.result,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      filters: filters ?? this.filters,
    );
  }
}

/// StateNotifier for RAG search functionality
class RagSearchNotifier extends StateNotifier<RagSearchState> {
  final RagClientService _ragClient;
  
  RagSearchNotifier(this._ragClient) : super(RagSearchState());
  
  /// Perform search with current filters
  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      state = state.copyWith(query: '', result: null, error: null);
      return;
    }
    
    state = state.copyWith(
      query: query,
      isLoading: true,
      error: null,
    );
    
    try {
      final result = await _ragClient.search(
        query,
        maxResults: state.filters.maxResults,
        category: state.filters.category,
        minSimilarity: state.filters.minSimilarity,
      );
      
      state = state.copyWith(
        result: result,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }
  
  /// Update search filters
  void updateFilters(RagSearchFilters filters) {
    state = state.copyWith(filters: filters);
    
    // Re-search if there's a current query
    if (state.query.isNotEmpty) {
      search(state.query);
    }
  }
  
  /// Clear search results
  void clearSearch() {
    state = RagSearchState(filters: state.filters);
  }
  
  /// Get search suggestions
  List<String> getSearchSuggestions() {
    if (state.query.isEmpty) {
      return [
        'How to create an account',
        'Contract deployment example',
        'Transaction signing',
        'Wallet integration',
        'NFT marketplace tutorial',
        'Provider configuration',
        'Error handling',
        'Security best practices',
      ];
    }
    
    return RagUtils.generateSearchSuggestions(state.query);
  }
}

/// Provider for RAG search state
final ragSearchProvider = StateNotifierProvider<RagSearchNotifier, RagSearchState>((ref) {
  final ragClient = ref.watch(ragClientProvider);
  return RagSearchNotifier(ragClient);
});

/// Provider for search suggestions
final ragSearchSuggestionsProvider = Provider<List<String>>((ref) {
  final searchNotifier = ref.watch(ragSearchProvider.notifier);
  return searchNotifier.getSearchSuggestions();
});

/// Provider for filtered search results
final filteredRagResultsProvider = Provider<List<RagDocument>>((ref) {
  final searchState = ref.watch(ragSearchProvider);
  final results = searchState.result?.results ?? [];
  
  return results.where((doc) {
    final filters = searchState.filters;
    
    // Filter by source type
    if (filters.sourceType != null && doc.sourceType != filters.sourceType) {
      return false;
    }
    
    // Filter by importance level
    if (filters.importanceLevel != null && doc.importanceLevel != filters.importanceLevel) {
      return false;
    }
    
    // Filter code examples
    if (!filters.includeCodeExamples && doc.isCodeExample) {
      return false;
    }
    
    // Filter API docs
    if (!filters.includeApiDocs && doc.isApiDoc) {
      return false;
    }
    
    return true;
  }).toList();
});

/// Provider for RAG indexing state
class RagIndexingState {
  final bool isIndexing;
  final String? error;
  final DateTime? lastIndexed;
  
  RagIndexingState({
    this.isIndexing = false,
    this.error,
    this.lastIndexed,
  });
  
  RagIndexingState copyWith({
    bool? isIndexing,
    String? error,
    DateTime? lastIndexed,
  }) {
    return RagIndexingState(
      isIndexing: isIndexing ?? this.isIndexing,
      error: error ?? this.error,
      lastIndexed: lastIndexed ?? this.lastIndexed,
    );
  }
}

/// StateNotifier for RAG indexing
class RagIndexingNotifier extends StateNotifier<RagIndexingState> {
  final RagClientService _ragClient;
  
  RagIndexingNotifier(this._ragClient) : super(RagIndexingState());
  
  /// Trigger documentation indexing
  Future<void> indexDocumentation({bool forceReindex = false}) async {
    state = state.copyWith(isIndexing: true, error: null);
    
    try {
      await _ragClient.indexDocumentation(forceReindex: forceReindex);
      
      state = state.copyWith(
        isIndexing: false,
        lastIndexed: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(
        isIndexing: false,
        error: e.toString(),
      );
    }
  }
}

/// Provider for RAG indexing state
final ragIndexingProvider = StateNotifierProvider<RagIndexingNotifier, RagIndexingState>((ref) {
  final ragClient = ref.watch(ragClientProvider);
  return RagIndexingNotifier(ragClient);
});

/// Provider for popular/recommended searches
final popularSearchesProvider = Provider<List<String>>((ref) {
  return [
    'How to create account',
    'Contract deployment',
    'Transaction signing',
    'Wallet integration',
    'NFT example',
    'Provider setup',
    'Error handling',
    'Security guide',
    'Mobile wallet',
    'Testnet setup',
  ];
});

/// Provider for search history (local storage)
class SearchHistoryNotifier extends StateNotifier<List<String>> {
  SearchHistoryNotifier() : super([]);
  
  /// Add search to history
  void addSearch(String query) {
    if (query.trim().isEmpty) return;
    
    final trimmedQuery = query.trim();
    
    // Remove if already exists
    state = state.where((q) => q != trimmedQuery).toList();
    
    // Add to beginning
    state = [trimmedQuery, ...state];
    
    // Keep only last 20 searches
    if (state.length > 20) {
      state = state.take(20).toList();
    }
  }
  
  /// Clear search history
  void clearHistory() {
    state = [];
  }
  
  /// Remove specific search from history
  void removeSearch(String query) {
    state = state.where((q) => q != query).toList();
  }
}

/// Provider for search history
final searchHistoryProvider = StateNotifierProvider<SearchHistoryNotifier, List<String>>((ref) {
  return SearchHistoryNotifier();
});

/// Provider for RAG system health
final ragHealthProvider = FutureProvider<RagSystemHealth>((ref) async {
  final ragClient = ref.watch(ragClientProvider);
  
  try {
    final isAvailable = await ragClient.isAvailable();
    if (!isAvailable) {
      return RagSystemHealth(
        isHealthy: false,
        status: 'Backend not available',
        issues: ['RAG backend server is not responding'],
      );
    }
    
    final stats = await ragClient.getStats();
    final issues = <String>[];
    
    if (stats.totalDocuments == 0) {
      issues.add('No documents indexed');
    }
    
    if (stats.categories.isEmpty) {
      issues.add('No categories available');
    }
    
    return RagSystemHealth(
      isHealthy: issues.isEmpty,
      status: issues.isEmpty ? 'All systems operational' : 'Issues detected',
      issues: issues,
      totalDocuments: stats.totalDocuments,
      lastUpdated: stats.lastUpdated,
    );
  } catch (e) {
    return RagSystemHealth(
      isHealthy: false,
      status: 'Health check failed',
      issues: ['Failed to check system health: $e'],
    );
  }
});

/// RAG system health model
class RagSystemHealth {
  final bool isHealthy;
  final String status;
  final List<String> issues;
  final int? totalDocuments;
  final String? lastUpdated;
  
  RagSystemHealth({
    required this.isHealthy,
    required this.status,
    required this.issues,
    this.totalDocuments,
    this.lastUpdated,
  });
}

/// Utility extensions for RAG providers
extension RagProviderExtensions on WidgetRef {
  /// Quick search method
  Future<void> searchRag(String query) async {
    read(ragSearchProvider.notifier).search(query);
    read(searchHistoryProvider.notifier).addSearch(query);
  }
  
  /// Check if RAG is available
  Future<bool> isRagAvailable() async {
    try {
      final availability = await read(ragAvailabilityProvider.future);
      return availability;
    } catch (e) {
      debugPrint('RAG availability check failed: $e');
      return false;
    }
  }
  
  /// Get quick stats
  Future<String> getRagQuickStats() async {
    try {
      final stats = await read(ragStatsProvider.future);
      return '${stats.totalDocuments} documents in ${stats.categories.length} categories';
    } catch (e) {
      return 'Stats unavailable';
    }
  }
}