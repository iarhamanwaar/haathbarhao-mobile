import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haathbarhao_mobile/gen/assets.gen.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/screens/doer_flow/doer_home/doer_home_provider.dart';
import 'package:haathbarhao_mobile/screens/doer_flow/doer_home/job_detail_provider.dart';
import 'package:intl/intl.dart';

class JobDetailView extends ConsumerStatefulWidget {
  final int index;

  const JobDetailView({
    required this.index,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JobDetailViewState();
}

class _JobDetailViewState extends ConsumerState<JobDetailView> {
  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskNotifierProvider);
    final job = tasks[widget.index];

    Future<void> applyForJob() async {
      try {
        await ref.read(jobDetailProvider.notifier).applyForJob(job.id!);
        // Show success message or update UI accordingly
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Applied successfully'),
          ),
        );
      } catch (e) {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred'),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: SvgPicture.asset(
            Assets.icons.backFilled,
            color: const Color(0xFF181A1F),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        job.photos != null && job.photos!.isNotEmpty
                            ? job.photos!.first
                            : 'assets/default_image.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      job.title ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF181A1F),
                      ),
                    ),
                    Text(
                      job.location ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF181A1F).withOpacity(0.8),
                      ),
                    ),
                    Text(
                      'Posted on ${DateFormat('d MMMM').format(
                        job.createdAt ?? DateTime.now(),
                      )}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF181A1F).withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(
                      height: 47,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Apply Before'.toUpperCase(),
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.75,
                                color:
                                    const Color(0xFF181A1F).withOpacity(0.75),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              DateFormat('dd MMMM, y').format(
                                job.date ?? DateTime.now(),
                              ),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF181A1F),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Job Nature'.toUpperCase(),
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.75,
                                color:
                                    const Color(0xFF181A1F).withOpacity(0.75),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              job.category ?? '',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF181A1F),
                              ),
                            ),
                          ],
                        ),
                        Container(),
                      ],
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Job Location'.toUpperCase(),
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.75,
                                color:
                                    const Color(0xFF181A1F).withOpacity(0.75),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              job.location ?? '',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF181A1F),
                              ),
                            ),
                          ],
                        ),
                        Container(),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Text(
                      'Job Description'.toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.75,
                        color: const Color(0xFF181A1F).withOpacity(0.75),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      job.description ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF181A1F),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      'Roles and Responsibilities'.toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.75,
                        color: const Color(0xFF181A1F).withOpacity(0.75),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      job.requiredSkills != null
                          ? job.requiredSkills!.join(', ')
                          : '',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF181A1F),
                      ),
                    ),
                    const SizedBox(height: 100)
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 80,
            right: 80,
            bottom: 20,
            child: SizedBox(
              height: 52,
              child: OutlinedButton(
                onPressed: applyForJob,
                style: OutlinedButton.styleFrom(
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: ColorName.primary,
                ),
                child: ref.watch(jobDetailProvider)
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: ColorName.white,
                        ),
                      )
                    : Text(
                        'Apply Now'.toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: ColorName.white,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
