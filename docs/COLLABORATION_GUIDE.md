# Collaboration Guide - Working with Claude

## 🤝 Session Protocol

### 📋 At the Start of Each Session

**REQUIRED**: Please read these files in order:
1. [ARCHITECTURE.md](ARCHITECTURE.md) - System overview
2. [MACHINE_INFO.md](MACHINE_INFO.md) - Environment details
3. [PROJECT_STATUS.md](PROJECT_STATUS.md) - Current progress
4. [TODO.md](TODO.md) - Active tasks
5. [MEMORIES.md](MEMORIES.md) - Important context
6. [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - Known issues

**Example opening**: "I'm starting a new session. Let me read the documentation files to understand the current state."

### 🎯 Working Approach

#### Take Things Step by Step
1. **Understand First**: Read relevant documentation before starting
2. **Plan Second**: Break complex tasks into smaller steps
3. **Execute Third**: Implement one component at a time
4. **Verify Fourth**: Test each component before moving on
5. **Document Fifth**: Update documentation as you go

#### Use TodoWrite Tool Frequently
- Create todos for multi-step tasks
- Mark tasks as in_progress when working
- Mark tasks as completed immediately when done
- Never batch completion - update in real-time

## 🛠️ Technical Guidelines

### Code Changes
- **Always read files first** before editing
- **Follow existing patterns** in the codebase
- **Test changes immediately** after implementation
- **Never create new files** unless absolutely necessary
- **Update documentation** when making significant changes

### Testing Protocol
```bash
# Always test RAG backend after changes
cd rag_backend
source venv/bin/activate
python test_rag.py

# Always test Flutter app after changes
flutter test
flutter run -d chrome # for web testing
```

### Error Handling
- **Document all errors** in TROUBLESHOOTING.md
- **Include full error messages** and solutions
- **Test fixes thoroughly** before marking complete
- **Update prevention measures** for future sessions

## 📊 Progress Tracking

### Real-time Updates
- **Update TODO.md** as tasks progress
- **Update PROJECT_STATUS.md** when major milestones complete
- **Update MEMORIES.md** with important decisions
- **Commit changes frequently** with descriptive messages

### Status Communication
- **Be specific** about what you're working on
- **Provide time estimates** for complex tasks
- **Report blockers immediately** when encountered
- **Celebrate completions** when tasks finish

## 🔄 Session Management

### During the Session
1. **Focus on one task** at a time
2. **Use the TodoWrite tool** to track progress
3. **Test frequently** to catch issues early
4. **Ask for clarification** when requirements are unclear
5. **Update documentation** as you work

### Communication Style
- **Be concise** but thorough
- **Provide context** for technical decisions
- **Explain complex changes** in simple terms
- **Use status indicators** (✅ ❌ 🔄 📋) for clarity

## 🎯 Task Prioritization

### Priority Levels
- **🔥 Critical**: Blocking other work, must be done now
- **🔶 High**: Important for current sprint, do this week
- **🔷 Medium**: Valuable improvement, do when time permits
- **📋 Low**: Nice to have, backlog item

### Task Selection
1. **Check TODO.md** for current priorities
2. **Address blockers first** (🔥 Critical)
3. **Focus on sprint goals** (🔶 High priority)
4. **Complete current tasks** before starting new ones

## 🧪 Testing Strategy

### Before Making Changes
- **Understand the current state** by reading code
- **Check existing tests** to understand expected behavior
- **Identify what might break** with your changes

### After Making Changes
- **Run relevant tests** immediately
- **Test the happy path** first
- **Test edge cases** and error conditions
- **Verify integrations** still work

### Test Commands
```bash
# RAG Backend Tests
cd rag_backend && source venv/bin/activate
python test_rag.py                    # Full system test
curl -s http://localhost:8000/        # Health check
curl -X POST http://localhost:8000/search -d '{"query":"test"}' # Search test

# Flutter Tests
flutter test                          # Unit tests
flutter analyze                       # Code analysis
flutter run -d chrome                 # Web testing
```

## 📝 Documentation Standards

### When to Update Documentation
- **Architecture changes**: Update ARCHITECTURE.md
- **New features**: Update PROJECT_STATUS.md
- **Environment changes**: Update MACHINE_INFO.md
- **New tasks**: Update TODO.md
- **Important decisions**: Update MEMORIES.md
- **Issues found**: Update TROUBLESHOOTING.md

### Documentation Style
- **Use clear headings** with emoji indicators
- **Include code examples** where relevant
- **Provide step-by-step instructions**
- **Keep information current** and accurate
- **Use consistent formatting** across files

## 🔧 Problem-Solving Approach

### When Things Go Wrong
1. **Stay calm** and systematic
2. **Read error messages** carefully
3. **Check TROUBLESHOOTING.md** for known issues
4. **Isolate the problem** to specific components
5. **Test fixes incrementally**
6. **Document the solution** for future reference

### Debugging Strategy
```bash
# Check system status
cd rag_backend && source venv/bin/activate
python test_rag.py

# Check logs
tail -f logs/error.log  # if logging is set up

# Test individual components
python -c "import chromadb; print('ChromaDB OK')"
python -c "from sentence_transformers import SentenceTransformer; print('Transformers OK')"
```

## 🎭 Session Roles

### As the Developer
- **Read documentation** before starting work
- **Follow the step-by-step approach**
- **Test thoroughly** and document issues
- **Update documentation** as work progresses
- **Communicate clearly** about progress and blockers

### As the Project Manager
- **Prioritize tasks** based on business value
- **Track progress** using the TodoWrite tool
- **Identify dependencies** and blockers
- **Make decisions** about scope and priorities
- **Ensure quality** through testing and review

## 🚀 Success Metrics

### Technical Excellence
- **Code quality**: Clean, readable, maintainable
- **Test coverage**: Comprehensive testing strategy
- **Performance**: Meets or exceeds requirements
- **Documentation**: Current and comprehensive

### Project Management
- **Task completion**: Consistent progress on priorities
- **Communication**: Clear status updates
- **Quality**: Thorough testing and review
- **Documentation**: Up-to-date project state

## 🎯 Best Practices

### Do's
- ✅ **Read documentation** before starting work
- ✅ **Use TodoWrite tool** for tracking
- ✅ **Test immediately** after changes
- ✅ **Update documentation** as you go
- ✅ **Commit frequently** with good messages
- ✅ **Ask questions** when unclear

### Don'ts
- ❌ **Don't skip reading** documentation
- ❌ **Don't batch todo updates**
- ❌ **Don't skip testing** after changes
- ❌ **Don't leave documentation** outdated
- ❌ **Don't create unnecessary files**
- ❌ **Don't work on multiple tasks** simultaneously

---

**Last Updated**: 2025-01-08  
**Next Review**: When collaboration patterns change  
**Version**: 1.0.0