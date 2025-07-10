“**Perp Tycoon** – An Idle Trading Casino”

### *A Mobile Incremental Game Where Leveraged Trades Are Your Slot Machines*

---

## 🔁 Core Loop (Incremental Logic Applied to Trading)

| Idle Game Element        | Perp Tycoon Equivalent                                                            |
| ------------------------ | --------------------------------------------------------------------------------- |
| **Tap to earn**          | Tap = open a mock trade (simulates flipping a high-risk coin: long/short)         |
| **Upgrade to earn more** | Buy better “Trading Tools” (faster execution, more leverage, higher profit range) |
| **Automate earnings**    | Hire “Trade Bots” (do auto-mock-trades while idle)                                |
| **Prestige / Reset**     | “Retire Rich” to earn **Stark Tokens** (a prestige currency)                      |
| **Resource sinks**       | Unlock markets, pay to upgrade bots, re-skin your casino floor                    |

---

## 🎮 Gameplay Mapping: Turning Perps into Idle Mechanics

### 🪙 1. Manual Trades → Coin Tosses (Tap Phase)

* Each **tap** opens a **mock trade** (e.g., long/short BTC) using real market volatility to simulate a result (profit/loss).
* Profits = **cash** added to your vault.
* "Misses" (bad trades) still add XP, building toward bot unlocks.

**Visuals:** Each tap launches a “trader avatar” into a mini slot machine. If the PnL is green, cash showers down.

---

### 🛠️ 2. Upgrade System

* Spend cash to:

  * Unlock new markets (ETH, STRK, MEME)
  * Increase trade size multiplier (simulate higher leverage)
  * Improve win probability (based on mock AI indicators)
  * Boost rewards on wins (e.g., combo wins = critical hits)

**Example Upgrades:**

* “Quantum Charts” – Increase profit range by +10%
* “Flash Execution” – +1 tap/sec on bots
* “Market Intel Feed” – +3% edge to win chance

---

### 🤖 3. Automation – “Trader Bots”

* Buy idle **Trade Bots** that simulate trades while you're away.
* Each bot specializes (e.g., ETH-only, short-only, meme-coins only).
* Bot yield is based on how “risky” their market is (more volatile assets = higher returns, but more variance).

**Idle Logic Example:**

```plaintext
ETH Bot: Trades once every 5 sec. Each trade yields 10-20 cash. Can be upgraded to trade faster or smarter.
```

---

### 📉 4. Market Simulation Logic

* Behind the scenes, use **real-time or mock market data** to simulate price movement and determine trade outcomes.
* Tie volatility into potential profit:

  * High vol = bigger win/loss swings
  * Lower vol = consistent small returns

**Optional Twist:** Let players toggle “risk level” — choosing between safe/stable coins or volatile ones (e.g., RLB, STRK), mimicking diversification.

---

### 🏆 5. Prestige Layer – “Wall Street Ascension”

* Once you hit, say, 1M in-game dollars, you can **Prestige**:

  * Reset progress
  * Earn “Stark Tokens” (on-chain NFTs maybe)
  * Stark Tokens boost passive income, unlock cosmetic changes, new market sectors, special bots.

**Example Perk:**

* “BlackRock Blessing” — All bots trade 25% faster
* “Alpha Edge” — 10% bonus on every win

---

## 🪄 Visual/Emotional Hook

Make it feel like a casino meets Bloomberg terminal — **bright lights, slot machine reels, finance memes** everywhere. Think:

* **Idle Casino UI**: Traders lined up at trade slots
* “Pump Parties” every hour (burst of global volatility = high risk/high reward window)
* Discord-style chat feed running in the background ("BTC just rugpulled!", "Whale dumped ETH!")

---

## 📲 Starknet Integration

Even though this is *mostly* a simulation game, you can tie it to real trades and NFTs:

### Real Trades

* One real trade per day: The player can make one **actual trade** via Starknet's Extended API (gas sponsored by Paymaster).
* Successful real trades can reward unique NFTs (Trade Tickets, Drip Gear).

### On-Chain Assets

* Prestige rewards = NFT-backed cosmetics
* Top players on leaderboard earn **Starknet-native "Idle Vaults"** (earning % of global idle income, like yield farms)

---

## 👷‍♂️ v0 Scope for Starknet Bounty

| Component          | v0 Implementation                                                      |
| ------------------ | ---------------------------------------------------------------------- |
| Manual Trade Loop  | Tap button → resolves mock trade → returns PnL → adds to money counter |
| Upgrade Shop       | Buy mock upgrades (stored in local state); update earnings multipliers |
| Idle Bots          | UI for buying bots, bots simulate earnings per second                  |
| One real trade     | Integrate Extended API for single trade/day                            |
| Onboarding         | Instant tap-to-play with confetti, visual PnL feedback                 |
| Wallet & Paymaster | Automatic Argent/X integrated wallet + gasless trade setup             |
| Optional           | Mint 1 NFT as reward for real trade ("1st Casino Chip")                |

