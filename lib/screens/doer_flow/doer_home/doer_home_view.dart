import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haathbarhao_mobile/gen/assets.gen.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/gen/fonts.gen.dart';
import 'package:haathbarhao_mobile/providers/go_router.dart';
import 'package:haathbarhao_mobile/providers/user_provider.dart';
import 'package:haathbarhao_mobile/providers/view_helper_provider.dart';
import 'package:haathbarhao_mobile/screens/doer_flow/doer_home/doer_home_provider.dart';
import 'package:haathbarhao_mobile/widgets/primary_button.dart';

class DoerHomeView extends ConsumerStatefulWidget {
  const DoerHomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<DoerHomeView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(taskNotifierProvider.notifier).fetchTasks(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskNotifierProvider);

    void onSearchChanged() {
      ref
          .read(taskNotifierProvider.notifier)
          .filterTasks(_searchController.text);
    }

    _searchController.addListener(onSearchChanged);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FC),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5F7FC),
          title: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Search',
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
            Consumer(
              builder: (context, ref, child) {
                final userState = ref.watch(userProvider);

                if (userState.isLoading) {
                  return const SizedBox.shrink();
                }

                final user = userState.user!;

                return Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                  ),
                  child: IconButton(
                    onPressed: () => context.goNamed(AppRoute.profile.name),
                    icon: CircleAvatar(
                      backgroundImage: NetworkImage(
                        user.profilePicture!,
                      ),
                    ),
                  ),
                );
              },
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
              TextFormField(
                controller: _searchController,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorName.primaryBlack,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 14,
                  ),
                  hintText: 'Plumber',
                  hintStyle: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorName.lightGrey,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: ColorName.primaryBlack,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(45),
                    borderSide: const BorderSide(
                      color: ColorName.primaryBlack,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(45),
                    borderSide: const BorderSide(
                      color: ColorName.primaryBlack,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text(
                    '${tasks.length} JOBS FOUND',
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
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
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
                                child: Image.network(
                                  task.photos != null && task.photos!.isNotEmpty
                                      ? task.photos!.first
                                      : 'path_to_default_image',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.title ?? '',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF181A1F),
                                      ),
                                    ),
                                    Text(
                                      task.location ?? '',
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
                              if (task.status == 'applied')
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
                              if (task.date != null &&
                                  task.date!.isAfter(DateTime.now()
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
                                  task.category ?? '',
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
                                  task.location ?? '',
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
                                  '${task.description}',
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
              const SizedBox(
                height: 12,
              ),
              PrimaryButton(
                onPressed: () {
                  ref.read(viewHelperProvider.notifier).setStatus(false);
                  context.goNamed(
                    AppRoute.main.name,
                  );
                },
                text: 'Switch to Seeker',
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
