
## ✅ REFINED LOW-LEVEL IMPLEMENTATION PLAN

### “**StreetCred Clash → Perp Tycoon**”

**Status:** Final iteration based on Claude Plan, Gemini Plan, your codebase structure, and the unified transformation architecture.

---

### ✅ Phase 1: Core Idle Game Loop (Week 1)

#### 🔨 Models – `lib/models/game_models.dart`

✅ Your data models are solid. Just add `fromJson` / `toJson` methods for persistence:

```dart
Map<String, dynamic> toJson() => {
  'id': id,
  'name': name,
  'cost': cost,
  ...
};

factory Upgrade.fromJson(Map<String, dynamic> json) => Upgrade(
  id: json['id'],
  name: json['name'],
  ...
);
```

> ✅ **Why**: This enables save/load without writing a custom mapper. Reuse in `SaveLoadService`.

---

#### 🔌 Providers – `lib/providers/`

* ✅ `game_state_provider.dart` → `StateNotifier<GameState>`

  * Add `addCash()`, `spendCash()`, `addBot()`, `levelUpUpgrade()`, `resetGame()`
  * Add `calculateTotalEPS()` to compute idle earnings

* ✅ `upgrade_provider.dart`

  * Manages available upgrades
  * Exposes `purchaseUpgrade()` which interacts with `game_state_provider`

* ✅ `bot_provider.dart`

  * Manages list of bots
  * On `hireBot()`, spawns a `Timer.periodic()` to simulate idle income

> 💡 Best Practice: Use `riverpod_auto_dispose` for memory-safe periodic earnings streams

* 🔄 Modify `xp_provider.dart`

  * Call `gainXP(pnl.abs())` on manual or bot trades
  * Add level-up triggers at XP milestones

---

#### 🛠 Services

* ✅ `lib/services/save_load_service.dart`

  * Implements local save/load with `sqflite`
  * Auto-saves:

    * Every 30s via `Timer.periodic`
    * On app backgrounding via `WidgetsBindingObserver`

* ✅ `lib/services/game_loop_service.dart`

  * On app startup:

    * Reads `lastUpdated`
    * Computes offline income `= totalEPS * duration`
    * Calls `game_state_provider.addCash(amount)`

---

#### 🎮 Screen – `lib/screens/trading_screen.dart`

* **Top Bar**

  * Vault Balance (cash)
  * XP Bar (linear indicator from `xp_provider`)

* **Center**

  * Large `ElevatedButton` or `GestureDetector`: "Tap to Trade"
  * Tap triggers `mockTrade()`:

    ```dart
    final result = await tapTradeService.executeTapTrade();
    ref.read(gameStateProvider.notifier).addCash(result.pnl);
    ref.read(xpProvider.notifier).gainXP(result.pnl.abs());
    ```
  * Animate PnL: Floating `Text("+$25")` using `AnimatedOpacity + SlideTransition`

* **Bottom**

  * “Bot Activity Feed”: Randomized updates every few seconds (just UI at first)

> 💡 Use `flutter_hooks` for simple animation + state transition

---

### ✅ Phase 2: Upgrades, Bots, Progression (Week 1–2)

#### 🏗 New Screens

* ✅ `upgrade_den_screen.dart`

  * List of `UpgradeCard`s
  * Show cost, level, effect
  * “Buy” button checks if `cash >= cost`

* ✅ `bot_factory_screen.dart`

  * List of bots
  * Show cost, EPS, count
  * “Hire” button triggers bot spawn + idle loop

* ✅ `vault_trophy_room_screen.dart`

  * Show total lifetime cash
  * Grid of mock NFTs
  * Optional: change background based on progress tier

* ✅ `leaderboard_screen.dart`

  * Initially static
  * Later: `FutureProvider` from on-chain contract

#### 🧠 Idle Loop / Persistence

* ✅ `game_loop_service.dart`

  * Calculates offline earnings using `Duration lastSeen → now`

* ✅ `notification_service.dart`

  * Notify after X hours: “Your bots earned \$235 while you were gone!”
  * Use `flutter_local_notifications`

---

### ✅ Phase 3: Blockchain Integration (Week 2–3)

#### 🎯 Real Trade (Extended API)

* Add “**Execute Daily Real Trade**” button on `trading_screen.dart`

* On tap:

  ```dart
  try {
    final success = await extendedTradingService.createOrder(...);
    if (success) await contractService.mintAchievementNFT(...);
  } catch (e) {
    showDialog(...); // “Real trade API is under maintenance…”
  }
  ```

* ✅ Update `docs/REAL_TRADING_STATUS.md` with this logic

#### 📈 On-Chain XP

* In `xp_provider.dart`, when XP crosses milestone:

  ```dart
  if (level % 5 == 0) {
    await contractService.addXPToContract(accountAddress, xp);
  }
  ```

#### 🔁 Prestige System

* “Retire Rich” button on `vault_trophy_room_screen.dart`:

  * On press:

    * Call `mintAchievementNFT(type: 'prestige')`
    * Call `game_state_provider.resetGame()` and increment `prestigeTokens`

#### ⛽ Gasless Integration

* Inside `contract_service.dart` methods:

  * Wrap all `ContractWrite` with `paymasterService.maybeSponsor(...)`

#### 🏆 Leaderboard

* Use `contractService.getLeaderboard()` with `FutureProvider`
* Show XP-based rankings, mock names if offline

---

### ✅ Phase 4: Polish & Presentation (Week 3)

#### 📄 Docs to Update

* `README.md`: Rewrite around “Perp Tycoon”
* `ARCHITECTURE.md`: Add updated game loop diagram (Providers ↔ Services ↔ Screens)
* `PROJECT_STATUS.md`: Mark Clash as legacy, Tycoon as v1
* `REAL_TRADING_STATUS.md`: Document CloudFront blocker & workaround logic

#### 🎥 Demo Video Flow

1. **Opening**: Tap-to-Trade → PnL animation → XP gain
2. **Upgrades**: Buy → Trade again → higher profit
3. **Bots**: Hire → show idle feed
4. **Real Trade**: Trigger → handle CloudFront gracefully → NFT shown in vault
5. **Prestige**: Show condition → trigger → vault resets, prestige token +1
6. **Leaderboard**: Show player ranking

---

### 🔄 Final Touch: Technical Summary

| Area               | Done ✅ | Notes                          |
| ------------------ | ------ | ------------------------------ |
| Idle Loop          | ✅      | Tap, bot, upgrades             |
| Offline Earnings   | ✅      | `game_loop_service`            |
| Local Persistence  | ✅      | `sqflite`, `save_load_service` |
| Starknet Trade     | ✅      | Wrap in try-catch              |
| NFTs (On-Chain)    | ✅      | `mintAchievementNFT()`         |
| Prestige Reset     | ✅      | Resets local + mints NFT       |
| Leaderboard (Real) | ✅      | Contract XP call               |
| Gasless TXs        | ✅      | Use `paymaster_service`        |
| Notifications      | ✅      | Optional, easy lift            |

---