---

## 🧠 Why This Wins Over Mars Mission

| Mars Mission 🚀                            | Perp Tycoon 🎰                              |
| ------------------------------------------ | ------------------------------------------- |
| Requires reading story / building metaphor | Instant tap-to-win, no onboarding friction  |
| PnL converted to abstract “materials”      | PnL = money. Simple. Satisfying.            |
| Complex 3D hangar UI                       | Big buttons, slot machines, dollar signs    |
| Progression gated behind crafting          | Idle bots + upgrades = faster dopamine loop |
| High cognitive load                        | Pure “numbers go up” bliss                  |

---

## 🔚 TL;DR

**Gamblers Table**’s core loop — earn, automate, prestige — **maps perfectly onto a mobile idle perps game**.
With a rebrand to **Perp Tycoon**, the player becomes a high-rolling, bot-deploying, chart-hacking casino mogul — tapping to get rich while secretly learning market dynamics through osmosis.

This version:

* Hooks users in seconds
* Feeds the "idle economy" addiction loop
* Still leverages Starknet tech (Paymasters, NFTs, real trades)
* Feels viral, satisfying, and built for retention


**Project Lead:** [Your Name/Team Lead]
**Date:** July 10, 2025

---

## 1. Introduction: The Addiction Economy of Perpetual Futures

The future of trading isn't about complex charts; it's about instant gratification, status, and dopamine. "Perp Tycoon" transforms the high-stakes world of leveraged perpetuals into an irresistible mobile idle game, designed to capture the "TikTok generation" with its blend of casino thrill and incremental strategy.

Our goal is not just another DeFi app with confetti. We deliver a fast, fun, and intuitive experience where every "trade" is a strategic gamble, every upgrade fuels your empire, and every gain reinforces your status as a "Perp Tycoon."

**Core Vision Alignment with StarkWare Bounty:**

* **Gamified Mobile App:** A true game, deeply integrating trading mechanics.
* **Accessible to Everyone:** Intuitive UI removes trading complexity.
* **Fast, Fun, Intuitive:** Instant feedback, haptics, vibrant visuals.
* **Sustainable Business:** Proven idle game loops drive retention and engagement.
* **Blockchain-Powered:** Seamless Starknet integration for real trades, NFTs, and gasless experiences.

## 2. Core Game Loop: The Incremental Thrill

The essence of "Perp Tycoon" is simple: **Earn, Automate, Prestige.**

| Idle Game Element    | Perp Tycoon Equivalent                                                                        | Core UX Impact                                              |
| :------------------- | :-------------------------------------------------------------------------------------------- | :---------------------------------------------------------- |
| **Tap to earn** | **Manual Trades (Coin Tosses):** Tap a button to open a mock long/short trade.                | Instant PnL pop-ups, coin showers, haptic pulses.           |
| **Upgrade to earn more** | **Trading Tools:** Purchase upgrades (e.g., "Quantum Charts," "Flash Execution").           | Immediate visual impact on game elements.                   |
| **Automate earnings**| **Trader Bots:** Hire automated bots to perform mock trades while idle.                       | Background animations of bots, cumulative idle earnings.    |
| **Prestige / Reset** | **Retire Rich / Wall Street Ascension:** Reset progress for "Stark Tokens" (prestige NFTs). | Dramatic visual reset, new perks, enhanced cosmetics.       |
| **Resource sinks** | Unlock new markets, customize casino floor, upgrade bot "skins."                            | Visual progression of user's "casino" and collection.       |

## 3. The User Journey & Screen-by-Screen Design

Our design philosophy prioritizes simplicity, instant feedback, and a vibrant, cyberpunk-casino aesthetic. Charts are minimal; the focus is on action, reaction, and rewards.

---

### **3.1. Onboarding: The First Rush (The "Free Play" Tutorial)**

* **Narrative:** A neon-lit welcome to the underground world of perps. No jargon, just pure, unadulterated "betting" fun.
* **Flow:**
    1.  **Splash Screen:** "PERP TYCOON" in shimmering neon, leading to a simple "ENTER CASINO" button.
    2.  **Guided Tutorial:** A friendly, stylized "Casino Manager" bot guides the user. "Tap here, Tycoon! Your first coin toss is on the house!"
    3.  **First Mock Trade:** User taps a large, pulsing "LONG / SHORT" button. Instant, exaggerated animation of a rapidly spinning coin or mini-slot reel.
    4.  **Explosive PnL Feedback:** On resolution, a huge `+$XX` (green) or `-$XX` (red) number bursts across the screen with a shower of coins (for profit) or a glitch effect (for loss).
    5.  **First XP Pop-up:** An "XP Gained! +10 XP" notification floats up with a satisfying sound.
    6.  **First NFT Earned:** "Achievement Unlocked! Your First Casino Chip NFT!" with a vibrant pop-up, adding to a virtual collection.
