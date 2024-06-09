import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:haathbarhao_mobile/utils/convert_from_datetime.dart';
import 'package:haathbarhao_mobile/utils/convert_to_datetime.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/providers/user_provider.dart';
import 'package:haathbarhao_mobile/providers/user_repo_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

final step1Provider =
    StateNotifierProvider.autoDispose<Step1Notifier, Step1State>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return Step1Notifier(
    ref: ref,
    userRepository: userRepository,
  );
});

class Step1Notifier extends StateNotifier<Step1State> {
  final Ref ref;
  final UserRepository userRepository;

  Step1Notifier({
    required this.ref,
    required this.userRepository,
  }) : super(
          Step1State(
            dob: TextEditingController(),
          ),
        ) {
    onLoad();
  }

  Future<void> onLoad() async {
    setLoading(true);
    final user = ref.read(userProvider).user!;
    setName(user.name ?? '');
    setPhone(user.phone ?? '');
    if (user.dateOfBirth != null) {
      setDob(user.dateOfBirth!);
    }
    if (user.profilePicture != null) {
      final imageUrl = await downloadImageAsXFile(user.profilePicture!);
      if (imageUrl != null) {
        setImage(imageUrl);
      }
    }
    validateForm(false);
    state = state.copyWith(hasMadeChange: false);
    setLoading(false);
  }

  Future<XFile?> downloadImageAsXFile(String imageUrl) async {
    try {
      // Send an HTTP GET request to the image URL
      final response = await http.get(Uri.parse(imageUrl));

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Get the temporary directory
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/downloaded_image.jpg';

        // Write the image data to a file
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Create an XFile from the downloaded file
        final xFile = XFile(filePath);
        return xFile;
      } else {
        log('Failed to download image: ${response.statusCode}');
        return null;
      }
    } catch (e, s) {
      log(
        'Error downloading image: ',
        error: e,
        stackTrace: s,
      );
      return null;
    }
  }

  void setName(String value) {
    state = state.copyWith(
      name: value,
    );
    validateForm(true);
  }

  void setPhone(String value) {
    state = state.copyWith(
      phone: value,
    );
    validateForm(true);
  }

  Future<void> pickDob(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(
        const Duration(days: 18250), // 50 years
      ),
      lastDate: DateTime.now().subtract(
        const Duration(days: 6570), // 18 years
      ),
    );

    if (pickedDate != null) {
      setDob(pickedDate);
    }
  }

  void setDob(DateTime value) {
    state = state.copyWith(
      dob: TextEditingController(
        text: convertFromDateTime(value),
      ),
    );
    validateForm(true);
  }

  void setImage(XFile value) {
    state = state.copyWith(
      image: value,
    );
    validateForm(true);
  }

  void setLoading(bool value) {
    state = state.copyWith(
      isLoading: value,
    );
  }

  void validateForm(bool auto) {
    if (state.name.isNotEmpty &&
        state.phone.isNotEmpty &&
        state.image != null &&
        state.dob.text.isNotEmpty) {
      state = state.copyWith(
        isButtonEnabled: true,
      );
    }
    if (auto) {
      state = state.copyWith(
        hasMadeChange: true,
      );
    }
  }

  Future<void> saveChanges(BuildContext context) async {
    if (state.hasMadeChange == false) {
      return;
    }

    setLoading(true);
    try {
      String phoneNumber = state.phone.trim();
      if (phoneNumber.startsWith('0')) {
        phoneNumber = '+92${phoneNumber.substring(1)}';
      }

      String? downloadURL;

      if (state.image != null) {
        final File file = File(state.image!.path);

        final user = ref.read(userProvider).user!;
        FirebaseStorage storage = FirebaseStorage.instance;
        String filePath = 'profilePics/${user.id}-${DateTime.now()}.png';
        await storage.ref(filePath).putFile(file);
        downloadURL = await storage.ref(filePath).getDownloadURL();
      }

      await userRepository.patchUser(
        name: state.name.trim(),
        phone: phoneNumber,
        dateOfBirth: convertToDateTime(state.dob.text),
        profilePicture: downloadURL,
      );
      setLoading(false);
    } catch (e, s) {
      setLoading(false);
      log(
        "Unable to save step 1 changes: ",
        error: e,
        stackTrace: s,
      );
    }
  }

  updateImage() async {
    try {
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 20,
        requestFullMetadata: false,
      );

      if (pickedFile != null) {
        setImage(pickedFile);
      }
    } catch (e, s) {
      log(
        "Unable to upload user picture: ",
        error: e,
        stackTrace: s,
      );
    }
  }
}

class Step1State {
  final String name;
  final String phone;
  final TextEditingController dob;
  final XFile? image;
  final bool isLoading;
  final bool isButtonEnabled;
  final bool hasMadeChange;

  const Step1State({
    this.name = '',
    this.phone = '',
    required this.dob,
    this.image,
    this.isLoading = false,
    this.isButtonEnabled = false,
    this.hasMadeChange = false,
  });

  Step1State copyWith({
    String? name,
    String? phone,
    TextEditingController? dob,
    XFile? image,
    bool? isLoading,
    bool? isButtonEnabled,
    bool? hasMadeChange,
  }) {
    return Step1State(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      dob: dob ?? this.dob,
      image: image ?? this.image,
      isLoading: isLoading ?? this.isLoading,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      hasMadeChange: hasMadeChange ?? this.hasMadeChange,
    );
  }
}
