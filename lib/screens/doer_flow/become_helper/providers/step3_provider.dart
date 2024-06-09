import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:haathbarhao_mobile/providers/user_provider.dart';
import 'package:haathbarhao_mobile/providers/user_repo_provider.dart';

final step3Provider =
    StateNotifierProvider.autoDispose<Step3Notifier, Step3State>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return Step3Notifier(
    ref: ref,
    userRepository: userRepository,
  );
});

class Step3Notifier extends StateNotifier<Step3State> {
  final Ref ref;
  final UserRepository userRepository;

  Step3Notifier({
    required this.ref,
    required this.userRepository,
  }) : super(const Step3State()) {
    onLoad();
  }

  void onLoad() {
    final user = ref.read(userProvider).user!;
    if (user.cnicFront != null) {
      setCnicFront(user.cnicFront!);
    }
    if (user.cnicBack != null) {
      setCnicBack(user.cnicBack!);
    }
  }

  Future<void> pickCnicFront() async {
    try {
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );

      if (pickedFile != null) {
        setCnicFront(pickedFile.path);
      }
    } catch (e, s) {
      log(
        "Unable to pick CNIC front image: ",
        error: e,
        stackTrace: s,
      );
    }
  }

  Future<void> pickCnicBack() async {
    try {
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );

      if (pickedFile != null) {
        setCnicBack(pickedFile.path);
      }
    } catch (e, s) {
      log(
        "Unable to pick CNIC back image: ",
        error: e,
        stackTrace: s,
      );
    }
  }

  void setCnicFront(String value) {
    state = state.copyWith(cnicFront: value);
  }

  void setCnicBack(String value) {
    state = state.copyWith(cnicBack: value);
  }

  Future<void> saveChanges() async {
    setLoading(true);
    try {
      final user = ref.read(userProvider).user!;
      String? cnicFrontUrl;
      String? cnicBackUrl;

      if (state.cnicFront != null) {
        cnicFrontUrl = await uploadImage(
          state.cnicFront!,
          'cnicFront/${user.id}-${DateTime.now()}.png',
        );
      }

      if (state.cnicBack != null) {
        cnicBackUrl = await uploadImage(
          state.cnicBack!,
          'cnicBack/${user.id}-${DateTime.now()}.png',
        );
      }

      await userRepository.patchUser(
        isHelperSubmitted: true,
        cnicFront: cnicFrontUrl,
        cnicBack: cnicBackUrl,
      );

      setLoading(false);
    } catch (e, s) {
      setLoading(false);
      log(
        "Unable to save step 3 changes: ",
        error: e,
        stackTrace: s,
      );
    }
  }

  Future<String> uploadImage(String filePath, String storagePath) async {
    final File file = File(filePath);
    FirebaseStorage storage = FirebaseStorage.instance;
    await storage.ref(storagePath).putFile(file);
    return await storage.ref(storagePath).getDownloadURL();
  }

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }
}

class Step3State {
  final String? cnicFront;
  final String? cnicBack;
  final bool isLoading;

  const Step3State({
    this.cnicFront,
    this.cnicBack,
    this.isLoading = false,
  });

  Step3State copyWith({
    String? cnicFront,
    String? cnicBack,
    bool? isLoading,
  }) {
    return Step3State(
      cnicFront: cnicFront ?? this.cnicFront,
      cnicBack: cnicBack ?? this.cnicBack,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
