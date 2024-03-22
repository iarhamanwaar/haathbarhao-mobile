import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../screens/authentication/screens/get_started_view.dart';
import '../screens/authentication/screens/login_view.dart';
import '../screens/home/job_detail_view.dart';
import '../screens/main_view.dart';
import '../screens/profile/profile_view.dart';

enum AppRoute { main, register, login, jobDetailView, profile }

const Map<AppRoute, String> routeMap = {
  AppRoute.main: '/',
  AppRoute.register: 'register',
  AppRoute.login: 'login',
  AppRoute.jobDetailView: 'jobDetailView',
  AppRoute.profile: 'profile',
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

            // Login View
            GoRoute(
              path: routeMap[AppRoute.login]!,
              name: AppRoute.login.name,
              builder: (context, state) => const LoginView(),
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
              builder: (context, state) => const ProfileView(),
            ),
          ],
        ),
      ],
    );

    return router;
  },
);
