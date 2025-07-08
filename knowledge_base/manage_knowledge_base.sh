#!/bin/bash
# StreetCred Knowledge Base Management Script
# Complete RAG system for efficient context retrieval

set -e

KNOWLEDGE_BASE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKEND_DIR="$KNOWLEDGE_BASE_ROOT/backend"
SYSTEM_DIR="$KNOWLEDGE_BASE_ROOT/system"
DOCS_DIR="$KNOWLEDGE_BASE_ROOT/docs"
DATA_DIR="$KNOWLEDGE_BASE_ROOT/data"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to show usage
show_usage() {
    echo "StreetCred Knowledge Base Management"
    echo ""
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  start          Start the RAG backend server"
    echo "  stop           Stop the RAG backend server"
    echo "  restart        Restart the RAG backend server"
    echo "  status         Check RAG backend status"
    echo "  setup          Setup knowledge base environment"
    echo "  index          Index all documentation"
    echo "  search         Interactive search mode"
    echo "  health         Check system health"
    echo "  backup         Backup knowledge base"
    echo "  restore        Restore from backup"
    echo "  clean          Clean temporary files"
    echo "  help           Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 start                    # Start RAG server"
    echo "  $0 search 'AVNU paymaster' # Search for AVNU info"
    echo "  $0 health                  # Check system status"
}

# Function to check if backend is running
is_backend_running() {
    pgrep -f "python.*main.py" > /dev/null 2>&1
}

# Function to start the backend
start_backend() {
    print_status "Starting StreetCred Knowledge Base RAG backend..."
    
    if is_backend_running; then
        print_warning "Backend is already running"
        return 0
    fi
    
    cd "$BACKEND_DIR"
    
    # Check if virtual environment exists
    if [ ! -d "venv" ]; then
        print_status "Creating virtual environment..."
        python -m venv venv
    fi
    
    # Activate virtual environment
    source venv/bin/activate
    
    # Install/update requirements
    print_status "Installing dependencies..."
    pip install -r requirements.txt > /dev/null 2>&1
    
    # Start backend in background
    nohup python main.py > "$SYSTEM_DIR/logs/backend.log" 2>&1 &
    
    # Wait a moment and check if it started successfully
    sleep 2
    if is_backend_running; then
        print_success "RAG backend started successfully on http://localhost:8000"
        print_status "Logs: $SYSTEM_DIR/logs/backend.log"
    else
        print_error "Failed to start RAG backend. Check logs for details."
        return 1
    fi
}

# Function to stop the backend
stop_backend() {
    print_status "Stopping StreetCred Knowledge Base RAG backend..."
    
    if ! is_backend_running; then
        print_warning "Backend is not running"
        return 0
    fi
    
    pkill -f "python.*main.py"
    sleep 1
    
    if ! is_backend_running; then
        print_success "RAG backend stopped successfully"
    else
        print_error "Failed to stop RAG backend"
        return 1
    fi
}

# Function to check status
check_status() {
    print_status "Checking StreetCred Knowledge Base status..."
    
    echo ""
    echo "📁 Knowledge Base Structure:"
    echo "   Root: $KNOWLEDGE_BASE_ROOT"
    echo "   Backend: $BACKEND_DIR"
    echo "   System: $SYSTEM_DIR"
    echo "   Docs: $DOCS_DIR"
    echo "   Data: $DATA_DIR"
    echo ""
    
    if is_backend_running; then
        print_success "✅ RAG Backend: Running"
        echo "   URL: http://localhost:8000"
        echo "   Swagger: http://localhost:8000/docs"
    else
        print_warning "❌ RAG Backend: Not running"
    fi
    
    echo ""
    echo "📊 System Information:"
    echo "   ChromaDB: $([ -f "$SYSTEM_DIR/chroma_db/chroma.sqlite3" ] && echo "✅ Available" || echo "❌ Not found")"
    echo "   Virtual Env: $([ -d "$BACKEND_DIR/venv" ] && echo "✅ Available" || echo "❌ Not found")"
    echo "   Manual Docs: $(ls "$DOCS_DIR/manual_docs"/*.md 2>/dev/null | wc -l) files"
    echo "   Data Sources: $(ls -1 "$DATA_DIR" 2>/dev/null | wc -l) platforms"
    
    if [ -f "$SYSTEM_DIR/logs/backend.log" ]; then
        echo "   Last Log: $(tail -1 "$SYSTEM_DIR/logs/backend.log" 2>/dev/null | cut -c1-50)..."
    fi
}

