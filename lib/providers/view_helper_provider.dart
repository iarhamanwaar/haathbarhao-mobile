import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/providers/static_providers.dart';

final viewHelperProvider = StateNotifierProvider<ViewHelperProvider, bool>(
  (ref) => ViewHelperProvider(ref)..initialize(),
);

class ViewHelperProvider extends StateNotifier<bool> {
  ViewHelperProvider(this.ref) : super(false);

  final Ref ref;

  Future<void> initialize() async {
    final sharedPreference = await ref.read(sharedPreferenceProvider.future);
    state = (sharedPreference.getBool('viewHelper') ?? false);
  }

  Future<void> setStatus(bool status) async {
    final sharedPreference = await ref.read(sharedPreferenceProvider.future);
    sharedPreference.setBool('viewHelper', status);
    state = status;
  }
}
