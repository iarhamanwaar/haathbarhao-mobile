import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/models/notification_model.dart';
import 'api_provider.dart';

final notificationRepositoryProvider = StateProvider((ref) {
  final apiService = ref.read(apiProvider);
  return NotificationRepository(apiService, ref);
});

class NotificationRepository {
  late APIService apiService;
  final Ref ref;

  NotificationRepository(this.apiService, this.ref);

  Future<List<Notification>> getNotifications({required String userId}) async {
    try {
      final response = await apiService.get(
        endpoint: '/api/notifications/$userId',
      );

      if (response.statusCode == 200) {
        final notifications = (jsonDecode(response.data)['data'] as List)
            .map((notification) => Notification.fromJson(notification))
            .toList();
        return notifications;
      } else {
        log(jsonDecode(response.data)['message']);
        throw jsonDecode(response.data)['message'];
      }
    } catch (e) {
      log(jsonDecode(e.toString()));
      throw jsonDecode(e.toString());
    }
  }

  Future<Notification> createNotification({
    required String userId,
    required String title,
    required String subtitle,
    required String imageUrl,
    required String actionText,
    required String category,
    required bool hasActionButton,
  }) async {
    try {
      final body = jsonEncode({
        "userId": userId,
        "title": title,
        "subtitle": subtitle,
        "imageUrl": imageUrl,
        "actionText": actionText,
        "category": category,
        "hasActionButton": hasActionButton,
      });

      final response = await apiService.post(
        endpoint: '/api/notifications',
        body: body,
      );

      if (response.statusCode == 200) {
        final notification =
            Notification.fromJson(jsonDecode(response.data)['data']);
        return notification;
      } else {
        log(jsonDecode(response.data)['message']);
        throw jsonDecode(response.data)['message'];
      }
    } catch (e) {
      log(jsonDecode(e.toString()));
      throw jsonDecode(e.toString());
    }
  }

  Future<void> sendNotification({
    required String userId,
    required String title,
    required String subtitle,
    required String imageUrl,
    required String actionText,
    required String category,
    required bool hasActionButton,
  }) async {
    try {
      final body = jsonEncode({
        "userId": userId,
        "title": title,
        "subtitle": subtitle,
        "imageUrl": imageUrl,
        "actionText": actionText,
        "category": category,
        "hasActionButton": hasActionButton,
      });

      final response = await apiService.post(
        endpoint: '/api/notifications/send',
        body: body,
      );

      if (response.statusCode != 200) {
        log(jsonDecode(response.data)['message']);
        throw jsonDecode(response.data)['message'];
      }
    } catch (e) {
      log(jsonDecode(e.toString()));
      throw jsonDecode(e.toString());
    }
  }
}
