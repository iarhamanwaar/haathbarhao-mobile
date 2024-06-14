import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:haathbarhao_mobile/screens/authentication/screens/get_started_view.dart';
import 'package:haathbarhao_mobile/screens/authentication/screens/login_view.dart';
import 'package:haathbarhao_mobile/screens/authentication/screens/otp_view.dart';
import 'package:haathbarhao_mobile/screens/chat/chat_page.dart';
import 'package:haathbarhao_mobile/screens/doer_flow/become_helper/become_helper_view.dart';
import 'package:haathbarhao_mobile/screens/doer_flow/doer_home/job_detail_view.dart';
import 'package:haathbarhao_mobile/screens/main_view.dart';
import 'package:haathbarhao_mobile/screens/notifications/views/notification_view.dart';
import 'package:haathbarhao_mobile/screens/seeker_flow/post_job/views/match_found_view.dart';
import 'package:haathbarhao_mobile/screens/seeker_flow/post_job/views/post_job_view.dart';
import 'package:haathbarhao_mobile/screens/seeker_flow/profile/profile_view.dart';

enum AppRoute {
  main,
  register,
  otp,
  login,
  jobDetailView,
  profile,
  postJobView,
  matchFoundView,
  becomeAHelper,
  notificationView,
  chatPage,
  notificationView,
  hireView,
}

const Map<AppRoute, String> routeMap = {
  AppRoute.main: '/',
  AppRoute.register: 'register',
  AppRoute.otp: 'otp',
  AppRoute.login: 'login',
  AppRoute.jobDetailView: 'jobDetailView',
  AppRoute.profile: 'profile',
  AppRoute.postJobView: 'postJobView',
  AppRoute.matchFoundView: 'matchFoundView/:id',
  AppRoute.becomeAHelper: 'becomeAHelper',
  AppRoute.notificationView: 'notificationView',
  AppRoute.hireView: 'hireView',
  AppRoute.notificationView: 'notificationView',
  AppRoute.chatPage: 'chatPage',
};

final goRouterProvider = StateProvider<GoRouter>(
  (ref) {
    final router = GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      routes: [
        // Main View
        GoRoute(
          path: routeMap[AppRoute.main]!,
          name: AppRoute.main.name,
          builder: (context, state) => const MainView(),
          routes: [
            // Register View
            GoRoute(
              path: routeMap[AppRoute.register]!,
              name: AppRoute.register.name,
              builder: (context, state) => const GetStartedView(),
            ),
            GoRoute(
              path: routeMap[AppRoute.chatPage]!,
              name: AppRoute.chatPage.name,
              builder: (context, state) => const ChatPage(),
            ),

            // Register View
            GoRoute(
              path: routeMap[AppRoute.otp]!,
              name: AppRoute.otp.name,
              builder: (context, state) {
                return OtpView(
                  key: state.pageKey,
                );
              },
            ),

            // Login View
            GoRoute(
              path: routeMap[AppRoute.login]!,
              name: AppRoute.login.name,
              builder: (context, state) => const LoginView(),
            ),

            // Post Job View
            GoRoute(
              path: routeMap[AppRoute.postJobView]!,
              name: AppRoute.postJobView.name,
              builder: (context, state) {
                // final image = state.uri.queryParameters['image'];
                // final title = state.uri.queryParameters['title'];
                // final description = state.uri.queryParameters['description'];
                // final category = state.uri.queryParameters['category'];

                return const PostJobView(
                    // image: image,
                    // title: title,
                    // description: description,
                    // category: category,
                    );
              },
            ),

            // Match Found View
            GoRoute(
              path: routeMap[AppRoute.matchFoundView]!,
              name: AppRoute.matchFoundView.name,
              builder: (context, state) {
                final id = state.pathParameters["id"] ?? '';
                return MatchFoundView(
                  id: id,
                );
              },
              routes: [
                // Match Found View
                // GoRoute(
                //   path: routeMap[AppRoute.hireView]!,
                //   name: AppRoute.hireView.name,
                //   builder: (context, state) {
                //     final match = state.extra as MatchModel;
                //     return const HireView();
                //   },
                // ),
              ],
            ),

            // Notification View
            GoRoute(
              path: routeMap[AppRoute.notificationView]!,
              name: AppRoute.notificationView.name,
              builder: (context, state) {
                return const NotificationView();
              },
            ),

            // Job Detail View
            GoRoute(
              path: routeMap[AppRoute.jobDetailView]!,
              name: AppRoute.jobDetailView.name,
              builder: (context, state) {
                final index = int.parse(state.uri.queryParameters['index']!);

                return JobDetailView(
                  index: index,
                );
              },
            ),

            // Profile View
            GoRoute(
              path: routeMap[AppRoute.profile]!,
              name: AppRoute.profile.name,
              builder: (context, state) => const SeekerProfileView(),
            ),

            // Become a helper
            GoRoute(
              path: routeMap[AppRoute.becomeAHelper]!,
              name: AppRoute.becomeAHelper.name,
              builder: (context, state) {
                final index =
                    int.parse(state.uri.queryParameters['index'] ?? '0');
                return BecomeHelperView(
                  index: index,
                );
              },
            ),
          ],
        ),
      ],
    );

    return router;
  },
);
