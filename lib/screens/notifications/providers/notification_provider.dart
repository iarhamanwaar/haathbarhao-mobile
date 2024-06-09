import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/models/notification_model.dart';
import 'package:haathbarhao_mobile/providers/notification_repo_provider.dart';
import 'package:haathbarhao_mobile/providers/user_provider.dart';

final notificationProvider =
    StateNotifierProvider.autoDispose<NotificationNotifier, NotificationState>(
        (ref) {
  final notificationRepository = ref.read(notificationRepositoryProvider);
  return NotificationNotifier(
    notificationRepository,
    ref,
  );
});

class NotificationNotifier extends StateNotifier<NotificationState> {
  final NotificationRepository notificationRepository;
  final Ref ref;

  NotificationNotifier(
    this.notificationRepository,
    this.ref,
  ) : super(const NotificationState()) {
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    state = state.copyWith(isLoading: true);
    try {
      final userId = ref.read(userProvider).user!.id!;
      final notifications = await notificationRepository.getNotifications(
        userId: userId,
      );
      state = state.copyWith(
        isLoading: false,
        notifications: notifications,
      );
    } catch (e) {
      log(e.toString());
      state = state.copyWith(isLoading: false);
    }
  }
}

class NotificationState {
  final bool isLoading;
  final List<Notification> notifications;

  const NotificationState({
    this.isLoading = false,
    this.notifications = const [],
  });

  NotificationState copyWith({
    bool? isLoading,
    List<Notification>? notifications,
  }) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      notifications: notifications ?? this.notifications,
    );
  }
}
