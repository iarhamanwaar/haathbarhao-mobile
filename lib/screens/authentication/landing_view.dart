import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:haathbarhao_mobile/gen/assets.gen.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/gen/fonts.gen.dart';
import 'package:haathbarhao_mobile/providers/go_router.dart';
import 'package:haathbarhao_mobile/widgets/primary_button.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 37),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                Assets.images.landingIllustration.path,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Climb Higher With HaathBarhao',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: FontFamily.clashDisplay,
                fontSize: 30,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.25,
                color: ColorName.white,
              ),
            ),
            SizedBox(
              height: 140,
              width: 140,
              child: Image.asset(
                Assets.images.logo.path,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(
              onPressed: () => context.goNamed(AppRoute.register.name),
              text: 'Get Started',
            ),
          ],
        ),
      ),
    );
  }
}
