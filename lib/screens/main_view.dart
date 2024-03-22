import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/screens/bottom_nav_bar.dart';
import '../providers/token_provider.dart';
import 'authentication/screens/landing_view.dart';

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
      return const BottomNavBar();
    } else {
      return const LandingView();
    }
  }
}
