# 📋 StreetCred Minimal - Session Context Prime

> **Purpose**: This file maintains the complete project context for Claude Code sessions. Update this file before starting any new tasks.

## 🎯 CRITICAL BUSINESS CONTEXT

**StreetCred Minimal** is now being developed as a **SUBMISSION FOR STARKWARE'S $25K-$1M BOUNTY** for a gamified mobile perpetual trading app targeting Gen-Z users (18-28).

### **Core Mission (CHANGED)**
- **Type**: Native mobile gamified trading app (NOT web app anymore)
- **Purpose**: Make perpetual trading addictive and social for TikTok generation
- **Target Users**: Gen-Z crypto-curious, reward-driven, mobile-first users
- **Business Goal**: Win StarkWare bounty and secure up to $1M funding
- **Deadline**: Time-bound bounty submission (URGENT)

### **Key Pivot Points**
- ❌ **OLD**: Flutter web app for crypto traders
- ✅ **NEW**: Native mobile game that happens to trade crypto
- ❌ **OLD**: Technical focus on blockchain infrastructure  
- ✅ **NEW**: User addiction and viral growth mechanics
- ❌ **OLD**: Traditional trading interface
- ✅ **NEW**: Swipe-based gaming with ecosystem growth

## 🎮 NEW PRODUCT VISION

### **The Gamified Experience**
```
User Journey:
Download → Tutorial (free trades) → Ecosystem Building → Real Trading → Social Sharing
├── Castle/Garden/Planet grows with wins
├── NFT achievements for milestones  
├── Streak-based XP and panic notifications
├── Leaderboards and clan competitions
└── Social bragging and shareable wins
```

### **Core Gameplay Mechanics**
- **Swipe Trading**: Up for LONG, Down for SHORT (like TikTok)
- **Ecosystem Growth**: Personal castle/garden that grows with success
- **Achievement NFTs**: Collectible milestones (first trade, streaks, etc.)
- **Social Competition**: Clans, leaderboards, friend battles
- **Retention Hooks**: Daily streaks, push notifications, FOMO triggers

### **Mobile-First Features**
- **Native iOS/Android** (not Flutter web)
- **Haptic feedback** on every action
- **Push notifications** for streak protection
- **Lock screen widgets** for quick trading
- **Instant visual feedback** (particles, animations)
- **Social sharing** integration

## 🏗️ REVISED ARCHITECTURE

### **Frontend (Native Mobile)**
```
Mobile App (React Native or Native iOS/Android)
├── Swipe Trading Interface      # Core gameplay mechanism
├── Ecosystem Visualization      # Castle/garden growth
├── Achievement System          # NFT collection display
├── Social Features            # Leaderboards, clans, sharing
├── Onboarding Tutorial        # Gamified free-play mode
└── Retention Mechanics        # Streaks, notifications, rewards
```

### **Backend Services (Existing + Enhanced)**
```
services/
├── real_starknet_service.dart    # Real blockchain integration (KEEP)
├── contract_service.dart         # Contract interaction (KEEP)
├── extended_api_client.dart      # Trading API (KEEP)
├── gamification_service.dart     # NEW: XP, streaks, achievements
├── ecosystem_service.dart        # NEW: Castle/garden mechanics
└── social_service.dart          # NEW: Leaderboards, clans
```

### **Smart Contracts (Enhanced for Gaming)**
```
contracts/
├── streetcred_xp/               # XP tracking + leaderboard (ENHANCE)
├── achievement_nft/             # NFT milestones (NEW)
├── ecosystem_growth/            # Castle/garden state (NEW)
└── paymaster/                   # Gasless transactions (KEEP)
```

## 🎯 BOUNTY REQUIREMENTS

### **Must-Have for v0 Submission**
- ✅ **Mobile-first frontend** (native iOS/Android)
- ✅ **Extended API integration** (one real trade)
- ✅ **XP tracking** for trades and streaks
- ✅ **Basic leaderboard** functionality
- ✅ **Paymaster integration** (zero gas fees)
- ✅ **Gamification mechanics** (ecosystem growth)
- ✅ **Social features** (sharing, competition)

### **Evaluation Criteria**
- **User Addiction**: Will Gen-Z users come back daily?
- **Viral Potential**: Will users share and compete?
- **Mobile UX**: Native features, haptics, instant feedback
- **Technical Integration**: Real trades via Extended API
- **Retention Design**: Streaks, rewards, social pressure

## 🚀 CURRENT TECHNICAL ASSETS

### **What We Can Leverage (From Previous Work)**
- ✅ **Real Starknet Integration**: Working blockchain deployment
- ✅ **Extended API Integration**: Real trading functionality
- ✅ **Smart Contracts**: XP tracking, NFT minting, paymaster
- ✅ **Security Implementation**: Encrypted credentials, secure config
- ✅ **Deployment Scripts**: Automated contract deployment

### **What Needs Complete Rebuild**
- ❌ **Frontend**: Flutter web → Native mobile
- ❌ **UX Design**: Trading interface → Gaming mechanics  
- ❌ **User Flow**: Professional → Addictive social experience
- ❌ **Visual Design**: Cyberpunk charts → Playful ecosystem growth

