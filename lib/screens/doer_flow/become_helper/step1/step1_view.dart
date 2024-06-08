import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/gen/fonts.gen.dart';
import 'package:haathbarhao_mobile/providers/future_providers.dart';
import 'package:haathbarhao_mobile/providers/user_repo_provider.dart';
import 'package:haathbarhao_mobile/screens/doer_flow/become_helper/step1/dob_field.dart';
import 'package:haathbarhao_mobile/screens/doer_flow/become_helper/step1/phone_number_field.dart';
import 'package:haathbarhao_mobile/screens/doer_flow/become_helper/step1/name_field.dart';
import 'package:haathbarhao_mobile/widgets/loading_animation.dart';
import 'package:haathbarhao_mobile/widgets/primary_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  updateImage() async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const LoadingAnimation();
        },
      );

      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 20,
        requestFullMetadata: false,
      );
      if (pickedFile != null) {
        final File file = File(pickedFile.path);

        final user = await ref.read(userProvider.future);

        FirebaseStorage storage = FirebaseStorage.instance;
        String filePath = 'profilePics/${user.id}-${DateTime.now()}.png';

        await storage.ref(filePath).putFile(file);

        String downloadURL = await storage.ref(filePath).getDownloadURL();

        final userRepository = ref.read(userRepositoryProvider);
        await userRepository.patchUser(profilePicture: downloadURL);

        ref.invalidate(userProvider);
      }

      if (mounted) context.pop();
    } catch (e) {
      log(e.toString());
      if (mounted) context.pop();
    }
  }

  saveChanges() async {
    try {
      final userRepository = ref.watch(userRepositoryProvider);

      if (formKey.currentState!.validate()) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const LoadingAnimation();
          },
        );

        DateFormat format = DateFormat("dd-MM-yyyy");

        await userRepository.patchUser(
          name: nameController.text.trim(),
          phone: phoneController.text.trim(),
          dateOfBirth: format.parse(
            dobController.text,
          ),
        );

        final user = ref.refresh(userProvider);

        user.when(
          loading: () {},
          error: (err, stackTrace) {
            if (context.mounted) context.pop();
          },
          data: (data) {
            if (context.mounted) context.pop();
            if (context.mounted) context.pop();
          },
        );
      }
    } catch (e) {
      if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return user.when(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: formKey,
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
                      onTap: updateImage,
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
                          child: data.profilePicture != null
                              ? Image.network(
                                  data.profilePicture!,
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
                    NameField(
                      textEditingController: nameController,
                      text: data.name ?? '',
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    PhoneNumberField(
                      textEditingController: phoneController,
                      text: data.phone ?? '',
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    DobField(
                      textEditingController: dobController,
                      text: data.dateOfBirth != null
                          ? DateFormat('dd-MM-yyyy').format(
                              data.dateOfBirth!,
                            )
                          : '',
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    PrimaryButton(
                      text: 'Save Changes',
                      invertColors: true,
                      onPressed: () async {
                        await saveChanges();
                        if (formKey.currentState!.validate()) {
                          widget.nextOnPressed();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => Center(
        child: Text(
          error.toString(),
          textScaler: TextScaler.noScaling,
        ),
      ),
      loading: () => const Center(
        child: LoadingAnimation(),
      ),
    );
  }
}
