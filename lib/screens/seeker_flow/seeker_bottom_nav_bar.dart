import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/screens/seeker_flow/overview/overview_view.dart';
import 'package:haathbarhao_mobile/screens/seeker_flow/profile/profile_view.dart';
import 'package:haathbarhao_mobile/screens/seeker_flow/seeker_home_view.dart';
import 'package:haathbarhao_mobile/gen/assets.gen.dart';
import 'package:haathbarhao_mobile/providers/static_providers.dart';
import 'package:haathbarhao_mobile/widgets/nav_bar_item.dart';

final GlobalKey<ScaffoldState> seekerBottomNavBarKey = GlobalKey();

class SeekerBottomNavBar extends ConsumerStatefulWidget {
  const SeekerBottomNavBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<SeekerBottomNavBar> {
  final pages = [
    const SeekerHomeView(),
    const SeekerOverviewView(),
    const SeekerProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavBarSelectedIndex =
        ref.watch(seekerBottomNavBarSelectedIndexProvider);

    return Scaffold(
      key: seekerBottomNavBarKey,
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
                    onTap: () {
                      ref
                          .read(
                              seekerBottomNavBarSelectedIndexProvider.notifier)
                          .state = 0;
                    },
                  ),
                  NavBarItem(
                    currentIndex: bottomNavBarSelectedIndex,
                    index: 1,
                    iconOutlined: Assets.icons.overviewOutlined,
                    iconFilled: Assets.icons.overviewOutlined,
                    label: 'Overview',
                    onTap: () {
                      ref
                          .read(
                              seekerBottomNavBarSelectedIndexProvider.notifier)
                          .state = 1;
                    },
                  ),
                  NavBarItem(
                    currentIndex: bottomNavBarSelectedIndex,
                    index: 2,
                    iconOutlined: Assets.icons.profileOutlined,
                    iconFilled: Assets.icons.profileOutlined,
                    label: 'Profile',
                    onTap: () {
                      ref
                          .read(
                              seekerBottomNavBarSelectedIndexProvider.notifier)
                          .state = 2;
                    },
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
