

### Best Reflection of Your Current Codebase + Claude + Gemini Inputs

---

### 🧱 PHASE 1 – Idle Core Game Loop (Week 1)

#### ✅ Screens & UI (based on `lib/screens/`)

* ✅ `trading_screen.dart` → **casino\_floor\_screen.dart**

  * Replace order forms & charts with:

    * Tap-to-Trade button (or swipe gesture)
    * Slot machine animation (Claude)
    * PnL burst animations, coin rains, “MOON/RUG” outcomes
    * XP bar + vault cash always visible (Gemini)
* ✅ Add:

  * `upgrade_shop_screen.dart`
  * `bot_management_screen.dart`
  * `prestige_screen.dart`
  * `leaderboard_screen.dart`
* ✅ Animations: Use Lottie or `Rive` for slot reels, fire FX, and bot actions.

#### ✅ Providers (based on `lib/providers/`)

* Add the following:

  * `game_state_provider.dart` → tracks XP, cash, Stark Tokens
  * `idle_earnings_provider.dart` → passive cash from bots
  * `upgrade_provider.dart` → trading tools, leverage, visuals
  * `bot_provider.dart` → idle bots, per-market profit rates
  * `prestige_provider.dart` → resets and Stark Token logic
* Modify existing:

  * `xp_provider.dart` → compute XP both locally + optionally sync to `streetcred_xp` Cairo contract.

#### ✅ Game Models (based on `lib/models/`)

* Add:

  * `TradingBot`, `Upgrade`, `PrestigeTier`, `GameState`
* Use `sqflite` (already present in `pubspec.yaml`) for local save/load state (`Gemini` plan)

---

### 🎮 PHASE 2 – Tap Logic, Bots, and Offline Earnings (Week 1-2)

#### ✅ Tap-to-Trade Engine

* Create `tap_trade_service.dart` (Claude)

  * Uses `ExtendedExchangeFormat`’s real-time volatility to simulate win/loss
  * Formula:

    ```dart
    bool isWin = Random().nextDouble() < baseWinRate + upgradeBonus;
    double pnl = (isWin ? 1 : -1) * volatility * multiplier;
    ```

#### ✅ Bots (from Claude + Gemini)

* Create `trading_bot.dart` + `bot_provider.dart`

  * Each bot has:

    * Market type
    * Profit multiplier
    * Trade interval
  * Simulate trades using `Stream.periodic()`

#### ✅ Upgrade System

* Enum: `UpgradeType { WinRate, PnLBoost, Speed, Cosmetic }`
* Store upgrade ownership in SQLite and update multipliers in provider

#### ✅ Game Loop & Offline Calculation

* Create `game_loop_service.dart`:

  * Computes `earnings = Σ(botYields * timeElapsed)`
  * Persists last login time
  * Syncs earnings on app open (idle game style)

---

### ⛓ PHASE 3 – Real Trading + On-Chain Integration (Week 2-3)

#### ✅ Real Daily Trade (Gemini & Claude agree)

* Add "One Real Trade" button
* Use existing:

  * `real_starknet_service.dart` (Claude)
  * `python_trading_service/main.py`
  * `extended_exchange_format.py`
* Connect `ExtendedApiClient.createOrder()` with gasless paymaster logic (already integrated)

#### ✅ Blockchain Features

* **XP Contract Sync**

  * On key milestones (10 wins, 1M cash, 7-day streak): `contractService.addXPToContract()`
* **NFTs from `street_art_nft/`**

  * Mint on:

    * First Real Trade
    * Prestige trigger
    * Profit milestones (e.g., 10x)
* **Prestige Reset**

  * Use Cairo `mint_stark_token()` in `prestige_provider.dart`
  * Locally wipe cash, bots, upgrades → keep Stark Tokens

---

### 🌐 PHASE 4 – Retention, Social, and Presentation (Week 3)

#### ✅ Retention

* Daily Login Bonus = Free bot upgrade
* Hourly Volatility Surges = 2× profits window
* XP streak mechanic

#### ✅ Social

* Global Chat (WebSocket): "BTC just mooned!"
* Leaderboard (from `streetcred_xp` contract): Use `contractService.getLeaderboardFromContract()`
* Share clip after every prestige or jackpot (export via `result_screen.dart`)

#### ✅ Docs & Launch

* Update `README.md`, `PROJECT_STATUS.md`, `TODO.md`
* Record demo video showcasing:

  * Tap loop
  * XP bar movement
  * Real trade execution + NFT mint
* Add `REAL_TRADING_STATUS.md` noting API blockers (CloudFront)

---

## ✅ Summary of Codebase Fit

| Component                 | Status                                     | Action                                                          |
| ------------------------- | ------------------------------------------ | --------------------------------------------------------------- |
| `lib/screens/`            | Exists                                     | Rename, add `upgrade_shop`, `bot_management`, `prestige_screen` |
| `lib/providers/`          | Exists                                     | Add `game_state`, `bot`, `upgrade`, `prestige`                  |
| `lib/services/`           | Exists                                     | Add `tap_trade_service.dart`, `game_loop_service.dart`          |
| `contracts/`              | Exists                                     | Use `streetcred_xp` and `street_art_nft` (already present!)     |
| `python_trading_service/` | Exists                                     | Keep `main.py`, `extended_exchange_format.py`                   |
| `shared/`                 | Exists                                     | Extend `contract_service.dart`, `trading_service.dart`          |
| `pubspec.yaml`            | Has `sqflite`, `riverpod`, `starknet.dart` | No new deps needed                                              |

---

## 🎯 What This Plan Delivers (vs. Claude vs. Gemini)

| Feature                     | Claude | Gemini  | This Plan       |
| --------------------------- | ------ | ------- | --------------- |
| Casino theme                | ✅      | Partial | ✅               |
| Reuses your trading infra   | ✅      | ✅       | ✅               |
| Idle loop (bots + upgrades) | ✅      | ✅       | ✅               |
| Real trade → NFT mint       | ✅      | ✅       | ✅               |
| Offline earnings            | ✅      | ✅       | ✅               |
| Prestige mechanic           | ✅      | ✅       | ✅               |
| Social chat & events        | ✅      | ❌       | ✅               |
| Game-feel first             | ✅      | ✅       | ✅               |
| Codebase match              | 🟡     | 🟡      | ✅ Perfect match |


