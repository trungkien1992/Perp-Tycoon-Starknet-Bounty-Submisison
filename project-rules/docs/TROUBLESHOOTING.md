# Troubleshooting Guide - Known Issues & Solutions

## 🚨 Current Known Issues

### ✅ RESOLVED: LangChain Import Error
**Issue**: `ImportError: cannot import name 'GitHubLoader' from 'langchain.document_loaders'`
**Root Cause**: LangChain changed import structure in newer versions
**Solution**: Removed unused import from `main.py:26`
**Prevention**: Pin specific LangChain versions in requirements.txt
**Date Resolved**: 2025-01-08

### ✅ RESOLVED: Virtual Environment Issues
**Issue**: `ModuleNotFoundError` when running Python scripts
**Root Cause**: System Python restrictions prevent package installation
**Solution**: Always activate virtual environment: `source venv/bin/activate`
**Prevention**: Use startup script `start_rag.sh` which handles activation
**Date Resolved**: 2025-01-08

### ✅ RESOLVED: Package Version Conflicts
**Issue**: Torch and other packages had incompatible version requirements
**Root Cause**: Exact version pins caused conflicts
**Solution**: Updated requirements.txt to use flexible ranges (>=)
**Prevention**: Use version ranges instead of exact pins
**Date Resolved**: 2025-01-08

## 🔧 RAG Backend Issues

### Server Won't Start
**Symptoms**: FastAPI server fails to start or crashes immediately
**Common Causes**:
1. Port 8000 already in use
2. Virtual environment not activated
3. Missing dependencies
4. Database connection issues

**Diagnostic Steps**:
```bash
# Check port usage
lsof -i :8000

# Check virtual environment
which python  # Should show venv/bin/python

# Check dependencies
pip list | grep fastapi
pip list | grep chromadb

# Check database directory
ls -la chroma_db/
```

**Solutions**:
```bash
# Kill existing process
sudo kill $(lsof -t -i:8000)

# Activate virtual environment
source venv/bin/activate

# Reinstall dependencies
pip install -r requirements.txt

# Reset database
rm -rf chroma_db/
python main.py  # Will recreate database
```

### Search Returns No Results
**Symptoms**: Search queries return empty results array
**Common Causes**:
1. No documents indexed
2. Similarity threshold too high
3. Embedding model issues
4. Database corruption

**Diagnostic Steps**:
```bash
# Check document count
curl -s http://localhost:8000/metrics

# Test with simple query
curl -X POST http://localhost:8000/search -H "Content-Type: application/json" -d '{"query": "test", "min_similarity": 0.1}'

# Check database files
ls -la chroma_db/
```

**Solutions**:
```bash
# Index documents
curl -X POST http://localhost:8000/index -H "Content-Type: application/json" -d '{"platforms": ["all"]}'

# Lower similarity threshold
curl -X POST http://localhost:8000/search -H "Content-Type: application/json" -d '{"query": "test", "min_similarity": 0.3}'

# Reset and reindex
rm -rf chroma_db/
python main.py &
sleep 5
curl -X POST http://localhost:8000/index -H "Content-Type: application/json" -d '{"platforms": ["all"]}'
```

### Memory Issues
**Symptoms**: System runs out of memory or becomes very slow
**Common Causes**:
1. Large document sets
2. Memory leaks in embeddings
3. Too many concurrent requests
4. ChromaDB memory usage

**Diagnostic Steps**:
```bash
# Check memory usage
top -pid $(pgrep -f "python main.py")

# Check database size
du -sh chroma_db/

# Monitor during operation
watch -n 1 'ps aux | grep python'
```

**Solutions**:
```bash
# Restart with clean state
pkill -f "python main.py"
python main.py &

# Reduce batch size in config
export BATCH_SIZE=50

# Clear cache
rm -rf cache/
```

## 📱 Flutter App Issues

### App Won't Build
**Symptoms**: Flutter build fails with dependency errors
**Common Causes**:
1. Outdated Flutter/Dart versions
2. Platform-specific dependencies
3. Native code compilation issues
4. Gradle/CocoaPods problems

**Diagnostic Steps**:
```bash
# Check Flutter version
flutter --version

# Check dependencies
flutter pub deps

# Clean build
flutter clean
flutter pub get

# Check for platform issues
flutter doctor
```

**Solutions**:
```bash
# Update Flutter
flutter upgrade

# Clean and rebuild
flutter clean
flutter pub get
flutter pub deps

# Platform-specific fixes
cd ios && pod install && cd ..  # iOS
flutter build android --debug   # Android
```

### RAG Integration Not Working
**Symptoms**: Search functionality not working in Flutter app
**Common Causes**:
1. RAG backend not running
2. Network connectivity issues
3. API endpoint configuration
4. CORS issues

**Diagnostic Steps**:
```bash
# Check backend status
curl -s http://localhost:8000/

# Test search from command line
curl -X POST http://localhost:8000/search -H "Content-Type: application/json" -d '{"query": "test"}'

# Check Flutter logs
flutter logs
```

**Solutions**:
```bash
# Start RAG backend
cd rag_backend
source venv/bin/activate
python main.py &

# Test network connectivity
ping localhost

# Check CORS configuration in main.py
grep -n "CORSMiddleware" main.py
```

### State Management Issues
**Symptoms**: UI not updating or inconsistent state
**Common Causes**:
1. Riverpod provider not notifying
2. State mutations not properly handled
3. Widget not listening to provider
4. Async state management issues

