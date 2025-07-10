# Perp Tycoon - Casino Idle Game Documentation

## 🔴 MANDATORY SESSION INITIALIZATION
**CRITICAL**: At the beginning of EVERY new Claude Code session, you MUST explicitly state:

```
"Starting new session. Please load context by reading docs/README.md, docs/PROJECT_STATUS.md, docs/TODO.md"
```

This initialization is **REQUIRED** and must be completed before any development work begins.

## 🎮 Project Overview

**Perp Tycoon** is a casino-themed idle mobile game that transforms leveraged trading into an addictive gaming experience with real blockchain integration.

### 🎯 Core Concept
Transform your phone into a trading casino where every tap is a leveraged trade:
- **Tap-to-Trade**: Slot machine mechanics with crypto symbols
- **Idle Earnings**: Trading bots earn money while you're offline  
- **Real Integration**: One actual trade per day with Extended Exchange API
- **Blockchain Rewards**: NFTs and Stark Tokens for achievements

### 🏗️ Game Architecture Stack
```
Flutter Casino Game (Frontend)
    ↕
Game State Management (Riverpod Providers)
    ↕
Local Persistence (SQLite) + Blockchain Sync (Starknet)
    ↕
Real Trading Integration (Extended Exchange API)
```

## 📚 Documentation Structure

This documentation provides comprehensive guidance for Perp Tycoon development:

### 🎯 Essential Reading (Session Start Order)
**MUST READ FIRST** in every new Claude Code session:

1. **[README.md](README.md)** - Project overview and quick start (THIS FILE)
2. **[PROJECT_STATUS.md](PROJECT_STATUS.md)** - Current development status and infrastructure readiness
3. **[TODO.md](TODO.md)** - Active development tasks and priorities
4. **[ARCHITECTURE.md](ARCHITECTURE.md)** - High-level system design and component architecture
5. **[COLLABORATION_GUIDE.md](COLLABORATION_GUIDE.md)** - Development protocols and session management

### 🎮 Game Development
- **[GAME_DESIGN.md](GAME_DESIGN.md)** - Casino game mechanics and progression systems
- **[MEMORIES.md](MEMORIES.md)** - Design decisions and rationale documentation

### 📁 Detailed Documentation
For comprehensive implementation details, see:
- **[project-rules/docs/](../project-rules/docs/)** - Complete game development documentation
  - `CONTEXT_PRIME.md` - Complete game vision and core loop
  - `GAME_PIVOT_PLAN.md` - 4-phase development roadmap (130-174 hours)
  - `KNOWLEDGE_BASE.md` - Game mechanics formulas and patterns

## 🎮 Game Development Phases

### 🧱 PHASE 1 – Core Game Loop (Week 1)
**Goal**: Transform trading interface into casino game
- Convert `trading_screen.dart` → `casino_floor_screen.dart`
- Add slot machine animations and PnL burst effects
- Implement XP bar and vault cash display
- Create upgrade shop, bot management, and prestige screens

### 🎯 PHASE 2 – Automation & Idle (Week 1-2)
**Goal**: Implement idle game mechanics
- Tap-to-trade engine using real market volatility
- Trading bot system with automated earnings
- Upgrade system with SQLite persistence
- Offline earnings calculation

### ⛓ PHASE 3 – Real Trading Integration (Week 2-3)
**Goal**: Connect game to real blockchain and trading
- Daily "One Real Trade" button with Extended Exchange API
- XP contract sync on milestones
- NFT minting for achievements
- Prestige reset with Stark Token rewards

### 🌐 PHASE 4 – Social & Viral (Week 3)
**Goal**: Add retention and viral mechanics
- Global leaderboards using blockchain contracts
- Daily login bonuses and volatility surge events
- Social sharing and community features

## 🏗️ Infrastructure Status (100% Complete)

### ✅ Ready for Game Development
- **Flutter App Foundation** - Complete mobile app framework
- **Starknet Integration** - Wallet connection, contract interaction
- **Extended Exchange API** - Real trading backend ready
- **Smart Contracts** - XP tracking, NFT minting, gasless transactions
- **RAG Knowledge Base** - Development tool for context retrieval

## 🚀 Quick Start

### Prerequisites
- Flutter 3.10+ with mobile support
- Dart 3.0+
- Python 3.10+ (for real trading integration)
- Lottie/Rive for animations

### Development Commands
```bash
# Start RAG Backend (Development Tool)
cd knowledge_base/backend && source venv/bin/activate && python main.py

# Start Flutter Casino Game
flutter run

# Start Real Trading Service (Phase 3)
cd python_trading_service && source venv/bin/activate && python main.py
```

## 🤝 Development Protocol

1. **Start each session** by reading documentation files
2. **MANDATORY**: Use TodoWrite tool for tracking game development progress
3. **MANDATORY**: Mark tasks as "in_progress" before starting work
4. **MANDATORY**: Mark tasks as "completed" after finishing work
5. **Follow 4-phase development plan** outlined in documentation
6. **Test game mechanics** thoroughly after each implementation
7. **MANDATORY**: Update documentation immediately after changes

### Task Assignment Protocol
When assigning tasks, specify:
- **Task status updates**: "mark as in_progress," "mark as completed"
- **Documentation updates**: Which docs/ files need updating after completion
- **TODO.md is the single source of truth** for active work

### Documentation Maintenance
After significant changes, update:
- **PROJECT_STATUS.md** - Progress and new features
- **ARCHITECTURE.md** - System design changes
- **GAME_DESIGN.md** - Game mechanics changes
- **MEMORIES.md** - Design rationale and decisions

## 🎯 Current Status

**Project Status**: 🎮 **Casino Idle Game - Ready for Development**  
**Infrastructure**: ✅ **100% Complete**  
**Game Development**: 📋 **Phase 1 Ready to Begin**  
**Timeline**: 130-174 hours across 4 development phases  

**Next Priority**: Begin Phase 1 - Core Game Loop implementation

---

**Last Updated**: 2025-01-10  
**Version**: Perp Tycoon v1.0  
**Status**: Infrastructure Complete - Casino Game Development Ready  
**Next Phase**: Phase 1 - Core Game Loop Implementation