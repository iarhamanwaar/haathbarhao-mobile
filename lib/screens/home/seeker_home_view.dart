import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/widgets/primary_button.dart';

import '../../gen/assets.gen.dart';
import '../../gen/colors.gen.dart';
import '../../gen/fonts.gen.dart';

class SeekerHomeView extends ConsumerStatefulWidget {
  const SeekerHomeView({super.key});

  @override
  ConsumerState createState() => _SeekerHomeViewState();
}

class _SeekerHomeViewState extends ConsumerState<SeekerHomeView> {
  final List<Map<String, dynamic>> genericTasks = [
    {
      'image': Assets.images.fanCleaning.path,
      'title': 'Fan Cleaning',
    },
    {
      'image': Assets.images.carWashing,
      'title': 'Car Washing',
    },
    {
      'image': Assets.images.electricalWork,
      'title': 'Electrical Work',
    },
    {
      'image': Assets.images.plumbingWork.path,
      'title': 'Plumbing Work',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FC),
        appBar: AppBar(
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
              Row(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '5',
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '2',
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
                        onPressed: () {},
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
                              child: Image.asset(
                                genericTasks[index]['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(13.5, 12, 13.5, 21),
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
              const PrimaryButton(
                text: 'Post a new job',
                invertColors: true,
              ),
              const SizedBox(
                height: 12,
              ),
              const PrimaryButton(
                text: 'Become a helper/switch to helper',
                backgroundColor: ColorName.black,
                invertColors: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
