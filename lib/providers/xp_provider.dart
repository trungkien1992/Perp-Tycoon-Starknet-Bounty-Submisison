import 'package:flutter_riverpod/flutter_riverpod.dart';

class XPNotifier extends StateNotifier<int> {
  XPNotifier() : super(0);

  void gainXP(int amount) {
    state = state + amount;
  }

  void reset() {
    state = 0;
  }
}

final xpProvider = StateNotifierProvider<XPNotifier, int>((ref) {
  return XPNotifier();
});