# Function to setup the environment
setup_environment() {
    print_status "Setting up StreetCred Knowledge Base environment..."
    
    # Create necessary directories
    mkdir -p "$SYSTEM_DIR/logs"
    mkdir -p "$SYSTEM_DIR/cache"
    mkdir -p "$SYSTEM_DIR/temp"
    mkdir -p "$SYSTEM_DIR/backups"
    mkdir -p "$DOCS_DIR/auto_generated"
    
    cd "$BACKEND_DIR"
    
    # Create virtual environment if it doesn't exist
    if [ ! -d "venv" ]; then
        print_status "Creating Python virtual environment..."
        python -m venv venv
    fi
    
    # Activate and install dependencies
    source venv/bin/activate
    print_status "Installing Python dependencies..."
    pip install -r requirements.txt
    
    print_success "Environment setup complete!"
    print_status "You can now run: $0 start"
}

# Function to index all documentation
index_documentation() {
    print_status "Indexing all knowledge base documentation..."
    
    if ! is_backend_running; then
        print_error "Backend is not running. Start it first with: $0 start"
        return 1
    fi
    
    cd "$BACKEND_DIR"
    source venv/bin/activate
    
    print_status "Running enhanced indexer..."
    python sdk_enhanced_indexer.py
    
    print_success "Documentation indexing complete!"
}

# Function for interactive search
interactive_search() {
    local query="$1"
    
    if ! is_backend_running; then
        print_error "Backend is not running. Start it first with: $0 start"
        return 1
    fi
    
    if [ -z "$query" ]; then
        echo "Enter your search query:"
        read -r query
    fi
    
    print_status "Searching for: '$query'"
    
    # Use curl to query the backend
    curl -s -X POST "http://localhost:8000/search" \
         -H "Content-Type: application/json" \
         -d "{\"query\": \"$query\", \"max_results\": 5}" | \
         python -m json.tool
}

# Function to check system health
check_health() {
    print_status "Checking StreetCred Knowledge Base health..."
    
    if is_backend_running; then
        # Query health endpoint
        health_response=$(curl -s "http://localhost:8000/health" 2>/dev/null || echo "failed")
        
        if [ "$health_response" != "failed" ]; then
            echo "$health_response" | python -m json.tool
        else
            print_error "Failed to get health status from backend"
        fi
    else
        print_warning "Backend is not running - cannot check health"
    fi
}

# Function to backup knowledge base
backup_knowledge_base() {
    print_status "Creating knowledge base backup..."
    
    backup_name="knowledge_base_backup_$(date +%Y%m%d_%H%M%S)"
    backup_path="$SYSTEM_DIR/backups/$backup_name.tar.gz"
    
    cd "$KNOWLEDGE_BASE_ROOT"
    tar -czf "$backup_path" \
        --exclude="backend/venv" \
        --exclude="system/temp" \
        --exclude="system/cache" \
        docs/ system/chroma_db/ backend/*.py backend/*.json backend/*.txt
    
    print_success "Backup created: $backup_path"
}

# Function to clean temporary files
clean_temp_files() {
    print_status "Cleaning temporary files..."
    
    rm -rf "$SYSTEM_DIR/temp"/*
    rm -rf "$SYSTEM_DIR/cache"/*
    
    # Clean Python cache
    find "$BACKEND_DIR" -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
    find "$BACKEND_DIR" -name "*.pyc" -delete 2>/dev/null || true
    
    print_success "Temporary files cleaned"
}

# Main command handling
case "${1:-help}" in
    start)
        start_backend
        ;;
    stop)
        stop_backend
        ;;
    restart)
        stop_backend
        sleep 1
        start_backend
        ;;
    status)
        check_status
        ;;
    setup)
        setup_environment
        ;;
    index)
        index_documentation
        ;;
    search)
        interactive_search "$2"
        ;;
    health)
        check_health
        ;;
    backup)
        backup_knowledge_base
        ;;
    clean)
        clean_temp_files
        ;;
    help|--help|-h)
        show_usage
        ;;
    *)
        print_error "Unknown command: $1"
        echo ""
        show_usage
        exit 1
        ;;
esac