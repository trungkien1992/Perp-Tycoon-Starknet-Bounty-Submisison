# Perp Tycoon - Casino Game Design

## 🎮 Game Overview

**Perp Tycoon** is a casino-themed idle mobile game that transforms leveraged trading into an addictive gaming experience. Players enter a neon-lit underground trading casino where every tap simulates a leveraged trade through slot machine mechanics.

## 🎯 Core Game Loop

### The Perp Tycoon Experience
```
Tap → Trade Simulation → Earn/Lose → Upgrade → Automate → Prestige
  ↑                                                            ↓
  ←←←←←←←←←←←←←←←←←← Reset & Earn Stark Tokens ←←←←←←←←←←←←←←←←←←←
```

### Primary Mechanics
1. **Tap-to-Trade**: Each tap triggers a slot machine animation simulating a leveraged trade
2. **Earn & Upgrade**: Successful trades earn cash to buy better trading tools and multipliers
3. **Automate**: Hire trading bots that earn money while offline (idle game mechanics)
4. **Prestige**: Reset all progress to earn Stark Tokens (permanent blockchain rewards)
5. **Real Integration**: One actual trade per day with Extended Exchange API

## 🎰 Casino Floor System

### Main Interface (`casino_floor_screen.dart`)
- **Tap Button**: Large, prominent trading button in center
- **Slot Machine Animation**: Visual reels with crypto symbols (BTC, ETH, AVAX, etc.)
- **XP Bar**: Always visible progress bar showing level advancement
- **Vault Cash**: Real-time cash display with satisfying increment animations
- **PnL Burst Effects**: Green coin showers for wins, red glitch effects for losses

### Visual Theme
- **Cyberpunk Casino**: Dark backgrounds with neon lighting
- **Color Scheme**: Electric green/red for PnL, cyan/magenta accents
- **Sound Design**: Slot machine spins, cash register dings, explosion effects
- **Haptic Feedback**: Tactile responses for taps, wins, and major events

## 🤖 Trading Bot System

### Bot Mechanics
Each bot specializes in different markets and has unique characteristics:

| Bot Type | Market | Base Profit/Hour | Upgrade Cost | Special Ability |
|----------|--------|------------------|--------------|-----------------|
| **ETH Enthusiast** | ETH | 100 coins | 1,000 coins | +20% during ETH volatility |
| **BTC Maximalist** | BTC | 200 coins | 2,500 coins | Consistent earnings |
| **AVAX Adventurer** | AVAX | 150 coins | 1,500 coins | +50% chance of bonus |
| **Meme Coin Maniac** | MEME | 300 coins | 5,000 coins | High risk/reward |
| **Stablecoin Sage** | USDC | 50 coins | 500 coins | Never loses money |

### Bot Management
- **Visual Avatars**: Each bot has unique personality and appearance
- **Performance Stats**: Win rate, profit generated, time active
- **Upgrade Paths**: Speed, accuracy, profit multipliers
- **Market Specialization**: Bots perform better in their specialized markets

## 📈 Upgrade Shop System

### Upgrade Categories

#### Win Rate Boosts
- **Insider Info**: +5% win rate (Cost: 1,000 coins)
- **Technical Analysis**: +10% win rate (Cost: 5,000 coins)
- **Market Manipulation**: +15% win rate (Cost: 20,000 coins)

#### PnL Multipliers
- **Leverage 2x**: Double profit/loss (Cost: 2,000 coins)
- **Leverage 5x**: 5x profit/loss (Cost: 10,000 coins)
- **Leverage 10x**: 10x profit/loss (Cost: 50,000 coins)

#### Speed Enhancements
- **Faster Execution**: -0.5s trade time (Cost: 1,500 coins)
- **Lightning Speed**: -1s trade time (Cost: 7,500 coins)
- **Instant Trades**: -2s trade time (Cost: 30,000 coins)

#### Cosmetic Upgrades
- **Neon Lights**: Casino floor lighting effects
- **VIP Area**: Exclusive trading section
- **Diamond Buttons**: Premium tap button appearance

## 🔄 Prestige System

### "Retire Rich" Mechanics
When players reach specific milestones, they can "retire" to earn permanent benefits:

### Prestige Triggers
- **Cash Milestone**: Accumulate 1 million coins
- **XP Milestone**: Reach level 50
- **Achievement Combo**: Complete 10 different achievements

### Stark Token Rewards
- **Prestige Tier 1**: 1 Stark Token → +10% all earnings permanently
- **Prestige Tier 2**: 5 Stark Tokens → +25% all earnings permanently
- **Prestige Tier 3**: 10 Stark Tokens → +50% all earnings permanently

### Reset Mechanics
- **Wiped**: Cash, bots, upgrades return to zero
- **Preserved**: Stark Tokens, achievements, XP milestones
- **Bonus**: Permanent multipliers based on Stark Token count

## 🎲 Trade Simulation Engine

### Volatility-Based Outcomes
```dart
// Trade outcome calculation
bool isWin = Random().nextDouble() < (baseWinRate + upgradeBonus);
double volatility = getMarketVolatility(selectedMarket);
double pnl = (isWin ? 1 : -1) * volatility * leverageMultiplier;
```

