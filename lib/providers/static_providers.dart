import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferenceProvider = FutureProvider(
  (ref) async => SharedPreferences.getInstance(),
);

final kBottomNavBarIndexProvider = StateProvider<int>((ref) {
  return 0;
});
