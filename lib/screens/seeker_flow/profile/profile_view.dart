import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/gen/fonts.gen.dart';
import 'package:haathbarhao_mobile/providers/go_router.dart';
import 'package:haathbarhao_mobile/providers/static_providers.dart';
import 'package:haathbarhao_mobile/providers/token_provider.dart';
import 'package:haathbarhao_mobile/providers/user_provider.dart';
import 'package:haathbarhao_mobile/providers/user_repo_provider.dart';
import 'package:haathbarhao_mobile/utils/constants.dart';
import 'package:haathbarhao_mobile/widgets/loading_animation.dart';
import 'package:haathbarhao_mobile/widgets/primary_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:haathbarhao_mobile/screens/seeker_flow/profile/phone_number_field.dart';
import 'package:haathbarhao_mobile/screens/seeker_flow/profile/name_field.dart';

class SeekerProfileView extends ConsumerStatefulWidget {
  const SeekerProfileView({super.key});

  @override
  ConsumerState createState() => _ProfileEditState();
}

class _ProfileEditState extends ConsumerState<SeekerProfileView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

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

        final user = ref.read(userProvider).user!;

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

        String phoneNumber = phoneController.text.trim();

        if (phoneNumber.startsWith('0')) {
          phoneNumber = '+92${phoneNumber.substring(1)}';
        }

        await userRepository.patchUser(
          name: nameController.text.trim(),
          phone: phoneNumber,
        );

        ref.read(userProvider.notifier).onLoad();

        if (mounted) {
          context.pop();
          context.pop();
        }
      }
    } catch (e) {
      if (mounted) context.pop();
    }
  }

  logout() {
    ref.read(tokenProvider.notifier).setToken('');
    ref.invalidate(userProvider);
    ref.invalidate(seekerBottomNavBarSelectedIndexProvider);
    ref.invalidate(doerBottomNavBarSelectedIndexProvider);
    if (context.mounted) context.goNamed(AppRoute.main.name);
  }

  Future<void> _sendEmail() async {
    final Email email = Email(
      subject: 'HaathBarhao Feedback',
      recipients: [supportEmail],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FC),
        title: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Profile',
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
              right: 20,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_rounded,
                color: ColorName.primaryBlack,
              ),
            ),
          ),
        ],
      ),
      body: Consumer(builder: (context, ref, child) {
        final userState = ref.watch(userProvider);

        if (userState.isLoading) {
          return const LoadingAnimation();
        }

        final user = userState.user!;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 24,
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
                          child: user.profilePicture != null
                              ? Image.network(
                                  user.profilePicture!,
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
                      text: user.name ?? '',
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    PhoneNumberField(
                      textEditingController: phoneController,
                      text: user.phone != null
                          ? '0${user.phone!.substring(3)}'
                          : '',
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    PrimaryButton(
                      text: 'Save Changes',
                      invertColors: true,
                      onPressed: saveChanges,
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  height: 36,
                  width: 93,
                  child: PrimaryButton(
                    onPressed: logout,
                    text: 'Log Out',
                    invertColors: true,
                    backgroundColor: const Color(0xFFC2392C),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 36,
                  width: 163,
                  child: PrimaryButton(
                    onPressed: _sendEmail,
                    text: 'Contact Support',
                    invertColors: true,
                    backgroundColor: ColorName.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
