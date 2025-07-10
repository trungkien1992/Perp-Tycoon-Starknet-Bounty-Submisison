# Perp Tycoon - Casino Game Design

## 🎮 Game Overview

**Perp Tycoon** is an idle trading casino where you build a crypto empire by turning mock perpetual trades into a satisfying, automated money-making machine, with a daily chance to make a real trade on Starknet. The game fuses the addictive progression of an idle game with the high-stakes thrill of leveraged trading, putting the player in the seat of a casino mogul. The gameplay feels like a Bloomberg terminal collided with a Las Vegas slot machine.

## 🎯 Logline

Perp Tycoon is an idle trading casino where you build a crypto empire by turning mock perpetual trades into a satisfying, automated money-making machine, with a daily chance to make a real trade on Starknet. The game is inspired by the Gamblers Table idle game of Itch.io

## 🎯 Core Game Loop

### The Perp Tycoon Experience
The player's journey follows a classic, highly-retentive incremental loop:

**TOSS (Manual Trade) 🪙 → EARN (Virtual Cash) 💰 → UPGRADE (Boosts & Bots) 🛠️ → AUTOMATE (Idle Income) 🤖 → PRESTIGE (Reset for Perks) 🏆**

### Primary Mechanics
1. **Manual Trading**: The primary action is a single tap on a "TOSS" button. The player chooses to go LONG (Heads) or SHORT (Tails) on a selected asset
2. **Coin Toss Simulation**: Each tap initiates a satisfyingly robust coin toss with dynamic physics and sharp metallic sound effects
3. **Progression Through Value**: Start with Copper Coin, unlock Silver Coin, then Gold Coin - each with higher base profits and richer sound
4. **Earn & Upgrade**: Successful trades earn cash to buy better trading tools and multipliers
5. **Automate**: Hire trading bots that earn money while offline (idle game mechanics)
6. **Prestige**: Reset all progress to earn privilege  NFTs.
7. **Real Integration**: One actual trade per day via Extended Exchange API

## 🎰 The Idle Casino: Core Interaction

### The Digital "Coin Toss Table"
The game's action is centered on a high-end, digital "Coin Toss Table," which serves as the player's main interface.

**Core Interaction**: Every tap initiates a  coin toss. The coin flips dynamically across the table with a tangible sense of weight before landing with a sharp, metallic clash sound. This sensory feedback is designed to make every action feel impactful and make the player feel rich.

### Coin Progression System
- **Copper Coin**: Starting coin with basic profits and simple sound
- **Silver Coin**: Offers higher base profits and richer audio feedback
- **Gold Coin**: High-roller tier with largest virtual profits and deeply resonant "cha-ching" sound

### Main Interface (`casino_floor_screen.dart`)
- TOSS Initiate by tap the coin in the table. Don't need to be huge button. Just a coin in the table. 
- **Coin Toss Animation**: Dynamic coin flip physics with weight and metallic sounds
- **Long/Short Selection**: Choose LONG (Heads) or SHORT (Tails) before each toss
- **XP Bar**: Always visible progress bar showing level advancement
- **Vault Cash**: Real-time cash displa
- **PnL Burst Effects**: Cash showers for wins, glitch effects for losses

### Visual Theme & Audio
- **High-End Casino**: Digital casino floor with premium aesthetics
- **Cyberpunk Casino**: Dark backgrounds with neon lighting
- **Color Scheme**: Electric green/red for PnL, cyan/magenta accents
- **Sound Design**: Metallic coin sounds, cash register dings, explosion effects
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

Players spend their earned virtual cash in the Upgrade Shop to boost earnings potential.

### Upgrade Categories

#### Market Access
- **Unlock ETH**: Access to Ethereum trading (Cost: 2,000 coins)
- **Unlock STRK**: Access to Starknet token trading (Cost: 3,500 coins)
- **Unlock Meme Coins**: Access to various meme coin markets (Cost: 5,000 coins)

#### Trade Power
- **Trade Size Multiplier**: Simulate higher leverage, increasing potential PnL swing (Cost: 2,000 coins)
- **Quantum Charts**: Permanently increases maximum potential profit on winning trades by +10% (Cost: 5,000 coins)
- **Leverage 2x**: Double profit/loss (Cost: 2,000 coins)
- **Leverage 5x**: 5x profit/loss (Cost: 10,000 coins)
- **Leverage 10x**: 10x profit/loss (Cost: 50,000 coins)

