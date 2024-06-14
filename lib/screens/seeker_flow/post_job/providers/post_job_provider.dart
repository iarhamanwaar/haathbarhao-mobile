import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:haathbarhao_mobile/providers/future_providers.dart';
import 'package:haathbarhao_mobile/providers/tasks_repo_provider.dart';
import 'package:haathbarhao_mobile/providers/user_provider.dart';
import 'package:haathbarhao_mobile/providers/user_repo_provider.dart';
import 'package:haathbarhao_mobile/screens/doer_flow/doer_home/doer_home_provider.dart';
import 'package:haathbarhao_mobile/utils/get_latlng_from_location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';

final postJobProvider =
    StateNotifierProvider.autoDispose<PostJobNotifier, PostJobState>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return PostJobNotifier(ref: ref, userRepository: userRepository);
});

class PostJobNotifier extends StateNotifier<PostJobState> {
  final Ref ref;
  final UserRepository userRepository;

  PostJobNotifier({
    required this.ref,
    required this.userRepository,
  }) : super(
          PostJobState(
            location: TextEditingController(),
            date: TextEditingController(),
          ),
        );

  void setTitle(String value) {
    state = state.copyWith(title: value);
  }

  void setDescription(String value) {
    state = state.copyWith(description: value);
  }

  void setCategory(String value) {
    state = state.copyWith(selectedCategory: value);
  }

  void setLocation(String value) {
    state.location.text = value;
  }

  void setDate(String value) {
    state.date.text = value;
  }

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  Future<void> pickLocation() async {
    state = state.copyWith(
      isLocationLoading: true,
    );
    final newZipcode = await getLatLngFromGeolocation();
    setLocation(newZipcode ?? '');
    state = state.copyWith(
      isLocationLoading: false,
    );
  }

  void addImage(File file) {
    state = state.copyWith(
        selectedImages: List.from(state.selectedImages)..add(file));
  }

  void removeImage(int index) {
    state = state.copyWith(
        selectedImages: List.from(state.selectedImages)..removeAt(index));
  }

  Future<void> pickImage() async {
    try {
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 20,
        requestFullMetadata: false,
      );
      if (pickedFile != null) {
        final File file = File(pickedFile.path);
        addImage(file);
      }
    } catch (e, s) {
      log(
        "Unable to pick image: ",
        error: e,
        stackTrace: s,
      );

      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.redAccent,
        textColor: ColorName.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> postJob(BuildContext context) async {
    if (state.title.isNotEmpty &&
        state.description.isNotEmpty &&
        state.selectedCategory.isNotEmpty &&
        state.date.text.isNotEmpty) {
      final tasksRepository = ref.read(tasksRepositoryProvider);

      setLoading(true);

      try {
        List<String> imageUrls = [];
        for (var image in state.selectedImages) {
          final user = ref.read(userProvider).user!;
          FirebaseStorage storage = FirebaseStorage.instance;
          String filePath = 'taskImages/${user.id}-${DateTime.now()}.png';
          await storage.ref(filePath).putFile(image);
          String downloadURL = await storage.ref(filePath).getDownloadURL();
          imageUrls.add(downloadURL);
        }

        await tasksRepository.postTask(
          title: state.title.trim(),
          description: state.description.trim(),
          category: state.selectedCategory,
          location: state.location.text.trim(),
          date: DateTime.parse(state.date.text.trim()),
          pictures: imageUrls,
        );

        ref.invalidate(tasksProvider);
        ref.invalidate(taskNotifierProvider);

        setLoading(false);
        if (context.mounted) {
          context.pop();
        }
      } catch (e, s) {
        log(
          "Unable to post a new task: ",
          error: e,
          stackTrace: s,
        );
        setLoading(false);
        Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.redAccent,
          textColor: ColorName.white,
          fontSize: 16.0,
        );
      }
    }
  }
}

class PostJobState {
  final String title;
  final String description;
  final String selectedCategory;
  final TextEditingController location;
  final TextEditingController date;
  final bool isLocationLoading;
  final bool isLoading;
  final List<File> selectedImages;

  PostJobState({
    this.title = '',
    this.description = '',
    this.selectedCategory = 'Electrical',
    required this.location,
    required this.date,
    this.isLoading = false,
    this.isLocationLoading = false,
    this.selectedImages = const [],
  });

  PostJobState copyWith({
    String? title,
    String? description,
    String? selectedCategory,
    TextEditingController? location,
    TextEditingController? date,
    bool? isLoading,
    List<File>? selectedImages,
    bool? isLocationLoading,
  }) {
    return PostJobState(
      title: title ?? this.title,
      description: description ?? this.description,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      location: location ?? this.location,
      date: date ?? this.date,
      isLoading: isLoading ?? this.isLoading,
      isLocationLoading: isLocationLoading ?? this.isLocationLoading,
      selectedImages: selectedImages ?? this.selectedImages,
    );
  }
}
