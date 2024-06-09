import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/gen/fonts.gen.dart';
import 'package:haathbarhao_mobile/screens/notifications/providers/notification_provider.dart';
import 'package:haathbarhao_mobile/screens/notifications/views/notification_category.dart';

class NotificationView extends ConsumerWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationProvider);

    return Scaffold(
      backgroundColor: ColorName.white,
      appBar: AppBar(
        backgroundColor: ColorName.white,
        elevation: 0,
        leadingWidth: 10,
        leading: const SizedBox.shrink(),
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontFamily: FontFamily.clashDisplay,
            fontWeight: FontWeight.w600,
            fontSize: 32,
            color: ColorName.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: context.pop,
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.close,
                color: ColorName.black,
                size: 35,
              ),
            ),
          ),
        ],
        centerTitle: false,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: state.notifications.isNotEmpty
                  ? Column(
                      children: [
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView(
                            children: [
                              NotificationCategory(
                                title: 'New job posted',
                                notifications: state.notifications
                                    .where(
                                        (n) => n.category == 'New job posted')
                                    .toList(),
                              ),
                              NotificationCategory(
                                title: 'Job updates',
                                notifications: state.notifications
                                    .where((n) => n.category == 'Job updates')
                                    .toList(),
                              ),
                              NotificationCategory(
                                title: 'Recent activity',
                                notifications: state.notifications
                                    .where(
                                        (n) => n.category == 'Recent activity')
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          'No notifications yet. Engage in more stuff to start receiving notifications.',
                          style: TextStyle(
                            fontFamily: FontFamily.clashDisplay,
                          ),
                        ),
                      ),
                    ),
            ),
    );
  }
}