### Market Behavior
- **ETH**: Medium volatility, steady performance
- **BTC**: Low volatility, reliable but slow gains
- **AVAX**: High volatility, boom or bust outcomes
- **MEME**: Extreme volatility, massive wins/losses possible
- **USDC**: Minimal volatility, safe but low returns

## 💰 Game Economy Balance

### Progression Curve
1. **Early Game (Levels 1-10)**: Manual tapping, first upgrades
2. **Mid Game (Levels 11-30)**: First bots, automation begins
3. **Late Game (Levels 31-50)**: Multiple bots, advanced upgrades
4. **End Game (50+)**: Prestige preparation, Stark Token accumulation

### Cash Flow Formula
```dart
// Total earnings calculation
double totalEarnings = manualTapEarnings + botPassiveEarnings;
double manualTapEarnings = tapCount * baseTapValue * winRate * multipliers;
double botPassiveEarnings = Σ(botYields * timeElapsed);
```

### Balance Considerations
- **Tap vs Idle**: Manual tapping should be profitable early, bots dominate later
- **Upgrade Costs**: Exponential scaling to maintain progression challenge
- **Prestige Timing**: Players should prestige every 2-3 hours of active play

## 🏆 Achievement System

### Achievement Categories

#### Trading Milestones
- **First Win**: Complete your first successful trade
- **Hot Streak**: Win 10 trades in a row
- **Big Winner**: Earn 10,000 coins in a single trade
- **Millionaire**: Accumulate 1 million total coins

#### Bot Achievements
- **First Employee**: Hire your first trading bot
- **Bot Army**: Own 5 different bot types
- **Bot Master**: Upgrade a bot to maximum level
- **Idle Tycoon**: Earn 100,000 coins while offline

#### Prestige Achievements
- **First Retirement**: Complete your first prestige
- **Serial Retiree**: Prestige 10 times
- **Stark Collector**: Accumulate 100 Stark Tokens
- **Legends**: Reach prestige tier 10

### NFT Rewards
Each major achievement mints an NFT using the `street_art_nft` contract:
- **Visual Design**: Unique casino-themed artwork
- **Blockchain Proof**: Permanent record of accomplishment
- **Social Sharing**: Showcase achievements on social media

## 🌐 Social Features

### Global Leaderboards
- **Net Worth**: Total cash + bot value + upgrade costs
- **XP Ranking**: Highest experience points
- **Prestige Score**: Most Stark Tokens accumulated
- **Daily Trades**: Most active traders

### Daily Events
- **Volatility Surge**: 2x profits for 1 hour
- **Bot Bonus**: Double bot earnings for 30 minutes
- **Lucky Hour**: +50% win rate for limited time
- **Prestige Party**: Extra Stark Tokens for prestige

### Viral Mechanics
- **Share Wins**: Export big win celebrations
- **Invite Friends**: Referral bonuses for new players
- **Clan System**: Team-based competitions
- **Tournament Mode**: Weekly trading competitions

## 📱 Mobile-First Design

### User Experience Principles
- **Instant Gratification**: Immediate feedback for every tap
- **One-Handed Play**: All controls accessible with thumb
- **Portrait Orientation**: Optimized for vertical phone use
- **Gesture Support**: Swipe gestures for navigation

### Performance Requirements
- **60fps Animations**: Smooth slot machine and particle effects
- **<3s Load Time**: Fast app startup and screen transitions
- **Battery Efficient**: Optimized for idle gameplay
- **Offline Capable**: Core game works without internet

## 🔐 Real Trading Integration

### Daily Real Trade Feature
- **Limit**: Maximum 1 real trade per day
- **Amount**: Small position sizes ($1-10)
- **Markets**: Same as simulation (ETH, BTC, AVAX, etc.)
- **Rewards**: Special NFTs for real trade milestones

### Safety Measures
- **Confirmation Gates**: Multiple confirmation steps
- **Amount Limits**: Prevent large position sizes
- **Error Handling**: Comprehensive failure recovery
- **Educational**: Clear explanation of real trading risks

## 🎯 Engagement Metrics

### Target KPIs
- **Session Duration**: 5+ minutes average
- **Retention**: 50% Day 1, 20% Day 7, 10% Day 30
- **Progression**: 80% reach first bot unlock
- **Monetization**: 5% try real trading feature

### Optimization Strategies
- **A/B Testing**: Different upgrade costs and progression rates
- **Behavioral Analytics**: Track player decision patterns
- **Balance Updates**: Regular adjustments based on player data
- **Content Updates**: New bot types and upgrade options

## 🔗 Cross-References

For implementation details:
- **[ARCHITECTURE.md](ARCHITECTURE.md)** - Technical system design
- **[TODO.md](TODO.md)** - Development tasks and priorities
- **[PROJECT_STATUS.md](PROJECT_STATUS.md)** - Current development status
- **[project-rules/docs/KNOWLEDGE_BASE.md](../project-rules/docs/KNOWLEDGE_BASE.md)** - Game mechanics formulas

---

**Game Design Version**: 1.0  
**Last Updated**: 2025-01-10  
**Status**: Complete game design ready for implementation  
**Next Phase**: Begin Phase 1 development