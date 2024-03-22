import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:haathbarhao_mobile/providers/static_providers.dart';
import 'package:haathbarhao_mobile/widgets/primary_button.dart';
import 'package:image_picker/image_picker.dart';

import '../../gen/colors.gen.dart';
import '../../gen/fonts.gen.dart';
import '../../providers/future_providers.dart';
import '../../providers/go_router.dart';
import '../../providers/token_provider.dart';
import '../../providers/user_repo_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/loading_animation.dart';
import 'email_field.dart';
import 'name_field.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({
    super.key,
  });

  @override
  ConsumerState createState() => _ProfileEditState();
}

class _ProfileEditState extends ConsumerState<ProfileView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

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

        await userRepository.patchUser(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
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

  logout() {
    ref.read(tokenProvider.notifier).setToken('');
    ref.read(bottomNavBarSelectedIndexProvider.notifier).state = 0;
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
    final user = ref.watch(userProvider);

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
      body: user.when(
        data: (data) {
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
                      EmailField(
                        textEditingController: emailController,
                        text: data.email ?? '',
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
      ),
    );
  }
}
