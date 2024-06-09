import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/gen/fonts.gen.dart';
import 'package:haathbarhao_mobile/providers/user_provider.dart';
import 'package:haathbarhao_mobile/screens/authentication/screens/widgets/custom_text_field.dart';
import 'package:haathbarhao_mobile/screens/doer_flow/become_helper/providers/step1_provider.dart';
import 'package:haathbarhao_mobile/widgets/loading_animation.dart';
import 'package:haathbarhao_mobile/widgets/primary_button.dart';

class Step1View extends ConsumerStatefulWidget {
  final Function() nextOnPressed;

  const Step1View({
    required this.nextOnPressed,
    super.key,
  });

  @override
  ConsumerState createState() => _Step1ViewState();
}

class _Step1ViewState extends ConsumerState<Step1View> {
  @override
  Widget build(BuildContext context) {
    final step1State = ref.watch(step1Provider);
    final step1Notifier = ref.watch(step1Provider.notifier);
    final userState = ref.watch(userProvider);

    if (userState.isLoading) {
      return const LoadingAnimation();
    }

    final user = userState.user!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Update',
              style: TextStyle(
                fontFamily: FontFamily.clashDisplay,
                fontWeight: FontWeight.w600,
                fontSize: 32,
                color: ColorName.primaryBlack,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Update your details.',
              style: GoogleFonts.spaceGrotesk(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: ColorName.primaryBlack.withOpacity(0.5),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Column(
            children: [
              GestureDetector(
                onTap: step1Notifier.updateImage,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 132,
                    width: 132,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade300,
                    ),
                    child: step1State.image != null
                        ? Image.file(
                            File(
                              step1State.image!.path,
                            ),
                            fit: BoxFit.cover,
                          )
                        : user.profilePicture != null
                            ? CachedNetworkImage(
                                imageUrl: user.profilePicture!,
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                Icons.person,
                                size: 50,
                              ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              CustomTextField(
                type: 'Name',
                initialValue: step1State.name,
                onChanged: step1Notifier.setName,
              ),
              const SizedBox(
                height: 12,
              ),
              CustomTextField(
                type: 'Phone',
                initialValue: '0${step1State.phone.substring(3)}',
                onChanged: step1Notifier.setPhone,
              ),
              const SizedBox(
                height: 12,
              ),
              CustomTextField(
                type: 'Date',
                hintText: 'Date Of Birth',
                textEditingController: step1State.dob,
                onPressed: () => step1Notifier.pickDob(context),
                suffixIcon: const Icon(
                  Icons.calendar_today_sharp,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              PrimaryButton(
                text: 'Save Changes',
                invertColors: true,
                isLoading: step1State.isLoading,
                enabled: step1State.isButtonEnabled,
                onPressed: () async {
                  await step1Notifier.saveChanges(context);
                  widget.nextOnPressed();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