#### Efficiency & Automation
- **Flash Execution**: Increases trade speed of automated bots by +1 tap/sec (Cost: 1,500 coins)
- **Market Intel Feed**: Slightly increases base probability of winning trades by +3% (Cost: 7,500 coins)
- **Lightning Speed**: -1s trade time (Cost: 7,500 coins)
- **Instant Trades**: -2s trade time (Cost: 30,000 coins)

#### Cosmetic Upgrades
- **Neon Lights**: Casino floor lighting effects
- **VIP Area**: Exclusive trading section
- **Diamond Buttons**: Premium tap button appearance

## 🔄 Prestige System: Wall Street Ascension

### "Retire Rich" Mechanics
This is the "end game" loop that drives long-term retention.

### Prestige Triggers
- **Cash Milestone**: Accumulate $1,000,000 in virtual cash
- **XP Milestone**: Reach level 50
- **Achievement Combo**: Complete 10 different achievements

### On-Chain NFTs
Upon reaching a significant milestone, players can choose to "Retire Rich," which resets their virtual cash, upgrades, and bots. In return, they earn on-chain "Stark Tokens" (potentially NFTs) that provide powerful, permanent global boosts:

- **BlackRock Blessing**: All bots trade 25% faster, forever
- **Alpha Edge**: Gain a 10% bonus on every manual trade win, forever
- **Prestige Tier 1**: 1 Stark Token → +10% all earnings permanently
- **Prestige Tier 2**: 5 Stark Tokens → +25% all earnings permanently
- **Prestige Tier 3**: 10 Stark Tokens → +50% all earnings permanently

### Reset Mechanics
- **Wiped**: Cash, bots, upgrades return to zero
- **Preserved**: Stark Tokens, achievements, XP milestones
- **Bonus**: Permanent multipliers based on Stark Token count

## 🎲 Trade Simulation Engine

### Coin Toss Mechanics
The outcome—whether the player's bet was correct—is determined by a provably fair, random result, creating a 50/50 chance similar to a real coin flip. The magnitude of the Profit or Loss is then calculated based on the real-time market volatility of the chosen asset.

### Volatility-Based Outcomes
```dart
// Trade outcome calculation
bool isWin = Random().nextDouble() < (baseWinRate + upgradeBonus);
double volatility = getMarketVolatility(selectedMarket);
double pnl = (isWin ? 1 : -1) * volatility * leverageMultiplier;
```

### Market Behavior & Volatility
- **High Volatility**: Results in larger potential wins and losses
- **Low Volatility**: Results in smaller, more consistent outcomes

### Visual & Audio Feedback
- **Win (Profit)**: Screen showers with cash, PnL indicator flashes green, virtual dollars added to vault, satisfying "cha-ching" sound
- **Loss (Miss)**: Even losing trades reward the player with XP, ensuring every tap feels productive
- **Trader Avatar**: Launches at a mini slot machine with reels spinning market symbols (bulls, bears, rockets) before settling on PnL result

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

## 🔐 Starknet Integration: The Web3 Hook

### V0 Implementation (For Bounty)
The initial version focuses on a simple, powerful integration that showcases the potential of Starknet:

| Component | V0 Implementation |
|-----------|-------------------|
| **One Real Trade** | Integrate Starknet Extended API to allow one gasless (via Paymaster) real trade per day. PnL from this trade offers massive virtual cash bonus |
| **Wallet Setup** | Seamless integration with Argent/X or Braavos wallets, triggered automatically on first "real trade" attempt |
| **NFT Reward** | Mint simple "My First Casino Chip" NFT on Starknet as reward for successfully executing first real trade |
| **Onboarding** | Instant tap-to-play. Web3 elements introduced organically when player is ready for first real move |
| **State Management** | All game state (cash, upgrades, bots) managed in local state for v0 to ensure fast, responsive gameplay |

### Future Vision
- **On-Chain Assets**: Prestige rewards and rare cosmetic items for bots/casinos will be NFTs
- **Idle Vaults**: Top players on leaderboard could earn share of global "tax" on all idle income, paid out via Starknet-native yield farm

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
