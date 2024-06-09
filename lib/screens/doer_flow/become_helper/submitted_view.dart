import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haathbarhao_mobile/gen/assets.gen.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/gen/fonts.gen.dart';
import 'package:haathbarhao_mobile/widgets/primary_button.dart';

class SubmittedView extends StatelessWidget {
  final Function() backToHome;

  const SubmittedView({
    required this.backToHome,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'All Done!',
              style: TextStyle(
                fontFamily: FontFamily.clashDisplay,
                fontWeight: FontWeight.w600,
                fontSize: 32,
                color: ColorName.primaryBlack,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Now we wait.',
              style: GoogleFonts.spaceGrotesk(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: ColorName.primaryBlack.withOpacity(0.5),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Image.asset(
            Assets.images.landingIllustration.path,
            height: 200,
          ),
          const SizedBox(height: 40),
          Text(
            'Thats all we need from you right now.',
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: ColorName.primaryBlack,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We’ll notify you when your profile is approved.',
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: ColorName.primaryBlack.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 40),
          PrimaryButton(
            text: 'Back to home',
            invertColors: true,
            onPressed: backToHome,
          ),
        ],
      ),
    );
  }
}
