import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/gen/fonts.gen.dart';
import 'package:haathbarhao_mobile/screens/doer_flow/become_helper/providers/step3_provider.dart';
import 'package:haathbarhao_mobile/widgets/primary_button.dart';

class Step3View extends ConsumerWidget {
  final Function() nextOnPressed;

  const Step3View({
    required this.nextOnPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final step3State = ref.watch(step3Provider);
    final step3Notifier = ref.watch(step3Provider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Add Documents',
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
              'Upload your CNIC documents.',
              style: GoogleFonts.spaceGrotesk(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: ColorName.primaryBlack.withOpacity(0.5),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Front Facing Picture',
              style: GoogleFonts.spaceGrotesk(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: ColorName.primaryBlack.withOpacity(0.5),
              ),
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => step3Notifier.pickCnicFront(),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: ColorName.lightGrey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorName.primaryBlack, width: 2),
              ),
              clipBehavior: Clip.antiAlias,
              child: step3State.cnicFront == null
                  ? const Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: ColorName.primaryBlack,
                    )
                  : Image.file(
                      File(
                        step3State.cnicFront!,
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Back Facing Picture',
              style: GoogleFonts.spaceGrotesk(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: ColorName.primaryBlack.withOpacity(0.5),
              ),
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => step3Notifier.pickCnicBack(),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: ColorName.lightGrey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: ColorName.primaryBlack,
                  width: 2,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: step3State.cnicBack == null
                  ? const Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: ColorName.primaryBlack,
                    )
                  : Image.file(
                      File(step3State.cnicBack!),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            text: 'Save Documents',
            isLoading: step3State.isLoading,
            enabled:
                step3State.cnicFront != null && step3State.cnicBack != null,
            invertColors: true,
            onPressed: () async {
              await step3Notifier.saveChanges();
              nextOnPressed();
            },
          ),
        ],
      ),
    );
  }
}
