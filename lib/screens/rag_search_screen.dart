import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/rag_provider.dart';
import '../services/rag_client_service.dart';

/// Screen for searching the Starknet.dart SDK knowledge base
class RagSearchScreen extends ConsumerStatefulWidget {
  const RagSearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RagSearchScreen> createState() => _RagSearchScreenState();
}

class _RagSearchScreenState extends ConsumerState<RagSearchScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  
  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(ragSearchProvider);
    final filteredResults = ref.watch(filteredRagResultsProvider);
    final searchHistory = ref.watch(searchHistoryProvider);
    final ragHealth = ref.watch(ragHealthProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('SDK Knowledge Base'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettingsDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Health Status Banner
          ragHealth.when(
            data: (health) => health.isHealthy 
                ? const SizedBox.shrink()
                : Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    color: Colors.orange.shade100,
                    child: Row(
                      children: [
                        Icon(Icons.warning, color: Colors.orange.shade700),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            health.status,
                            style: TextStyle(color: Colors.orange.shade700),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _showHealthDialog(context, health),
                          child: const Text('Details'),
                        ),
                      ],
                    ),
                  ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          
          // Search Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search SDK Documentation',
                    hintText: 'e.g., "how to create account", "contract deployment"',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: searchState.isLoading 
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              ref.read(ragSearchProvider.notifier).clearSearch();
                            },
                          ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onSubmitted: (query) => _performSearch(query),
                ),
                
                const SizedBox(height: 12),
                
                // Search Actions
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: searchState.isLoading 
                          ? null 
                          : () => _performSearch(_searchController.text),
                      icon: const Icon(Icons.search),
                      label: const Text('Search'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () => _showFiltersDialog(context),
                      icon: const Icon(Icons.tune),
                      label: const Text('Filters'),
                    ),
                    const Spacer(),
                    if (searchHistory.isNotEmpty)
                      TextButton.icon(
                        onPressed: () => _showHistoryDialog(context),
                        icon: const Icon(Icons.history),
                        label: const Text('History'),
                      ),
                  ],
                ),
                
                // Error Display
                if (searchState.error != null)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error, color: Colors.red.shade700),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            searchState.error!,
                            style: TextStyle(color: Colors.red.shade700),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          
          // Results Section
          Expanded(
            child: _buildResultsSection(searchState, filteredResults),
          ),
        ],
      ),
    );
  }
  
  Widget _buildResultsSection(RagSearchState searchState, List<RagDocument> results) {
    if (searchState.query.isEmpty) {
      return _buildWelcomeSection();
    }
    
    if (searchState.isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Searching SDK documentation...'),
          ],
        ),
      );
    }
    
    if (results.isEmpty) {
      return _buildNoResultsSection();
    }
    
    return _buildResultsList(results);
  }
  
  Widget _buildWelcomeSection() {
    final popularSearches = ref.watch(popularSearchesProvider);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome to the Starknet.dart SDK Knowledge Base',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Search through comprehensive documentation, examples, and guides for the Starknet.dart SDK.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          
          const Text(
            'Popular Searches',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: popularSearches.map((search) {
              return ActionChip(
                label: Text(search),
                onPressed: () {
                  _searchController.text = search;
                  _performSearch(search);
                },
              );
            }).toList(),
          ),
          
          const SizedBox(height: 24),
          
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Search Tips',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  const Text('• Use specific terms like "account creation" or "contract deployment"'),
                  const Text('• Try question formats like "How to send transactions?"'),
                  const Text('• Use filters to narrow down results by category'),
                  const Text('• Check search history for previous queries'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNoResultsSection() {
    final suggestions = ref.watch(ragSearchSuggestionsProvider);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Icon(Icons.search_off, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No results found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try adjusting your search query or filters',
            style: TextStyle(color: Colors.grey),
          ),
          
          if (suggestions.isNotEmpty) ...[
            const SizedBox(height: 24),
            const Text(
              'Suggestions:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: suggestions.map((suggestion) {
                return ActionChip(
                  label: Text(suggestion),
                  onPressed: () {
                    _searchController.text = suggestion;
                    _performSearch(suggestion);
                  },
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
  
  Widget _buildResultsList(List<RagDocument> results) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final doc = results[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ExpansionTile(
            title: Text(
              doc.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    Chip(
                      label: Text(doc.category),
                      backgroundColor: _getCategoryColor(doc.category),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      RagUtils.formatSimilarity(doc.similarity),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  doc.formattedContent,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(doc.content),
                    const SizedBox(height: 16),
                    
                    // Metadata
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (doc.subcategory != null)
                          Chip(
                            label: Text(doc.subcategory!),
                            backgroundColor: Colors.grey.shade200,
                          ),
                        Chip(
                          label: Text(doc.sourceType),
                          backgroundColor: Colors.blue.shade100,
                        ),
                        Chip(
                          label: Text(doc.importanceLevel),
                          backgroundColor: _getImportanceColor(doc.importanceLevel),
                        ),
                      ],
                    ),
                    
                    // Actions
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        if (doc.sourceUrl != null)
                          TextButton.icon(
                            onPressed: () => _openUrl(doc.sourceUrl!),
                            icon: const Icon(Icons.open_in_new),
                            label: const Text('View Source'),
                          ),
                        TextButton.icon(
                          onPressed: () => _copyToClipboard(doc.content),
                          icon: const Icon(Icons.copy),
                          label: const Text('Copy'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  void _performSearch(String query) {
    ref.read(ragSearchProvider.notifier).search(query);
  }
  
  void _showFiltersDialog(BuildContext context) {
    // TODO: Implement filters dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Filters'),
        content: const Text('Filter options coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  void _showHistoryDialog(BuildContext context) {
    final history = ref.read(searchHistoryProvider);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search History'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: history.length,
            itemBuilder: (context, index) {
              final query = history[index];
              return ListTile(
                title: Text(query),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    ref.read(searchHistoryProvider.notifier).removeSearch(query);
                  },
                ),
                onTap: () {
                  Navigator.pop(context);
                  _searchController.text = query;
                  _performSearch(query);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(searchHistoryProvider.notifier).clearHistory();
              Navigator.pop(context);
            },
            child: const Text('Clear All'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  void _showSettingsDialog(BuildContext context) {
    // TODO: Implement settings dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('RAG Settings'),
        content: const Text('Settings coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  void _showHealthDialog(BuildContext context, RagSystemHealth health) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('System Health'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: ${health.status}'),
            if (health.totalDocuments != null)
              Text('Documents: ${health.totalDocuments}'),
            if (health.lastUpdated != null)
              Text('Last Updated: ${health.lastUpdated}'),
            if (health.issues.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text('Issues:', style: TextStyle(fontWeight: FontWeight.bold)),
              ...health.issues.map((issue) => Text('• $issue')),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'api':
        return Colors.blue.shade100;
      case 'examples':
        return Colors.green.shade100;
      case 'overview':
        return Colors.purple.shade100;
      case 'documentation':
        return Colors.orange.shade100;
      case 'packages':
        return Colors.teal.shade100;
      default:
        return Colors.grey.shade100;
    }
  }
  
  Color _getImportanceColor(String importance) {
    switch (importance.toLowerCase()) {
      case 'critical':
        return Colors.red.shade100;
      case 'high':
        return Colors.orange.shade100;
      case 'medium':
        return Colors.yellow.shade100;
      case 'low':
        return Colors.green.shade100;
      default:
        return Colors.grey.shade100;
    }
  }
  
  void _openUrl(String url) {
    // TODO: Implement URL opening
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Open URL: $url')),
    );
  }
  
  void _copyToClipboard(String text) {
    // TODO: Implement clipboard copy
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }
}