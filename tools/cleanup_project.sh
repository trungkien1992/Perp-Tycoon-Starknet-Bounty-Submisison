#!/bin/bash
# StreetCred Project Cleanup Script
# Cleans build artifacts, temporary files, and organizes the codebase

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

print_status "🧹 Starting StreetCred project cleanup..."

# Clean Flutter build artifacts
print_status "Cleaning Flutter build artifacts..."
flutter clean > /dev/null 2>&1 || true
rm -rf build/
rm -rf .dart_tool/
rm -rf .flutter-plugins
rm -rf .flutter-plugins-dependencies
print_success "Flutter artifacts cleaned"

# Clean Cairo build artifacts
print_status "Cleaning Cairo build artifacts..."
find contracts/ -name "target" -type d -exec rm -rf {} + 2>/dev/null || true
find contracts/ -name "Scarb.lock" -delete 2>/dev/null || true
print_success "Cairo artifacts cleaned"

# Clean Python cache files
print_status "Cleaning Python cache files..."
find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
find . -name "*.pyc" -delete 2>/dev/null || true
find . -name "*.pyo" -delete 2>/dev/null || true
find . -name "*.pyd" -delete 2>/dev/null || true
find . -name ".pytest_cache" -type d -exec rm -rf {} + 2>/dev/null || true
print_success "Python cache cleaned"

# Clean knowledge base temporary files
print_status "Cleaning knowledge base temporary files..."
if [ -d "knowledge_base/system/temp" ]; then
    rm -rf knowledge_base/system/temp/*
fi
if [ -d "knowledge_base/system/cache" ]; then
    rm -rf knowledge_base/system/cache/*
fi
print_success "Knowledge base temp files cleaned"

# Clean IDE and editor files
print_status "Cleaning IDE and editor files..."
find . -name ".vscode" -type d -exec rm -rf {} + 2>/dev/null || true
find . -name ".idea" -type d -exec rm -rf {} + 2>/dev/null || true
find . -name "*.swp" -delete 2>/dev/null || true
find . -name "*.swo" -delete 2>/dev/null || true
find . -name "*~" -delete 2>/dev/null || true
find . -name ".DS_Store" -delete 2>/dev/null || true
print_success "IDE files cleaned"

# Clean logs and temporary files
print_status "Cleaning logs and temporary files..."
find . -name "*.log" -not -path "./knowledge_base/system/logs/*" -delete 2>/dev/null || true
find . -name "*.tmp" -delete 2>/dev/null || true
find . -name "temp_*" -delete 2>/dev/null || true
print_success "Logs and temp files cleaned"

# Clean node modules if any exist
print_status "Cleaning Node.js artifacts..."
find . -name "node_modules" -type d -exec rm -rf {} + 2>/dev/null || true
find . -name "package-lock.json" -delete 2>/dev/null || true
print_success "Node.js artifacts cleaned"

# Clean Git artifacts
print_status "Cleaning Git artifacts..."
git gc --aggressive --prune=now > /dev/null 2>&1 || true
print_success "Git artifacts cleaned"

# Report cleanup results
echo ""
print_success "🎉 Project cleanup completed!"
echo ""
echo "📊 Cleanup Summary:"
echo "   ✅ Flutter build artifacts removed"
echo "   ✅ Cairo build artifacts removed" 
echo "   ✅ Python cache files removed"
echo "   ✅ Knowledge base temp files removed"
echo "   ✅ IDE and editor files removed"
echo "   ✅ Logs and temporary files removed"
echo "   ✅ Node.js artifacts removed"
echo "   ✅ Git artifacts optimized"
echo ""

# Show current project size
project_size=$(du -sh . 2>/dev/null | cut -f1)
print_status "Current project size: $project_size"

# Show disk space freed (approximate)
echo ""
print_success "✨ Project cleanup completed successfully!"
print_status "You can now run: flutter pub get && cd knowledge_base && ./manage_knowledge_base.sh start"