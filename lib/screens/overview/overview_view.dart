import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/providers/static_providers.dart';
import 'package:haathbarhao_mobile/screens/overview/overview_tab_bar.dart';

import '../../gen/colors.gen.dart';
import '../../gen/fonts.gen.dart';

class OverviewView extends ConsumerStatefulWidget {
  const OverviewView({super.key});

  @override
  ConsumerState createState() => _OverviewViewState();
}

class _OverviewViewState extends ConsumerState<OverviewView> {
  @override
  Widget build(BuildContext context) {
    final overviewTabSelectedIndex =
        ref.watch(overviewTabSelectedIndexProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FC),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5F7FC),
          title: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Overview',
              style: TextStyle(
                fontFamily: FontFamily.clashDisplay,
                fontWeight: FontWeight.w600,
                fontSize: 32,
                color: ColorName.primaryBlack,
              ),
            ),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
                right: 20,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_rounded,
                  color: ColorName.primaryBlack,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 27.5,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFC5C5C5),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(100),
                  color: ColorName.transparentColor,
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    OverviewTabBar(
                      text: 'Upcoming',
                      index: 0,
                      currentIndex: overviewTabSelectedIndex,
                    ),
                    OverviewTabBar(
                      text: 'Ongoing',
                      index: 1,
                      currentIndex: overviewTabSelectedIndex,
                    ),
                    OverviewTabBar(
                      text: 'Completed',
                      index: 2,
                      currentIndex: overviewTabSelectedIndex,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
