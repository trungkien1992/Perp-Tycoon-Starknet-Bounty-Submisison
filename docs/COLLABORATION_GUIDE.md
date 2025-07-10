# Perp Tycoon - Collaboration Guide

## 🤝 Claude Code Session Protocol

This guide establishes standardized protocols for Claude Code development sessions on the Perp Tycoon casino idle game project.

## 🚀 Session Start Protocol

### 🔴 MANDATORY SESSION INITIALIZATION
**CRITICAL**: At the beginning of EVERY new Claude Code session, you MUST explicitly state:

```
"Starting new session. Please load context by reading docs/README.md, docs/PROJECT_STATUS.md, docs/TODO.md"
```

This initialization is **REQUIRED** and must be completed before any development work begins.

### Essential Reading Order
**IMPORTANT**: At the start of each new Claude Code session, read these files in order:

1. **[docs/README.md](README.md)** - Project overview and quick start
2. **[docs/PROJECT_STATUS.md](PROJECT_STATUS.md)** - Current development status
3. **[docs/TODO.md](TODO.md)** - Active development tasks
4. **[docs/ARCHITECTURE.md](ARCHITECTURE.md)** - System architecture overview
5. **[project-rules/docs/CONTEXT_PRIME.md](../project-rules/docs/CONTEXT_PRIME.md)** - Complete game vision and context
6. **[project-rules/docs/GAME_PIVOT_PLAN.md](../project-rules/docs/GAME_PIVOT_PLAN.md)** - 4-phase development roadmap

### Context Verification
Before starting work, verify:
- Current development phase (Phase 1-4)
- Infrastructure status (should be 100% complete)
- Active tasks from TODO.md
- Any blockers or dependencies

### Session Initialization Training
This protocol trains the AI to prioritize context loading by:
- **Explicit Context Loading**: Forces reading of core documents first
- **Consistent Routine**: Establishes predictable session start behavior
- **Priority Setting**: Ensures project context takes precedence over any other requests

## 🎮 Game Development Protocols

### Core Development Principles
- **Game-First Architecture**: All code organized around game mechanics
- **60fps Performance Target**: Maintain smooth animations and interactions
- **Phase-Based Development**: Follow 4-phase roadmap strictly
- **Test Game Mechanics**: Validate progression formulas and balance

### Phase-Specific Protocols

#### Phase 1: Core Game Loop
- **Focus**: Convert trading interface to casino floor
- **Priority**: Slot machine animations and tap-to-trade mechanics
- **Testing**: Verify XP progression and cash accumulation
- **Documentation**: Update game state provider implementation

#### Phase 2: Automation & Idle
- **Focus**: Implement bot system and idle earnings
- **Priority**: Offline earnings calculation accuracy
- **Testing**: Verify bot performance and time-based calculations
- **Documentation**: Update bot management and upgrade systems

#### Phase 3: Real Trading Integration
- **Focus**: Connect to blockchain and real trading
- **Priority**: Daily trade limits and NFT rewards
- **Testing**: Test with minimal amounts, verify blockchain sync
- **Documentation**: Update real trading integration status

#### Phase 4: Social & Viral
- **Focus**: Add retention and social features
- **Priority**: Leaderboards and sharing mechanics
- **Testing**: Verify social features and viral loops
- **Documentation**: Update social feature implementation

## 🛠️ Development Workflow

### 1. Task Management (MANDATORY TODO.md Updates)
- **MANDATORY**: Update TODO.md with task status for every task assignment
- **Before starting work**: Mark task as "in_progress" in TODO.md
- **After completing work**: Mark task as "completed" in TODO.md
- **When discovering new tasks**: Add to TODO.md with appropriate priority
- **Break large tasks** into smaller, manageable pieces in TODO.md
- **TODO.md is the single source of truth** for all active work

#### Task Assignment Protocol
When assigning any task, you MUST:
1. **Update TODO.md** with the task and mark as "in_progress"
2. **Specify task status** explicitly (e.g., "mark as in_progress," "mark as completed")
3. **Include time estimates** for new tasks discovered during work
4. **Update priority levels** based on current development phase

### 2. Code Implementation
- **Follow existing patterns** in the codebase
- **Read files before editing** to understand context
- **Test changes thoroughly** before moving to next task
- **Maintain 60fps performance** throughout development

### 3. Documentation Updates (MANDATORY After Changes)
**CRITICAL**: After any significant code change, design decision, or problem resolution, you MUST update relevant documentation:

#### Required Documentation Updates
- **After UI changes**: Update PROJECT_STATUS.md with new features
- **After architecture changes**: Update ARCHITECTURE.md with system design changes
- **After game mechanic changes**: Update GAME_DESIGN.md with new mechanics
- **After completing milestones**: Update PROJECT_STATUS.md with progress
- **After solving problems**: Document solution rationale in relevant docs

#### Example Protocol
```
"Now that we've updated the TradingScreen, please update docs/PROJECT_STATUS.md 
to reflect the new UI features and docs/GAME_DESIGN.md with the design rationale."
```

