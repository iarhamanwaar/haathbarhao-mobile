import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/gen/fonts.gen.dart';
import 'package:haathbarhao_mobile/models/notification_model.dart' as n;

class NotificationCard extends StatelessWidget {
  final n.Notification notification;

  const NotificationCard({
    required this.notification,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: notification.imageUrl.isNotEmpty
              ? CircleAvatar(
                  radius: 30,
                  backgroundImage: CachedNetworkImageProvider(
                    notification.imageUrl,
                  ),
                )
              : null,
          title: Text(
            notification.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorName.black,
            ),
          ),
          subtitle: Text(
            notification.subtitle,
            style: const TextStyle(
              color: ColorName.black,
            ),
          ),
          trailing: notification.hasActionButton
              ? ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorName.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    notification.actionText,
                    style: const TextStyle(
                      color: ColorName.white,
                      fontFamily: FontFamily.clashDisplay,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
