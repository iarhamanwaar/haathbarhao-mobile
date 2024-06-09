import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/models/user_model.dart';
import 'package:haathbarhao_mobile/providers/user_repo_provider.dart';
import 'package:haathbarhao_mobile/services/fcm_config.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return UserNotifier(
    userRepository: userRepository,
  );
});

class UserNotifier extends StateNotifier<UserState> {
  final UserRepository userRepository;

  UserNotifier({
    required this.userRepository,
  }) : super(const UserState()) {
    onLoad();
  }

  void setUser(User value) {
    state = state.copyWith(
      user: value,
    );
  }

  void setLoading(bool value) {
    state = state.copyWith(
      isLoading: value,
    );
  }

  Future<void> onLoad() async {
    setLoading(true);
    try {
      final user = await userRepository.getUser();
      setUser(user);
      if (user.fcmToken == null) {
        String? token = await FCMConfig.getFCMToken();
        await userRepository.patchUser(
          fcmToken: token,
        );
      }
      setLoading(false);
    } catch (e, s) {
      setLoading(false);
      log(
        "Unable to fetch user data: ",
        error: e,
        stackTrace: s,
      );
    }
  }
}

class UserState {
  final User? user;
  final bool isLoading;

  const UserState({
    this.user,
    this.isLoading = false,
  });

  UserState copyWith({
    User? user,
    bool? isLoading,
  }) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
