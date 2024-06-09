import 'package:flutter/material.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/gen/fonts.gen.dart';
import 'package:haathbarhao_mobile/models/notification_model.dart' as n;
import 'package:haathbarhao_mobile/screens/notifications/widgets/notification_card.dart';

class NotificationCategory extends StatelessWidget {
  final String title;
  final List<n.Notification> notifications;

  const NotificationCategory({
    required this.title,
    required this.notifications,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontFamily: FontFamily.clashDisplay,
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: ColorName.black,
          ),
        ),
        const SizedBox(height: 8),
        ...notifications.map(
          (notification) => NotificationCard(
            notification: notification,
          ),
        ),
      ],
    );
  }
}
