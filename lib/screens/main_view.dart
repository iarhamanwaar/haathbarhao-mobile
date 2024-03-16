import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/screens/authentication/landing_view.dart';
import 'package:haathbarhao_mobile/screens/home_view.dart';
import '../providers/token_provider.dart';

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
      return const HomeView();
    } else {
      return const LandingView();
    }
  }
}
