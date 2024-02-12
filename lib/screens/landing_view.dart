import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haathbarhao_mobile/gen/assets.gen.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/providers/go_router.dart';

class LandingView extends ConsumerStatefulWidget {
  const LandingView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LandingViewState();
}

class _LandingViewState extends ConsumerState<LandingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.primary,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 50,
                  child: Text(
                    'Climb Higher With HaathBarhao',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.25,
                      color: ColorName.white,
                    ),
                  ),
                ),
                Image.asset(
                  Assets.images.landingIllustration.path,
                  width: 300,
                ),
                Positioned(
                  bottom: -90,
                  child: SizedBox(
                    height: 140,
                    width: 140,
                    child: Image.asset(
                      Assets.images.logo.path,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
            OutlinedButton(
              onPressed: () => context.goNamed(AppRoute.register.name),
              style: OutlinedButton.styleFrom(
                side: BorderSide.none,
                backgroundColor: ColorName.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 52,
                  vertical: 15,
                ),
              ),
              child: Text(
                'Start Browsing'.toUpperCase(),
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: ColorName.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