### 4. Documentation Maintenance Standards
- **Immediate Updates**: Documentation must be updated immediately after changes
- **Cross-Reference Updates**: Update all related documentation files
- **Design Rationale**: Document the "why" behind decisions, not just the "what"
- **Status Tracking**: Keep PROJECT_STATUS.md current with latest progress

## 📊 Quality Assurance

### Code Quality Standards
- **Follow Flutter best practices** for state management
- **Use Riverpod providers** for game state management
- **Implement proper error handling** for all game actions
- **Maintain type safety** throughout Dart code

### Game Balance Testing
- **Validate progression formulas** mathematically
- **Test idle earnings calculations** with various time intervals
- **Verify upgrade costs** and benefit scaling
- **Balance bot performance** across different markets

### Performance Requirements
- **60fps target** for all animations and interactions
- **<3 second app startup** time
- **Efficient memory usage** for idle game calculations
- **Battery optimization** for background processing

## 🔧 Technical Protocols

### Infrastructure Usage
- **RAG Backend**: Use for development context and documentation search
- **Flutter Hot Reload**: Utilize for rapid iteration during development
- **Smart Contracts**: Test blockchain integration carefully with small amounts
- **Extended Exchange API**: Use mock data for development, real API for final testing

### Development Environment
- **Local SQLite**: For game state persistence during development
- **Mock Trading**: For rapid game mechanic testing
- **Real Trading**: Only for final integration testing
- **Blockchain**: Test on appropriate networks before mainnet

## 🎯 Session Management

### During Development Sessions
1. **Start with TodoRead** to understand current tasks
2. **MANDATORY**: Use TodoWrite to mark tasks as "in_progress" before starting work
3. **Use TodoWrite** to track progress throughout session
4. **Test frequently** during implementation
5. **MANDATORY**: Update documentation immediately after changes
6. **Commit changes** with descriptive messages

### Session Wrap-up Protocol
1. **MANDATORY**: Mark completed tasks as "completed" in TodoWrite
2. **MANDATORY**: Update PROJECT_STATUS.md with current progress
3. **Add new tasks** discovered during development to TODO.md
4. **Document any blockers** or issues encountered
5. **Update next session priorities** in TODO.md
6. **Verify all documentation** is current and accurate

### Task Assignment Examples
When assigning tasks, use this format:

```
"Please implement the casino floor tap button. 
Before starting: mark task as 'in_progress' in TODO.md.
After completion: mark as 'completed' in TODO.md and update 
docs/PROJECT_STATUS.md with the new UI feature."
```

### Documentation Update Examples
After significant changes:

```
"Now that we've implemented the bot system, please update:
- docs/PROJECT_STATUS.md to reflect Phase 2 progress
- docs/ARCHITECTURE.md with the new bot provider architecture
- docs/GAME_DESIGN.md with the idle earnings mechanics"
```

## 🚨 Common Pitfalls to Avoid

### Development Mistakes
- **Don't skip testing** game mechanics during implementation
- **Don't modify smart contracts** without thorough testing
- **Don't ignore performance implications** of idle calculations
- **Don't break existing functionality** when adding new features

### Documentation Mistakes
- **Don't leave TODO tasks** unmarked after completion (MANDATORY to update)
- **Don't forget to update** PROJECT_STATUS.md after major changes (MANDATORY)
- **Don't create new documentation** without cross-referencing
- **Don't leave broken links** between documentation files
- **Don't skip documentation updates** after code changes (MANDATORY)
- **Don't forget to document design rationale** for decisions

## 📈 Progress Tracking

### Key Performance Indicators
- **Tasks completed** per session
- **Phase progress** toward completion
- **Code quality** metrics (test coverage, performance)
- **Game balance** validation results

### Milestone Reporting
- **Phase completion** updates in PROJECT_STATUS.md
- **Infrastructure changes** documented in ARCHITECTURE.md
- **Game mechanics** validated and documented
- **Performance benchmarks** met and recorded

## 🔗 Cross-References

### Essential Documentation
- **[README.md](README.md)** - Project overview and quick start
- **[ARCHITECTURE.md](ARCHITECTURE.md)** - System design and components
- **[PROJECT_STATUS.md](PROJECT_STATUS.md)** - Current development status
- **[TODO.md](TODO.md)** - Active development tasks
- **[GAME_DESIGN.md](GAME_DESIGN.md)** - Casino game mechanics

### Detailed Implementation Guides
- **[project-rules/docs/](../project-rules/docs/)** - Complete development documentation
- **[knowledge_base/](../knowledge_base/)** - Technical reference materials
- **[contracts/](../contracts/)** - Smart contract implementation
- **[lib/](../lib/)** - Flutter game implementation

---

**Protocol Version**: 1.0  
**Last Updated**: 2025-01-10  
**Next Review**: After Phase 1 completion  
**Status**: Active development protocol for casino idle game