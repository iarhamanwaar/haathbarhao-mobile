import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/screens/home/seeker_home_view.dart';
import 'package:haathbarhao_mobile/screens/overview/overview_view.dart';
import 'package:haathbarhao_mobile/screens/profile/profile_view.dart';
import '../gen/assets.gen.dart';
import '../providers/static_providers.dart';
import '../widgets/nav_bar_item.dart';

final GlobalKey<ScaffoldState> bottomNavBarKey = GlobalKey();

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  final pages = [
    const SeekerHomeView(),
    const OverviewView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavBarSelectedIndex =
        ref.watch(bottomNavBarSelectedIndexProvider);

    return Scaffold(
      key: bottomNavBarKey,
      backgroundColor: const Color(0xFFF5F7FC),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: pages[bottomNavBarSelectedIndex],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavBarItem(
                    currentIndex: bottomNavBarSelectedIndex,
                    index: 0,
                    iconOutlined: Assets.icons.homeOutlined,
                    iconFilled: Assets.icons.homeOutlined,
                    label: 'Home',
                  ),
                  NavBarItem(
                    currentIndex: bottomNavBarSelectedIndex,
                    index: 1,
                    iconOutlined: Assets.icons.overviewOutlined,
                    iconFilled: Assets.icons.overviewOutlined,
                    label: 'Overview',
                  ),
                  NavBarItem(
                    currentIndex: bottomNavBarSelectedIndex,
                    index: 2,
                    iconOutlined: Assets.icons.profileOutlined,
                    iconFilled: Assets.icons.profileOutlined,
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
