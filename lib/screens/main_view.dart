import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/providers/view_helper_provider.dart';
import 'package:haathbarhao_mobile/screens/doer_flow/doer_bottom_nav_bar.dart';
import 'package:haathbarhao_mobile/screens/seeker_flow/seeker_bottom_nav_bar.dart';
import 'package:haathbarhao_mobile/providers/token_provider.dart';
import 'package:haathbarhao_mobile/screens/authentication/screens/landing_view.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    final token = ref.watch(tokenProvider);

    if (token != '') {
      final viewHelper = ref.watch(viewHelperProvider);

      if (!viewHelper) {
        return const SeekerBottomNavBar();
      } else {
        return const DoerBottomNavBar();
      }
    } else {
      return const LandingView();
    }
  }
}
