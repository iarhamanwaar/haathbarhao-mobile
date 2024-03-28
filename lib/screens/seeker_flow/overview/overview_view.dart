import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/gen/fonts.gen.dart';
import 'package:haathbarhao_mobile/providers/future_providers.dart';
import 'package:haathbarhao_mobile/providers/static_providers.dart';
import 'package:haathbarhao_mobile/screens/seeker_flow/overview/overview_tab_bar.dart';
import 'package:haathbarhao_mobile/screens/seeker_flow/overview/overview_card.dart';

class SeekerOverviewView extends ConsumerStatefulWidget {
  const SeekerOverviewView({super.key});

  @override
  ConsumerState createState() => _OverviewViewState();
}

class _OverviewViewState extends ConsumerState<SeekerOverviewView> {
  @override
  Widget build(BuildContext context) {
    final overviewTabSelectedIndex =
        ref.watch(seekerOverviewTabSelectedIndexProvider);
    final tasks = ref.watch(tasksProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FC),
        appBar: AppBar(
          surfaceTintColor: ColorName.transparentColor,
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
              tasks.when(
                data: (data) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: data.length,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemBuilder: (context, index) {
                        return OverviewCard(task: data[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16);
                      },
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                loading: () {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
