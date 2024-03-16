import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/providers/static_providers.dart';

final tokenProvider = StateNotifierProvider<TokenProvider, String>(
  (ref) => TokenProvider(ref)..initialize(),
);

class TokenProvider extends StateNotifier<String> {
  TokenProvider(this.ref) : super('');

  final Ref ref;

  Future<void> initialize() async {
    final sharedPreference = await ref.read(sharedPreferenceProvider.future);
    state = (sharedPreference.getString('token') ?? '');
  }

  Future<void> setToken(String token) async {
    final sharedPreference = await ref.read(sharedPreferenceProvider.future);
    sharedPreference.setString('token', token);
    state = token;
  }
}
