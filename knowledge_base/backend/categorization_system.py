#!/usr/bin/env python3
"""
Comprehensive Categorization System for Multi-Platform SDK RAG
Handles Extended Exchange, X10 Python SDK, Cairo Smart Contracts, and Starknet.dart
"""

from enum import Enum
from dataclasses import dataclass
from typing import List, Dict, Optional, Set
import re

class Platform(Enum):
    """Supported SDK platforms"""
    STARKNET_DART = "starknet_dart"
    EXTENDED_EXCHANGE = "extended_exchange"
    X10_PYTHON = "x10_python"
    CAIRO_CONTRACTS = "cairo_contracts"
    AVNU_GASLESS = "avnu_gasless"

class Category(Enum):
    """Main documentation categories"""
    # Core SDK Categories
    OVERVIEW = "overview"
    API_REFERENCE = "api_reference"
    GUIDES = "guides"
    EXAMPLES = "examples"
    
    # Trading-Specific Categories
    TRADING_API = "trading_api"
    AUTHENTICATION = "authentication"
    ORDERS = "orders"
    POSITIONS = "positions"
    WEBSOCKETS = "websockets"
    
    # Development Categories
    PYTHON_SDK = "python_sdk"
    CAIRO_DEVELOPMENT = "cairo_development"
    SMART_CONTRACTS = "smart_contracts"
    TESTING = "testing"
    DEPLOYMENT = "deployment"
    
    # Integration Categories
    MOBILE_INTEGRATION = "mobile_integration"
    SECURITY = "security"
    PERFORMANCE = "performance"
    TROUBLESHOOTING = "troubleshooting"
    
    # Gasless Transaction Categories
    GASLESS_TRANSACTIONS = "gasless_transactions"
    PAYMASTER = "paymaster"
    ACCOUNT_ABSTRACTION = "account_abstraction"

class DocType(Enum):
    """Document types for better classification"""
    REFERENCE = "reference"
    GUIDE = "guide"
    TUTORIAL = "tutorial"
    EXAMPLE = "example"
    API_DOC = "api_doc"
    CHANGELOG = "changelog"
    FAQ = "faq"
    SPECIFICATION = "specification"

class Importance(Enum):
    """Document importance levels"""
    CRITICAL = "critical"
    HIGH = "high"
    MEDIUM = "medium"
    LOW = "low"

class Complexity(Enum):
    """Document complexity levels"""
    BEGINNER = "beginner"
    INTERMEDIATE = "intermediate"
    ADVANCED = "advanced"
    EXPERT = "expert"

@dataclass
class CategoryMappingRule:
    """Rule for automatically categorizing documents"""
    keywords: List[str]
    category: Category
    subcategory: Optional[str] = None
    doc_type: Optional[DocType] = None
    importance: Optional[Importance] = None
    complexity: Optional[Complexity] = None
    platforms: Optional[List[Platform]] = None