## 📱 IMPLEMENTATION PRIORITY

### **Phase 1: Core Mobile Game (Week 1)**
- [ ] Native mobile app foundation
- [ ] Swipe-based trading interface
- [ ] Basic ecosystem visualization (castle/garden)
- [ ] Haptic feedback implementation
- [ ] XP system with instant rewards

### **Phase 2: Social & Retention (Week 2)**
- [ ] Streak tracking with notifications
- [ ] Leaderboard with friend rankings
- [ ] Achievement NFT system
- [ ] Social sharing capabilities
- [ ] Clan/alliance features

### **Phase 3: Real Trading Integration (Week 3)**
- [ ] Extended API integration for real trades
- [ ] Paymaster integration (zero gas)
- [ ] Risk management for mobile users
- [ ] Real-time P&L with game feedback
- [ ] Mock trading mode for onboarding

### **Phase 4: Polish & Submission (Week 4)**
- [ ] Onboarding tutorial optimization
- [ ] Advanced ecosystem features
- [ ] Push notification system
- [ ] Analytics and user behavior tracking
- [ ] Demo video and submission materials

## 🎯 SUCCESS METRICS

### **User Engagement (Primary)**
- **Daily Active Users**: Target 70%+ retention day 1
- **Session Length**: Average 5+ minutes per session
- **Social Sharing**: 30%+ users share wins/ecosystem
- **Streak Completion**: 50%+ users maintain 3+ day streaks

### **Technical Performance**
- **Trade Execution**: <2 seconds from swipe to confirmation
- **Real Blockchain**: All trades verified on Starknet
- **Zero Gas**: 100% transactions sponsored by paymaster
- **Mobile Performance**: 60fps on all interactions

## 🔥 COMPETITIVE ADVANTAGES

### **What Sets Us Apart**
- **Real Blockchain Integration**: Already working Starknet deployment
- **Technical Foundation**: Proven Extended API integration
- **Security Implementation**: Production-ready credential management
- **Mobile Gaming Focus**: Ecosystem growth + social competition

### **Key Differentiators**
- **Ecosystem Metaphor**: Growing castle/garden beats generic points
- **Social Pressure**: Clan battles and streak protection
- **Native Mobile**: True iOS/Android features vs web wrapper
- **Real NFT Rewards**: Blockchain-verified achievements

## 🚨 CRITICAL RISKS

### **Technical Risks**
- **Platform Switch**: Moving from Flutter web to native mobile
- **Timeline Pressure**: 4 weeks to build production-quality app
- **Integration Complexity**: Combining gaming UX with real trading

### **Product Risks**
- **User Addiction**: Missing the psychology that hooks Gen-Z
- **Social Features**: Building community features that actually work
- **Mobile Performance**: Achieving smooth 60fps gaming experience

### **Business Risks**
- **Competition**: Other teams with gaming/mobile expertise
- **Market Fit**: Misunderstanding what Gen-Z actually wants
- **Technical Debt**: Rushing features without proper architecture

## 📋 DAILY BATTLE RHYTHM

### **Every Morning Review**
1. **Engagement Metrics**: How addictive is current build?
2. **Technical Progress**: What's blocking mobile development?
3. **User Testing**: Fresh eyes on latest build

### **Every Evening Assessment**
1. **Retention Design**: Would you use this tomorrow?
2. **Social Features**: Would you share/compete with friends?
3. **Mobile Feel**: Does it feel like a native game?

## 🎯 KEY DECISIONS NEEDED IMMEDIATELY

### **Technical Platform**
- **React Native** (faster development) vs **Native iOS** (better UX)
- **Ecosystem Theme**: Castle vs Garden vs Planet
- **Social Features**: Clans vs Friends vs Public leaderboards

### **Resource Allocation**
- **Solo Development** vs **Finding Team Members**
- **Design Priority**: Gaming mechanics vs Trading functionality
- **Testing Strategy**: Internal vs Real Gen-Z user feedback

## 📊 CURRENT STATUS

### **✅ Strong Foundation**
- Real Starknet blockchain integration working
- Extended API trading functionality proven
- Smart contracts deployed and tested
- Security implementation complete
- Paymaster integration functional

### **🔄 Major Pivot Required**
- Frontend: Web app → Native mobile game
- UX: Professional trading → Addictive gaming
- Users: Crypto traders → Gen-Z social gamers
- Metrics: Technical performance → User engagement

### **⏰ Timeline Pressure**
- **Bounty deadline**: Time-bound submission
- **Competition**: Other teams already building
- **Funding opportunity**: $25K-$1M potential reward

---

## 📝 Last Updated

**Date**: 2025-01-08  
**Session**: StarkWare Bounty Discovery + Strategic Pivot
**Status**: PIVOT TO MOBILE GAMING APP FOR STARKWARE BOUNTY
**Next Focus**: Native mobile development and gamification mechanics

**Critical Mission**: Win StarkWare bounty by building the most addictive mobile trading game for Gen-Z users

---

> **🎯 MISSION CRITICAL**: This is no longer a side project. This is a time-bound bounty with $25K-$1M funding potential. Every development decision must prioritize USER ADDICTION and MOBILE GAMING EXPERIENCE over technical perfection.