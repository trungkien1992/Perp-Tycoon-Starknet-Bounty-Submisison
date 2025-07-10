# Perp Tycoon - Design Decisions & Rationale

## 📝 Purpose

This document captures the design decisions, problem resolutions, and rationale behind key choices made during Perp Tycoon casino game development. It serves as institutional memory for the project.

## 🎮 Game Design Decisions

### Core Mechanics

#### Casino Theme Choice
**Decision**: Transform trading interface into casino slot machine mechanics
**Date**: 2025-01-10
**Rationale**: 
- Makes trading accessible and fun for general audience
- Slot machine mechanics are universally understood
- Creates addictive gameplay loop similar to successful idle games
- Visual metaphor makes complex trading concepts approachable

#### Idle Game Architecture
**Decision**: Implement bot-based passive earnings system
**Date**: 2025-01-10
**Rationale**:
- Proven engagement pattern in idle games
- Allows progression while offline
- Creates upgrade purchase motivation
- Balances active and passive gameplay

### Technical Architecture Decisions

#### State Management: Riverpod
**Decision**: Use Riverpod for game state management
**Date**: 2025-01-10
**Rationale**:
- Existing codebase already uses Riverpod
- Excellent for complex state interactions
- Supports game state persistence
- Handles async operations well for blockchain integration

#### Local Storage: SQLite
**Decision**: Use SQLite for local game state persistence
**Date**: 2025-01-10
**Rationale**:
- Already included in project dependencies
- Reliable offline storage
- Supports complex queries for game statistics
- Fast performance for idle game calculations

#### Animation Framework: Lottie/Rive
**Decision**: Use Lottie or Rive for slot machine animations
**Date**: 2025-01-10
**Rationale**:
- Hardware-accelerated animations
- Professional quality casino effects
- Scalable vector animations
- Supports complex casino-themed designs

## 🏗️ Architecture Decisions

### Phase-Based Development
**Decision**: Implement 4-phase development roadmap
**Date**: 2025-01-10
**Rationale**:
- Ensures systematic progression
- Allows for testing and validation at each phase
- Provides clear milestones and deliverables
- Enables iterative feedback and improvements

### Infrastructure Reuse
**Decision**: Leverage 100% of existing trading infrastructure
**Date**: 2025-01-10
**Rationale**:
- Existing blockchain integration is complete
- Real trading API already functional
- Smart contracts deployed and tested
- Saves significant development time

## 🔧 Technical Problem Resolutions

### Performance Requirements
**Problem**: Ensure 60fps performance for casino animations
**Solution**: Use hardware-accelerated animations with Lottie/Rive
**Date**: 2025-01-10
**Rationale**:
- Casino games require smooth, responsive animations
- Poor performance breaks immersion
- Mobile devices need efficient animation systems
- Hardware acceleration ensures consistent performance

### Game Balance
**Problem**: Balance manual tapping vs idle bot earnings
**Solution**: Progressive scaling where bots dominate in late game
**Date**: 2025-01-10
**Rationale**:
- Early game should reward active engagement
- Late game should reward strategic bot management
- Prestige system provides long-term progression
- Maintains engagement across all game phases

## 🎯 UI/UX Decisions

### Single-Tap Interface
**Decision**: Center game around single tap button
**Date**: 2025-01-10
**Rationale**:
- Simplifies complex trading to one action
- Mobile-first design for thumb accessibility
- Creates satisfying tactile feedback
- Reduces cognitive load for casual players

### Visual Theme: Cyberpunk Casino
**Decision**: Dark backgrounds with neon accents
**Date**: 2025-01-10
**Rationale**:
- Appeals to crypto/trading audience
- Creates immersive casino atmosphere
- High contrast for mobile readability
- Distinctive visual identity

## 🔗 Integration Decisions

### Real Trading Limits
**Decision**: Limit to 1 real trade per day
**Date**: 2025-01-10
**Rationale**:
- Prevents excessive risk-taking
- Maintains game focus over trading focus
- Regulatory compliance considerations
- Creates special event feeling for real trades

### Blockchain Integration
**Decision**: Use Starknet for XP and achievement NFTs
**Date**: 2025-01-10
**Rationale**:
- Existing infrastructure already deployed
- Gasless transactions via AVNU paymaster
- Scalable for large user base
- Provides real value for achievements

## 📊 Documentation Decisions

### Documentation Structure
**Decision**: Separate docs/ folder for high-level documentation
**Date**: 2025-01-10
**Rationale**:
- Clear separation of concerns
- High-level docs for quick reference
- Detailed docs in project-rules for implementation
- Supports different audiences (managers vs developers)

### Session Protocol
**Decision**: Mandatory session initialization with explicit context loading
**Date**: 2025-01-10
**Rationale**:
- Ensures consistent development sessions
- Prevents context loss between sessions
- Establishes clear protocols for AI assistance
- Maintains project continuity

## 🔄 Process Decisions

### TODO.md as Single Source of Truth
**Decision**: Mandate TODO.md updates for all task management
**Date**: 2025-01-10
**Rationale**:
- Prevents task tracking fragmentation
- Ensures clear status visibility
- Supports async development workflow
- Maintains accountability for task completion

### Mandatory Documentation Updates
**Decision**: Require documentation updates after significant changes
**Date**: 2025-01-10
**Rationale**:
- Prevents documentation drift
- Maintains project knowledge base
- Supports handoffs between sessions
- Preserves design rationale for future reference

## 🎮 Game Mechanics Decisions

### Prestige System
**Decision**: "Retire Rich" mechanic with Stark Token rewards
**Date**: 2025-01-10
**Rationale**:
- Provides long-term progression beyond level caps
- Creates meaningful blockchain rewards
- Maintains engagement for experienced players
- Adds strategic depth to progression decisions

### Bot Specialization
**Decision**: Bots specialize in different crypto markets
**Date**: 2025-01-10
**Rationale**:
- Adds strategic depth to bot selection
- Reflects real trading market diversity
- Creates upgrade paths and decisions
- Matches real market volatility patterns

## 🔮 Future Considerations

### Scalability
**Future Decision**: Plan for viral growth and social features
**Rationale**:
- Game designed for viral mechanics
- Social features planned for Phase 4
- Infrastructure can handle scale
- Blockchain integration supports global leaderboards

### Content Updates
**Future Decision**: Regular balance updates and new content
**Rationale**:
- Idle games require ongoing balance
- New bot types and upgrades for retention
- Seasonal events and competitions
- Community-driven feature requests

---

**Document Purpose**: Institutional memory for design decisions  
**Last Updated**: 2025-01-10  
**Version**: 1.0  
**Status**: Active development documentation