**Diagnostic Steps**:
```dart
// Add debug prints in providers
print('Provider state updated: $state');

// Check widget listening
Consumer(
  builder: (context, ref, child) {
    final state = ref.watch(ragProvider);
    print('Widget rebuilding with state: $state');
    return YourWidget();
  },
)
```

**Solutions**:
```dart
// Ensure proper state updates
class RagNotifier extends StateNotifier<RagState> {
  void updateState(RagState newState) {
    state = newState; // This triggers rebuild
  }
}

// Use ref.invalidate() to force refresh
ref.invalidate(ragProvider);
```

## 🔗 Integration Issues

### Extended Exchange API
**Symptoms**: Trading functionality not working
**Common Causes**:
1. API key missing or invalid
2. Network connectivity issues
3. Rate limiting
4. Authentication problems

**Diagnostic Steps**:
```bash
# Test API directly
curl -H "Authorization: Bearer YOUR_API_KEY" https://api.extended.exchange/v1/account

# Check network
ping api.extended.exchange

# Check API key format
echo $EXTENDED_API_KEY | wc -c
```

**Solutions**:
```bash
# Set API key
export EXTENDED_API_KEY=your_actual_key

# Test with curl first
curl -H "Authorization: Bearer $EXTENDED_API_KEY" https://api.extended.exchange/v1/account

# Check rate limits
curl -I https://api.extended.exchange/v1/account
```

### Smart Contract Issues
**Symptoms**: Contract deployment or calls failing
**Common Causes**:
1. Network connectivity to Starknet
2. Insufficient funds for gas
3. Contract compilation errors
4. Account setup issues

**Diagnostic Steps**:
```bash
# Check Starknet connectivity
starkli block-number

# Check account balance
starkli balance 0x123...

# Test contract compilation
cd contracts/streetcred_xp
scarb build
```

**Solutions**:
```bash
# Fund account
# Use Starknet faucet for testnet

# Recompile contracts
scarb clean
scarb build

# Check deployment
starkli declare target/dev/contract.json
```

## 🐛 Common Error Patterns

### Python Import Errors
**Pattern**: `ImportError: cannot import name 'X' from 'Y'`
**Common Fix**: Check import paths and package versions
```bash
pip show package_name
pip install package_name --upgrade
```

### JSON Parsing Errors
**Pattern**: `JSONDecodeError: Expecting value`
**Common Fix**: Validate JSON format
```bash
echo '{"query": "test"}' | python -m json.tool
```

### Network Timeout Errors
**Pattern**: `ConnectionTimeout` or `ReadTimeout`
**Common Fix**: Increase timeout values
```python
import requests
requests.get(url, timeout=30)
```

### Database Lock Errors
**Pattern**: `database is locked`
**Common Fix**: Ensure single process access
```bash
pkill -f "python main.py"
rm -f chroma_db/*.lock
```

## 📋 Diagnostic Commands

### System Health Check
```bash
# Check all services
curl -s http://localhost:8000/ && echo "RAG Backend: OK" || echo "RAG Backend: FAIL"
flutter doctor && echo "Flutter: OK" || echo "Flutter: FAIL"
python --version && echo "Python: OK" || echo "Python: FAIL"
```

### Performance Monitoring
```bash
# RAG Backend performance
time curl -X POST http://localhost:8000/search -H "Content-Type: application/json" -d '{"query": "test"}'

# Memory usage
ps aux | grep python | grep main.py

# Database size
du -sh chroma_db/
```

### Log Analysis
```bash
# Python logs (if configured)
tail -f logs/rag_backend.log

# Flutter logs
flutter logs

# System logs
tail -f /var/log/system.log | grep -i error
```

## 🔄 Recovery Procedures

### Complete System Reset
```bash
# Stop all services
pkill -f "python main.py"
pkill -f "flutter run"

# Clean all data
rm -rf rag_backend/chroma_db/
rm -rf rag_backend/cache/
rm -rf rag_backend/logs/

# Restart services
cd rag_backend
source venv/bin/activate
python main.py &

# Reindex documents
sleep 5
curl -X POST http://localhost:8000/index -H "Content-Type: application/json" -d '{"platforms": ["all"]}'
```

### Database Recovery
```bash
# Backup current database
cp -r chroma_db/ chroma_db_backup_$(date +%Y%m%d_%H%M%S)/

# Reset database
rm -rf chroma_db/
python main.py &
sleep 5

# Reindex
curl -X POST http://localhost:8000/index -H "Content-Type: application/json" -d '{"platforms": ["all"]}'
```

## 📞 Escalation Procedures

### When to Escalate
1. **Data Loss**: Any situation involving potential data loss
2. **Security Issues**: Suspected security vulnerabilities
3. **External Dependencies**: Third-party service failures
4. **Performance Degradation**: Significant performance drops

### Information to Collect
1. **Error Messages**: Full error messages and stack traces
2. **System State**: Output of diagnostic commands
3. **Recent Changes**: What was changed before the issue
4. **Reproduction Steps**: How to reproduce the issue

### Documentation Requirements
1. **Update This File**: Add new issues and solutions
2. **Update MEMORIES.md**: Important technical decisions
3. **Update TODO.md**: Any new tasks created from the issue
4. **Commit Changes**: Ensure fixes are preserved

---

**Last Updated**: 2025-01-08  
**Next Review**: When new issues are discovered  
**Status**: ✅ All Known Issues Resolved