import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:haathbarhao_mobile/providers/future_providers.dart';
import 'package:haathbarhao_mobile/providers/go_router.dart';
import 'package:haathbarhao_mobile/providers/user_provider.dart';
import 'package:haathbarhao_mobile/providers/view_helper_provider.dart';
import 'package:haathbarhao_mobile/widgets/loading_animation.dart';
import 'package:haathbarhao_mobile/widgets/primary_button.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/gen/fonts.gen.dart';

class SeekerHomeView extends ConsumerStatefulWidget {
  const SeekerHomeView({super.key});

  @override
  ConsumerState createState() => _SeekerHomeViewState();
}

class _SeekerHomeViewState extends ConsumerState<SeekerHomeView> {
  final List<Map<String, dynamic>> genericTasks = [
    {
      'image':
          'https://firebasestorage.googleapis.com/v0/b/haathbarhao.appspot.com/o/taskImages%2Ffan_cleaning.jpeg?alt=media',
      'title': 'Fan Cleaning',
      'description':
          'This task involves the thorough cleaning of ceiling and stand fans to remove dust and ensure efficient operation. Safety measures should be taken to avoid electrical hazards.',
      'category': 'Cleaning',
    },
    {
      'image':
          'https://firebasestorage.googleapis.com/v0/b/haathbarhao.appspot.com/o/taskImages%2Fcar_washing.avif?alt=media',
      'title': 'Car Washing',
      'description':
          'Car washing includes exterior washing, drying, and interior vacuuming to maintain the vehicle’s appearance and hygiene. Special care may be given to wheels, windows, and exterior polish.',
      'category': 'Cleaning',
    },
    {
      'image':
          'https://firebasestorage.googleapis.com/v0/b/haathbarhao.appspot.com/o/taskImages%2Felectrical_work.avif?alt=media',
      'title': 'Electrical Work',
      'description':
          'Electrical work encompasses the repair, installation, and maintenance of electrical systems and components. This task requires knowledge of electrical safety standards and regulations.',
      'category': 'Electrical',
    },
    {
      'image':
          'https://firebasestorage.googleapis.com/v0/b/haathbarhao.appspot.com/o/taskImages%2Fplumbing_work.jpeg?alt=media',
      'title': 'Plumbing Work',
      'description':
          'Plumbing work involves the repair, installation, and maintenance of pipes, fixtures, and other plumbing components for water distribution and waste removal. It requires expertise in water systems and problem diagnosis.',
      'category': 'Plumbing',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
              'Home',
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
                onPressed: () {
                  context.goNamed(
                    AppRoute.notificationView.name,
                  );
                },
                icon: const Icon(
                  Icons.notifications_rounded,
                  color: ColorName.primaryBlack,
                ),
              ),
            ),
          ],
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final userState = ref.watch(userProvider);

            if (userState.isLoading) {
              return const LoadingAnimation();
            }

            final user = userState.user!;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 27.5,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        final userJobCounts = ref.watch(userJobCountsProvider);

                        return userJobCounts.when(
                          data: (data) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 180,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDA3C8A),
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          data.jobsPosted!.toString(),
                                          style: const TextStyle(
                                            height: 0,
                                            fontFamily: FontFamily.clashDisplay,
                                            fontSize: 96,
                                            fontWeight: FontWeight.w600,
                                            color: ColorName.white,
                                          ),
                                        ),
                                        const Text(
                                          'Posted Jobs',
                                          style: TextStyle(
                                            height: 0,
                                            fontFamily: FontFamily.clashDisplay,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: ColorName.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 180,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF253D73),
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          data.jobsHiredFor!.toString(),
                                          style: const TextStyle(
                                            height: 0,
                                            fontFamily: FontFamily.clashDisplay,
                                            fontSize: 96,
                                            fontWeight: FontWeight.w600,
                                            color: ColorName.white,
                                          ),
                                        ),
                                        const Text(
                                          'Hired',
                                          style: TextStyle(
                                            height: 0,
                                            fontFamily: FontFamily.clashDisplay,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: ColorName.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          error: (error, stackTrace) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 180,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDA3C8A),
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '0',
                                          style: TextStyle(
                                            height: 0,
                                            fontFamily: FontFamily.clashDisplay,
                                            fontSize: 96,
                                            fontWeight: FontWeight.w600,
                                            color: ColorName.white,
                                          ),
                                        ),
                                        Text(
                                          'Posted Jobs',
                                          style: TextStyle(
                                            height: 0,
                                            fontFamily: FontFamily.clashDisplay,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: ColorName.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 180,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF253D73),
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    child: const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '0',
                                          style: TextStyle(
                                            height: 0,
                                            fontFamily: FontFamily.clashDisplay,
                                            fontSize: 96,
                                            fontWeight: FontWeight.w600,
                                            color: ColorName.white,
                                          ),
                                        ),
                                        Text(
                                          'Hired',
                                          style: TextStyle(
                                            height: 0,
                                            fontFamily: FontFamily.clashDisplay,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: ColorName.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          loading: () {
                            return Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 180,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDA3C8A),
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '0',
                                          style: TextStyle(
                                            height: 0,
                                            fontFamily: FontFamily.clashDisplay,
                                            fontSize: 96,
                                            fontWeight: FontWeight.w600,
                                            color: ColorName.white,
                                          ),
                                        ),
                                        Text(
                                          'Posted Jobs',
                                          style: TextStyle(
                                            height: 0,
                                            fontFamily: FontFamily.clashDisplay,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: ColorName.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 180,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF253D73),
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    child: const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '0',
                                          style: TextStyle(
                                            height: 0,
                                            fontFamily: FontFamily.clashDisplay,
                                            fontSize: 96,
                                            fontWeight: FontWeight.w600,
                                            color: ColorName.white,
                                          ),
                                        ),
                                        Text(
                                          'Hired',
                                          style: TextStyle(
                                            height: 0,
                                            fontFamily: FontFamily.clashDisplay,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: ColorName.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Get a new task done',
                      style: TextStyle(
                        height: 0,
                        fontFamily: FontFamily.clashDisplay,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: ColorName.black,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 240,
                      child: ListView.separated(
                        itemCount: genericTasks.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                context.goNamed(
                                  AppRoute.postJobView.name,
                                  // queryParameters: {
                                  //   'image': genericTasks[index]['image'],
                                  //   'title': genericTasks[index]['title'],
                                  //   'description': genericTasks[index]
                                  //       ['description'],
                                  //   'category': genericTasks[index]['category'],
                                  // },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorName.white,
                                surfaceTintColor: ColorName.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 162,
                                    child: Image.network(
                                      genericTasks[index]['image'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        13.5, 12, 13.5, 21),
                                    child: Text(
                                      genericTasks[index]['title'],
                                      style: const TextStyle(
                                        height: 0,
                                        fontFamily: FontFamily.clashDisplay,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: ColorName.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 12,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    PrimaryButton(
                      text: 'Post a new job',
                      invertColors: true,
                      onPressed: () {
                        context.goNamed(
                          AppRoute.postJobView.name,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        if (user.isHelper!) {
                          ref.read(viewHelperProvider.notifier).setStatus(true);
                        } else {
                          context.goNamed(
                            AppRoute.becomeAHelper.name,
                            queryParameters: {
                              'index': user.isHelperSubmitted! ? '3' : '0',
                            },
                          );
                        }
                      },
                      text: user.isHelper!
                          ? 'Switch to Helper'
                          : 'Become a Helper',
                      backgroundColor: ColorName.black,
                      invertColors: true,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
