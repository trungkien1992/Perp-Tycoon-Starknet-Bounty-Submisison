# 🤖 Claude Code Project Rules - StreetCred Minimal

## 🎯 CRITICAL: Context Management Protocol

### **BEFORE ANY TASK - MANDATORY STEPS**

1. **📖 READ CONTEXT PRIME**
   ```
   ALWAYS read docs/context_prime.md FIRST before starting any task
   This file contains the complete project context and current state
   ```

2. **🔄 UPDATE CONTEXT IF NEEDED**
   ```
   If you make significant changes during your session:
   - Update docs/context_prime.md with new information
   - Add new components, services, or architectural changes
   - Update deployment status and implementation progress
   - Document any new dependencies or requirements
   ```

3. **📝 MAINTAIN SESSION CONTINUITY**
   ```
   When approaching token limits or session end:
   - Update docs/context_prime.md with current progress
   - Document any work in progress or next steps
   - Note any issues encountered or resolutions needed
   ```

## 🏗️ Project-Specific Guidelines

### **Architecture Principles**
- **Maintain Dual Mode**: Always preserve both mock and real mode functionality
- **Security First**: Never commit secrets, use secure configuration service
- **Real Blockchain**: Prioritize real Starknet integration over mock implementations
- **Production Ready**: All code should be production-ready, not just demo quality

### **Code Standards**
- **Flutter**: Follow Material Design with cyberpunk theme
- **Cairo**: Use production-ready smart contract patterns
- **State Management**: Use Riverpod providers consistently
- **Error Handling**: Implement comprehensive error handling with user feedback
- **Logging**: Use detailed console output for debugging

### **Testing Requirements**
- **Test Real Integration**: Always test actual blockchain interactions
- **Verify Security**: Validate all credential handling and signature processes
- **Document Testing**: Update test results in context documentation
- **Mock Fallbacks**: Ensure mock mode works for development

### **Deployment Focus**
- **Real Starknet**: Prioritize actual blockchain deployment over simulations
- **Testnet First**: Always test on testnet before mainnet considerations
- **Verification**: Use blockchain explorers to verify all deployments
- **Documentation**: Maintain clear deployment instructions

## 📝 MANDATORY: Documentation Update Protocol

### **CRITICAL RULE: ALWAYS UPDATE DOCS FOLDER**

**When making ANY significant changes, you MUST update the following files:**

1. **`docs/ARCHITECTURE.md`** - Update system architecture descriptions
2. **`docs/PROJECT_STATUS.md`** - Update current project status and progress  
3. **`docs/CONTEXT_PRIME.md`** - Update complete project context (if major changes)
4. **Create new doc files** - For new major features (like AVNU integration)

### **Documentation Update Checklist**

✅ **Before finishing any task involving:**
- New contracts or services
- Architecture changes
- API integrations
- Security modifications
- Deployment changes

✅ **You MUST:**
- [ ] Update relevant architecture documentation
- [ ] Create feature-specific documentation if major
- [ ] Update project status with new capabilities
- [ ] Note any breaking changes or deprecations
- [ ] Document new dependencies or requirements

### **Example Documentation Tasks**
- Added AVNU paymaster → Create `AVNU_PAYMASTER_INTEGRATION.md` + Update `ARCHITECTURE.md`
- Modified trading flow → Update `ARCHITECTURE.md` data flow diagrams
- New security features → Update `SECURITY.md` and `ARCHITECTURE.md`
- Removed old code → Update all relevant docs to remove references

### **Why This Matters**
- **Future Sessions**: Next Claude sessions need accurate context
- **Team Onboarding**: Developers need current architecture understanding
- **Maintenance**: Clear docs prevent technical debt and confusion
- **Deployment**: Accurate docs ensure correct production setup

## 🔧 Development Workflow

### **Starting a New Task**
1. Read `docs/context_prime.md` to understand current state
2. Check existing implementation before creating new components
3. Follow established patterns in the codebase
4. Test both mock and real modes when applicable

### **Making Changes**
1. Preserve existing functionality
2. Maintain backward compatibility
3. **MANDATORY: Update relevant documentation** (see Documentation Update Protocol below)
4. Test thoroughly before committing

### **Session Management**
1. Track progress in todo lists when appropriate
2. Update context file with significant changes
3. Document any issues or blockers encountered
4. Prepare clear handoffs for next sessions

## 🚨 Critical Constraints

### **Security Constraints**
- NEVER commit private keys or API keys to repository
- ALWAYS use SecureConfigService for credentials
- NEVER expose secrets in logs (use masked logging)
- ALWAYS validate all external inputs

### **Functionality Constraints**
- NEVER break existing mock mode functionality
- ALWAYS maintain real blockchain integration capability
- NEVER remove essential deployment scripts
- ALWAYS preserve core trading functionality

### **Code Quality Constraints**
- NEVER add code without proper error handling
- ALWAYS follow existing architectural patterns
- NEVER create duplicate functionality without removing old version
- ALWAYS maintain clear separation of concerns

## 📊 Project Status Awareness

### **Current State: PRODUCTION READY**
- ✅ Real Starknet integration implemented
- ✅ Actual blockchain deployment capability
- ✅ Complete trading functionality with Extended API
- ✅ Security implementation with encrypted credentials
- ✅ Comprehensive testing suite
- ✅ Production deployment automation

### **Key Technologies in Use**
- **Frontend**: Flutter 3.10+ with Riverpod state management
- **Blockchain**: Starknet with Cairo smart contracts
- **Trading**: Extended Exchange API with WebSocket market data
- **Deployment**: starkli CLI with automated scripts
- **Security**: Encrypted keystores and secure configuration

### **Next Development Phases**
- Mainnet deployment preparation
- Advanced trading features
- Enhanced user interface
- Performance optimizations
- Extended security audits

## 🎯 Success Criteria

### **For Any Task**
- Real blockchain integration remains functional
- Mock mode continues to work for development
- Security standards are maintained
- Documentation is updated appropriately
- Testing validates all changes

### **For Major Changes**
- Context prime file is updated with new information
- Deployment scripts work with changes
- All existing tests continue to pass
- New functionality includes comprehensive tests
- Security review is completed

---

## 📋 Quick Reference

**Context File**: `docs/context_prime.md` - READ THIS FIRST
**Main Documentation**: `README.md` - Project overview
**Deployment Guide**: `REAL_STARKNET_DEPLOYMENT.md` - Complete setup instructions
**Security Guide**: `SECURITY.md` - Security implementation details

---

> **🎯 REMEMBER**: This project has REAL blockchain integration. Always consider the implications of changes on actual Starknet deployments and real trading functionality.