* **UI/UX:**
    * **Reduced Complexity:** Only one action button visible.
    * **Instant Feedback:** Visual (explosions, coin showers), Haptic (strong vibrations on PnL, gentle on XP), Auditory (cash registers, slot machine sounds, XP chime).
    * **No Clutter:** No complex charts, just the direct action.
    * **Gamified Tutorial:** Feels like playing, not learning.
* **Native Feature Hooks:** Initial haptic feedback, splash screen animation.

---

### **3.2. The Trading Floor: Your High-Stakes Arcade (Main Game Screen)**

* **Narrative:** The beating heart of your idle empire. A vibrant, animated casino floor where your wealth is made.
* **Key Sections (Minimalist, Tab-based Navigation):**
    * **Central Trading Panel (Focus):**
        * **"Coin Toss" / "Perp Slot Machine":** Dominant visual. A large, stylized crypto coin (e.g., ETH logo) or slot machine panel.
        * **Action Buttons:** Large, distinct "LONG" (Up Arrow, Green) and "SHORT" (Down Arrow, Red) buttons. These are the primary tap targets for manual trades.
        * **Live PnL Display:** Immediately below the action buttons, a dynamic PnL counter that updates (mock) instantly after each manual trade.
    * **Header Bar (Top):**
        * **Your Vault Balance:** (e.g., `$12,345.67`) – large, constantly updating, with subtle animations on change.
        * **XP Bar / Current Level:** A thin, glowing bar that fills up. "LVL 12" badge. Bursts on level-up.
        * **Starknet Connection Status:** A small, subtle icon (e.g., a glowing `⚡` for connected, dim for disconnected). Tap for wallet address.
    * **Bot Activity Feed (Subtle Ticker):** A small, scrolling feed at the bottom or side showing `[ETH Bot]: +$12.45`, `[Meme Bot]: -$5.00`.
* **UI/UX:**
    * **Dynamic Visuals:** Subtle background animations of data flowing, neon lights pulsing.
    * **Instant Feedback:** Every "tap" trade triggers the slot machine animation, direct PnL flash, coin shower/glitch, and XP pop-up.
    * **Haptics:** Precise haptic feedback for successful trades, strong vibration for significant PnL, subtle for background activities.
    * **No Clutter:** Charts are intentionally absent from the main view. The game *is* the chart.

---

### **3.3. The Upgrade Den: Hack Your Edge (Upgrade Screen)**

* **Narrative:** Invest in your empire. These aren't just upgrades; they're your secret weapons to dominate the market.
* **UI:**
    * **Categorized Tabs:** "Markets" (unlock ETH, STRK, MEME), "Tools" (faster execution, higher PnL multipliers), "AI Enhancements" (win probability).
    * **Visual Icons:** Each upgrade has a distinct, cyberpunk-themed icon.
    * **Clear Value Proposition:** "Quantum Charts (+10% Profit Range)," "Flash Execution (+1 tap/sec on bots)."
    * **Cost & Buy Button:** Prominent price display and a satisfying "BUY" button.
* **UX:** Satisfying visual effect and haptic feedback on purchase, with immediate update to relevant multipliers on the Trading Floor.

---

### **3.4. The Bot Factory: Your Automated Army (Automation Screen)**

* **Narrative:** Deploy your legion of tireless traders. Watch them mint money while you're offline.
* **UI:**
    * **Bot Roster:** List of owned "Trader Bots." Each bot has a unique visual avatar (e.g., sleek ETH bot, chaotic MEME bot).
    * **Bot Stats:** Displays their current operating market, speed, average yield per second, and last trade result.
    * **"Hire Bot" Section:** Showcase new bots available for purchase.
    * **Idle Earnings Counter:** A prominent display of "Total Idle Earnings Since Last Login: +$X."
* **UX:** Bots visually trade in the background. On returning to the app after being idle, a dramatic "Welcome Back, Tycoon! Your Bots Earned You $X!" animation.
* **Native Feature Hooks:** Push notifications for "Your Bots are waiting to be collected!" or "Market Surge! Your bots are on fire!"

---

### **3.5. The Vault & Trophy Room: Your Empire’s Legacy (Collection/Profile Screen)**

