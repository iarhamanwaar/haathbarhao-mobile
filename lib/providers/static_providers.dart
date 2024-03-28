import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferenceProvider = FutureProvider(
  (ref) async => SharedPreferences.getInstance(),
);

final seekerBottomNavBarSelectedIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final seekerOverviewTabSelectedIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final doerBottomNavBarSelectedIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final loadingProvider = StateProvider<bool>((ref) => false);
