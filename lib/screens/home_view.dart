// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haathbarhao_mobile/gen/assets.gen.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/providers/go_router.dart';
import 'package:haathbarhao_mobile/utils/jobs_data.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FC),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22),
          child: GestureDetector(
            onTap: () => context.goNamed(AppRoute.profile.name),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                Assets.images.userImage.path,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 8,
            ),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                Assets.icons.notificationsOutlined,
                color: const Color(0xFF181A1F),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${jobsData.length} JOBS FOUND',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.75,
                          color: ColorName.black.withOpacity(0.7),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'All Relevance',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.25,
                          color: ColorName.primary,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                        width: 16,
                        child: SvgPicture.asset(
                          Assets.icons.arrowDropDown,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: jobsData.length,
                      itemBuilder: (context, index) {
                        return ElevatedButton(
                          onPressed: () => context.goNamed(
                            AppRoute.jobDetailView.name,
                            queryParameters: {
                              'index': index.toString(),
                            },
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0.1,
                            backgroundColor: ColorName.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.only(
                              left: 16,
                              top: 18,
                              bottom: 18,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image.asset(
                                      jobsData[index]['logo']!.toString(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          jobsData[index]['title']!.toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF181A1F),
                                          ),
                                        ),
                                        Text(
                                          jobsData[index]['company']!
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF181A1F)
                                                .withOpacity(0.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  if (bool.parse(
                                      jobsData[index]['applied']!.toString()))
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF07864B),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            Assets.icons.doneCircular,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Applied',
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: ColorName.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (DateTime.parse(
                                          jobsData[index]['expiry']!.toString())
                                      .isAfter(DateTime.now()
                                          .subtract(const Duration(days: 10))))
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFDAA400),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            Assets.icons.infoCircular,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Expires Soon',
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: ColorName.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      jobsData[index]['jobNature']!.toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF181A1F)
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Text(
                                      jobsData[index]['jobLocation']!
                                          .toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF181A1F)
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      jobsData[index]['salary']!.toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF181A1F)
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 12);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