* **Narrative:** This is your personal high-roller suite. Display your accumulated wealth and badges of honor.
* **UI:**
    * **Total Vault Value:** Prominent display.
    * **NFT Gallery:** Grid display of earned "Trade Tickets" (NFTs from real trades), "Casino Chips" (NFTs from achievements), "Drip Gear" (cosmetic NFTs). Each NFT can be tapped for details.
    * **"Idle Vault" Visualization:** Your personal "casino floor" or "trading tower" visually grows and changes based on total earnings and prestige level. More upgrades = more intricate and impressive visuals.
    * **Share Button:** A clear, meme-friendly share button (e.g., a "Flex My Empire!" or "Screenshot This!" button) to export a stylized image of their Vault/NFTs/Leaderboard rank.
* **UX:** Interactive NFT viewing, smooth transitions to see the evolving "Idle Vault."
* **Native Feature Hooks:** Share sheet integration for social media.

---

### **3.6. The High Stakes Leaderboard: Prove Your Dominance (Social/Leaderboard Screen)**

* **Narrative:** See where you stand among the Tycoons. Fuel your competitive fire.
* **UI:**
    * **Global Leaderboard:** Rankings by Net Worth, Total XP, or "Alpha Score" (risk-adjusted PnL).
    * **Friend Leaderboard:** Connect with friends (via social logins or direct invites) to compare.
    * **Clans/Alliances:** Section for joining or creating trading groups, potentially with shared goals or competitive battles.
    * **Your Rank:** Clearly highlights the user's position.
* **UX:** Highly visible, frequently updated. "Bragging Rights" button next to your rank for easy social sharing.
* **Native Feature Hooks:** Inviting friends via contact list integration, push notifications for "A new Tycoon has surpassed you!" or "Your Clan is under attack!"

---

## 4. Key UI/UX Principles Applied

* **Snapchat/BeReal Simplicity:**
    * **Large Touch Targets:** Every button is easy to tap on a mobile screen.
    * **Visual-First:** Information conveyed primarily through animation, color, and iconography, not dense text.
    * **Minimalist Controls:** Navigation is streamlined, actions are direct.
    * **Instantaneity:** No loading screens for mock trades. Results are instantaneous.
* **Instant Gratification & Dopamine Loops:**
    * **XP Pop-ups:** Immediate visual and haptic feedback for every gain.
    * **Coin Showers/Effects:** Direct visual reward for successful trades.
    * **Sound Design:** Cash register ding, slot machine spin, satisfying "thunk" for automation.
    * **Streak-Based XP/Rewards:** Daily logins, consecutive profitable trades are rewarded.
* **Haptic Feedback Engine (iOS/Android Native):**
    * **Tactile Confirmation:** Subtle haptics for button presses.
    * **Emotional Reinforcement:** Strong, distinct haptics for major events (profitable trade, level-up, NFT mint).
    * **Urgency:** Pulsing haptics for low battery on bots or impending streak breaks.
* **Native iOS/Android Features:**
    * **Push Notifications:** "Your bots earned you $X while you were away!", "Your trading streak is at risk!", "New market unlocked!"
    * **Lock Screen Widgets:** Quick view of total vault balance, XP, or last trade result.
    * **Home Screen Shortcuts:** Direct access to "Trade Now" or "Collect Idle Cash."
    * **Haptic Feedback:** Fully utilized as detailed above.
* **Visual Flair & Emotional Hook:**
    * **Cyberpunk-Casino Aesthetic:** Dominant dark backgrounds, neon accents (cyan, magenta, electric green/red). Futuristic fonts.
    * **Dynamic Backgrounds:** Subtle animations of data streams, moving cityscapes, or abstract energy flows.
    * **Finance Memes:** Subtle, tasteful nods to crypto culture in visuals or ambient chat feed.

## 5. Conclusion: A Viral Gateway to Perps

"Perp Tycoon" is more than a game; it's a strategically designed funnel to onboard the next generation into the world of decentralized perpetuals. By abstracting complexity into addictive game mechanics, we offer:

* **Unrivaled Engagement:** Leveraging proven idle game loops for daily retention.
* **Effortless Onboarding:** Free-play mode and intuitive UI break down barriers.
* **Viral Potential:** Social features and shareable achievements encourage organic growth.
* **Real-World Integration:** Seamlessly ties mock gameplay to actual Starknet transactions, gasless experiences, and NFT ownership.

Our robust backend, fully outlined in the accompanying documentation, stands ready to power this vision. We acknowledge the current external CloudFront configuration hurdle, which is the only remaining blocker to demonstrating the live "one real trade" functionality. We are confident that with collaboration, "Perp Tycoon" will be the groundbreaking, mass-adopted application StarkWare is seeking.

---