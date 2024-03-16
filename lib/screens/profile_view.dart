import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haathbarhao_mobile/gen/assets.gen.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/providers/go_router.dart';
import 'package:haathbarhao_mobile/screens/become_recruitee_screen/become_recruitee_screen.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  color: ColorName.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                ),
              ),
              Positioned(
                bottom: -50,
                child: CircleAvatar(
                  radius: 74,
                  backgroundImage: AssetImage(
                    Assets.images.userImage.path,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 70,
          ),
          Text(
            '',
            style: GoogleFonts.inter(
              color: ColorName.primary,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            'Profile View',
            style: GoogleFonts.inter(
              color: ColorName.primary,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 80,
            width: 200,
            child: OutlinedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const BecomeRecruiteeScreen();
                },
              )),
              style: OutlinedButton.styleFrom(
                side: BorderSide.none,
                shape: const StadiumBorder(),
                backgroundColor: ColorName.primary,
                padding: EdgeInsets.zero,
              ),
              child: Text(
                'Become\nRecruiter',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  height: 0,
                  fontSize: 24,
                  color: ColorName.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 80,
            width: 200,
            child: OutlinedButton(
              onPressed: () => context.goNamed(AppRoute.main.name),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: ColorName.primary,
                ),
                shape: const StadiumBorder(),
                backgroundColor: ColorName.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
              ),
              child: Text(
                'Find More Jobs',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  height: 0,
                  fontSize: 24,
                  color: ColorName.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 60,
            width: 200,
            child: OutlinedButton(
              onPressed: () {
                context.goNamed(AppRoute.main.name);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide.none,
                shape: const StadiumBorder(),
                backgroundColor: ColorName.primary,
                padding: EdgeInsets.zero,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Sign Out',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      height: 0,
                      fontSize: 24,
                      color: ColorName.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset(
                      Assets.icons.logoutFilled,
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