class DocumentCategorizer:
    """Intelligent document categorization system"""
    
    def __init__(self):
        self.category_rules = self._build_category_rules()
        self.platform_keywords = self._build_platform_keywords()
        self.subcategory_mappings = self._build_subcategory_mappings()
    
    def categorize_document(self, 
                          title: str, 
                          content: str, 
                          source_url: Optional[str] = None) -> Dict[str, str]:
        """Automatically categorize a document based on content and context"""
        
        text_to_analyze = f"{title} {content}".lower()
        
        # Detect platform
        platform = self._detect_platform(text_to_analyze, source_url)
        
        # Detect main category
        category = self._detect_category(text_to_analyze, platform)
        
        # Detect subcategory
        subcategory = self._detect_subcategory(text_to_analyze, category, platform)
        
        # Detect document type
        doc_type = self._detect_doc_type(text_to_analyze, title)
        
        # Detect importance
        importance = self._detect_importance(text_to_analyze, title, platform)
        
        # Detect complexity
        complexity = self._detect_complexity(text_to_analyze, content)
        
        # Generate tags
        tags = self._generate_tags(text_to_analyze, platform, category)
        
        return {
            'platform': platform.value,
            'category': category.value,
            'subcategory': subcategory,
            'doc_type': doc_type.value,
            'importance': importance.value,
            'complexity': complexity.value,
            'tags': tags
        }
    
    def _detect_platform(self, text: str, source_url: Optional[str] = None) -> Platform:
        """Detect the platform based on content and source"""
        
        # Check source URL first
        if source_url:
            if 'extended.exchange' in source_url:
                return Platform.EXTENDED_EXCHANGE
            elif 'x10xchange' in source_url or 'python_sdk' in source_url:
                return Platform.X10_PYTHON
            elif 'cairo' in source_url or 'openzeppelin' in source_url:
                return Platform.CAIRO_CONTRACTS
            elif 'starknetdart' in source_url or 'focustree' in source_url:
                return Platform.STARKNET_DART
        
        # Check content keywords
        platform_scores = {}
        for platform, keywords in self.platform_keywords.items():
            score = sum(1 for keyword in keywords if keyword in text)
            platform_scores[platform] = score
        
        # Return platform with highest score
        if platform_scores:
            return max(platform_scores, key=platform_scores.get)
        
        return Platform.STARKNET_DART  # Default
    
    def _detect_category(self, text: str, platform: Platform) -> Category:
        """Detect main category based on content and platform"""
        
        # Platform-specific category mappings
        if platform == Platform.EXTENDED_EXCHANGE:
            if any(word in text for word in ['api', 'endpoint', 'request', 'response']):
                return Category.TRADING_API
            elif any(word in text for word in ['order', 'buy', 'sell', 'limit', 'market']):
                return Category.ORDERS
            elif any(word in text for word in ['position', 'leverage', 'margin']):
                return Category.POSITIONS
            elif any(word in text for word in ['websocket', 'stream', 'realtime']):
                return Category.WEBSOCKETS
            elif any(word in text for word in ['auth', 'key', 'signature']):
                return Category.AUTHENTICATION
        
        elif platform == Platform.X10_PYTHON:
            if any(word in text for word in ['python', 'sdk', 'client', 'library']):
                return Category.PYTHON_SDK
            elif any(word in text for word in ['example', 'tutorial', 'how to']):
                return Category.EXAMPLES
            elif any(word in text for word in ['test', 'testing', 'unittest']):
                return Category.TESTING
        
        elif platform == Platform.CAIRO_CONTRACTS:
            if any(word in text for word in ['cairo', 'contract', 'smart contract']):
                return Category.CAIRO_DEVELOPMENT
            elif any(word in text for word in ['openzeppelin', 'erc20', 'erc721']):
                return Category.SMART_CONTRACTS
            elif any(word in text for word in ['deploy', 'deployment', 'starkli']):
                return Category.DEPLOYMENT
            elif any(word in text for word in ['test', 'forge', 'scarb']):
                return Category.TESTING
        
        # General category detection
        for rule in self.category_rules:
            if rule.platforms and platform not in rule.platforms:
                continue
            
            if any(keyword in text for keyword in rule.keywords):
                return rule.category
        
        return Category.OVERVIEW  # Default
    
    def _detect_subcategory(self, text: str, category: Category, platform: Platform) -> str:
        """Detect subcategory based on category and content"""
        
        if category not in self.subcategory_mappings:
            return "general"
        
        subcategories = self.subcategory_mappings[category]
        
        # Score each subcategory
        scores = {}
        for subcategory, keywords in subcategories.items():
            score = sum(1 for keyword in keywords if keyword in text)
            if score > 0:
                scores[subcategory] = score
        
        if scores:
            return max(scores, key=scores.get)
        
        return "general"
    
    def _detect_doc_type(self, text: str, title: str) -> DocType:
        """Detect document type based on content patterns"""
        
        title_lower = title.lower()
        
        # Check title patterns
        if any(word in title_lower for word in ['api', 'reference', 'documentation']):
            return DocType.API_DOC
        elif any(word in title_lower for word in ['guide', 'how to', 'tutorial']):
            return DocType.GUIDE
        elif any(word in title_lower for word in ['example', 'sample', 'demo']):
            return DocType.EXAMPLE
        elif 'overview' in title_lower:
            return DocType.REFERENCE
        
        # Check content patterns
        if re.search(r'```\w+', text):  # Code blocks
            if 'example' in text:
                return DocType.EXAMPLE
            else:
                return DocType.REFERENCE
        elif any(word in text for word in ['step 1', 'first,', 'next,', 'finally']):
            return DocType.TUTORIAL
        elif any(word in text for word in ['function', 'method', 'class', 'parameter']):
            return DocType.API_DOC
        
        return DocType.GUIDE  # Default
    
    def _detect_importance(self, text: str, title: str, platform: Platform) -> Importance:
        """Detect document importance"""
        
        # Critical indicators
        critical_words = ['security', 'authentication', 'api key', 'private key', 'critical', 'important']
        if any(word in text for word in critical_words):
            return Importance.CRITICAL
        
        # High importance indicators
        high_words = ['getting started', 'overview', 'installation', 'setup', 'core', 'main']
        if any(word in text for word in high_words):
            return Importance.HIGH
        
        # Check if it's a core API reference
        if 'api' in title.lower() and any(word in text for word in ['endpoint', 'method', 'function']):
            return Importance.HIGH
        
        # Examples and tutorials are medium importance
        if any(word in text for word in ['example', 'tutorial', 'sample']):
            return Importance.MEDIUM
        
        return Importance.MEDIUM  # Default
    
    def _detect_complexity(self, text: str, content: str) -> Complexity:
        """Detect document complexity level"""
        
        # Count technical indicators
        technical_score = 0
        
        # Advanced technical terms
        advanced_terms = [
            'zero-knowledge', 'zk-proof', 'stark', 'signature', 'cryptography',
            'advanced', 'optimization', 'performance', 'security', 'architecture',
            'integration', 'deployment', 'production', 'enterprise'
        ]
        technical_score += sum(1 for term in advanced_terms if term in text)
        
        # Beginner indicators
        beginner_terms = [
            'getting started', 'introduction', 'basics', 'simple', 'easy',
            'first time', 'beginner', 'start', 'basic'
        ]
        beginner_score = sum(1 for term in beginner_terms if term in text)
        
        # Code complexity indicators
        code_blocks = len(re.findall(r'```', content))
        if code_blocks > 5:
            technical_score += 2
        elif code_blocks > 2:
            technical_score += 1
        
        # Determine complexity
        if beginner_score >= 2:
            return Complexity.BEGINNER
        elif technical_score >= 4:
            return Complexity.EXPERT
        elif technical_score >= 2:
            return Complexity.ADVANCED
        else:
            return Complexity.INTERMEDIATE
    
    def _generate_tags(self, text: str, platform: Platform, category: Category) -> List[str]:
        """Generate relevant tags for the document"""
        
        tags = set()
        
        # Add platform tag
        tags.add(platform.value)
        
        # Add category tag
        tags.add(category.value)
        
        # Technology-specific tags
        tech_tags = {
            'starknet': ['starknet', 'cairo', 'layer2'],
            'trading': ['trading', 'orders', 'positions', 'market'],
            'python': ['python', 'sdk', 'client', 'library'],
            'api': ['api', 'rest', 'http', 'endpoint'],
            'websocket': ['websocket', 'realtime', 'streaming'],
            'authentication': ['auth', 'security', 'keys'],
            'smart contract': ['contract', 'blockchain', 'ethereum'],
            'testing': ['test', 'unittest', 'qa'],
            'deployment': ['deploy', 'production', 'devops']
        }
        
        for tag_group, keywords in tech_tags.items():
            if any(keyword in text for keyword in keywords):
                tags.add(tag_group.replace(' ', '_'))
        
        # Common feature tags
        feature_tags = [
            'erc20', 'erc721', 'nft', 'token', 'wallet', 'balance',
            'leverage', 'margin', 'futures', 'perpetual', 'orderbook',
            'signature', 'encryption', 'hash', 'address'
        ]
        
        for tag in feature_tags:
            if tag in text:
                tags.add(tag)
        
        return list(tags)[:10]  # Limit to 10 tags
    
    def _build_category_rules(self) -> List[CategoryMappingRule]:
        """Build category mapping rules"""
        
        return [
            # Trading API rules
            CategoryMappingRule(
                keywords=['api', 'endpoint', 'rest', 'http', 'request', 'response'],
                category=Category.TRADING_API,
                importance=Importance.HIGH
            ),
            CategoryMappingRule(
                keywords=['order', 'buy', 'sell', 'limit', 'market', 'cancel'],
                category=Category.ORDERS,
                importance=Importance.CRITICAL
            ),
            CategoryMappingRule(
                keywords=['position', 'leverage', 'margin', 'pnl', 'unrealized'],
                category=Category.POSITIONS,
                importance=Importance.HIGH
            ),
            CategoryMappingRule(
                keywords=['websocket', 'stream', 'realtime', 'subscription'],
                category=Category.WEBSOCKETS,
                importance=Importance.HIGH
            ),
            CategoryMappingRule(
                keywords=['auth', 'authentication', 'api key', 'signature', 'security'],
                category=Category.AUTHENTICATION,
                importance=Importance.CRITICAL
            ),
            
            # Development rules
            CategoryMappingRule(
                keywords=['python', 'sdk', 'client', 'library', 'import'],
                category=Category.PYTHON_SDK,
                importance=Importance.HIGH
            ),
            CategoryMappingRule(
                keywords=['cairo', 'smart contract', 'starknet contract'],
                category=Category.CAIRO_DEVELOPMENT,
                importance=Importance.HIGH
            ),
            CategoryMappingRule(
                keywords=['test', 'testing', 'unittest', 'forge', 'scarb test'],
                category=Category.TESTING,
                importance=Importance.MEDIUM
            ),
            CategoryMappingRule(
                keywords=['deploy', 'deployment', 'starkli', 'production'],
                category=Category.DEPLOYMENT,
                importance=Importance.HIGH
            ),
            
            # General rules
            CategoryMappingRule(
                keywords=['example', 'sample', 'demo', 'tutorial'],
                category=Category.EXAMPLES,
                importance=Importance.MEDIUM
            ),
            CategoryMappingRule(
                keywords=['guide', 'how to', 'getting started', 'setup'],
                category=Category.GUIDES,
                importance=Importance.HIGH
            ),
            CategoryMappingRule(
                keywords=['overview', 'introduction', 'about', 'what is'],
                category=Category.OVERVIEW,
                importance=Importance.HIGH
            )
        ]
    
    def _build_platform_keywords(self) -> Dict[Platform, List[str]]:
        """Build platform-specific keywords"""
        
        return {
            Platform.STARKNET_DART: [
                'starknet.dart', 'flutter', 'dart', 'mobile', 'ios', 'android',
                'starknetdart.dev', 'focustree'
            ],
            Platform.EXTENDED_EXCHANGE: [
                'extended exchange', 'extended.exchange', 'layer 2', 'starkex',
                'perpetual', 'futures', 'clob', 'order book'
            ],
            Platform.X10_PYTHON: [
                'x10', 'python sdk', 'x10xchange', 'python client',
                'x10-python-trading', 'perpetual trading client'
            ],
            Platform.CAIRO_CONTRACTS: [
                'cairo', 'smart contract', 'openzeppelin', 'erc20', 'erc721',
                'scarb', 'starknet foundry', 'cairo-lang'
            ]
        }
    
    def _build_subcategory_mappings(self) -> Dict[Category, Dict[str, List[str]]]:
        """Build subcategory mappings for each main category"""
        
        return {
            Category.TRADING_API: {
                'endpoints': ['endpoint', 'route', 'url', 'path'],
                'authentication': ['auth', 'key', 'signature', 'token'],
                'orders': ['order', 'buy', 'sell', 'cancel'],
                'positions': ['position', 'leverage', 'margin'],
                'market_data': ['market', 'price', 'ticker', 'data'],
                'websocket': ['websocket', 'stream', 'realtime'],
                'error_handling': ['error', 'exception', 'status code']
            },
            
            Category.PYTHON_SDK: {
                'installation': ['install', 'pip', 'setup', 'requirements'],
                'authentication': ['auth', 'onboard', 'api key', 'account'],
                'trading_client': ['client', 'trading', 'perpetual'],
                'orders': ['place order', 'cancel order', 'order management'],
                'positions': ['get positions', 'leverage', 'margin'],
                'examples': ['example', 'sample', 'demo'],
                'error_handling': ['exception', 'error', 'try catch']
            },
            
            Category.CAIRO_DEVELOPMENT: {
                'basics': ['introduction', 'getting started', 'basics'],
                'syntax': ['syntax', 'language', 'grammar'],
                'contracts': ['contract', 'smart contract', 'starknet'],
                'storage': ['storage', 'state', 'mapping'],
                'functions': ['function', 'method', 'external', 'view'],
                'events': ['event', 'emit', 'log'],
                'testing': ['test', 'forge', 'scarb'],
                'deployment': ['deploy', 'starkli', 'declare']
            },
            
            Category.SMART_CONTRACTS: {
                'erc20': ['erc20', 'token', 'fungible'],
                'erc721': ['erc721', 'nft', 'non-fungible'],
                'erc1155': ['erc1155', 'multi-token'],
                'access_control': ['ownable', 'access control', 'role'],
                'security': ['security', 'reentrancy', 'pausable'],
                'upgradeable': ['upgradeable', 'proxy', 'upgrade'],
                'libraries': ['openzeppelin', 'library', 'component']
            },
            
            Category.EXAMPLES: {
                'basic': ['basic', 'simple', 'hello world'],
                'intermediate': ['intermediate', 'moderate'],
                'advanced': ['advanced', 'complex', 'sophisticated'],
                'nft': ['nft', 'erc721', 'marketplace'],
                'defi': ['defi', 'dex', 'swap', 'liquidity'],
                'wallet': ['wallet', 'account', 'keystore'],
                'trading': ['trading', 'order', 'position']
            }
        }

# Export the categorizer instance
categorizer = DocumentCategorizer()

def categorize_document(title: str, content: str, source_url: Optional[str] = None) -> Dict[str, str]:
    """Convenience function for document categorization"""
    return categorizer.categorize_document(title, content, source_url)

def get_all_categories() -> List[str]:
    """Get all available categories"""
    return [cat.value for cat in Category]

def get_all_platforms() -> List[str]:
    """Get all available platforms"""
    return [platform.value for platform in Platform]

def get_subcategories_for_category(category: str) -> List[str]:
    """Get all subcategories for a given category"""
    try:
        cat_enum = Category(category)
        if cat_enum in categorizer.subcategory_mappings:
            return list(categorizer.subcategory_mappings[cat_enum].keys())
    except ValueError:
        pass
    return ["general"]