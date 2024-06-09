import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/models/user_model.dart';
import 'package:haathbarhao_mobile/providers/user_provider.dart';
import 'package:haathbarhao_mobile/providers/user_repo_provider.dart';
import 'package:haathbarhao_mobile/utils/get_latlng_from_location.dart';

final step2Provider =
    StateNotifierProvider.autoDispose<Step2Notifier, Step2State>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return Step2Notifier(
    ref: ref,
    userRepository: userRepository,
  );
});

class Step2Notifier extends StateNotifier<Step2State> {
  final Ref ref;
  final UserRepository userRepository;

  Step2Notifier({
    required this.ref,
    required this.userRepository,
  }) : super(
          Step2State(
            location: TextEditingController(),
          ),
        ) {
    onLoad();
  }

  void onLoad() {
    final user = ref.read(userProvider).user!;
    setRole(user.role ?? '');
    setSkills(user.skills ?? []);
    setCategory(user.preferredCategory ?? 'Electrical');
    setLocation(user.location ?? '');
    validateForm();
  }

  void setRole(String value) {
    state = state.copyWith(
      role: value,
    );
    validateForm();
  }

  void setSkills(List<Skill> skills) {
    state = state.copyWith(
      skills: skills,
    );
    validateForm();
  }

  void addSkill() {
    final skills = List<Skill>.from(state.skills)
      ..add(Skill(name: '', level: SkillLevel.beginner));
    setSkills(skills);
  }

  void removeSkill(int index) {
    final skills = List<Skill>.from(state.skills)..removeAt(index);
    setSkills(skills);
  }

  void updateSkillName(int index, String name) {
    final skills = List<Skill>.from(state.skills);
    skills[index] = skills[index].copyWith(name: name);
    setSkills(skills);
  }

  void updateSkillLevel(int index, SkillLevel level) {
    final skills = List<Skill>.from(state.skills);
    skills[index] = skills[index].copyWith(level: level);
    setSkills(skills);
  }

  void setCategory(String value) {
    state = state.copyWith(
      category: value,
    );
    validateForm();
  }

  void setLocation(String value) {
    state = state.copyWith(
      location: TextEditingController(
        text: value,
      ),
    );
    validateForm();
  }

  void setLoading(bool value) {
    state = state.copyWith(
      isLoading: value,
    );
  }

  void validateForm() {
    bool allSkillsValid = state.skills.isNotEmpty &&
        state.skills.every((skill) => skill.name.isNotEmpty);

    if (state.role.isNotEmpty &&
        allSkillsValid &&
        state.category.isNotEmpty &&
        state.location.text.isNotEmpty) {
      state = state.copyWith(
        isButtonEnabled: true,
      );
    } else {
      state = state.copyWith(
        isButtonEnabled: false,
      );
    }
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

  Future<void> saveChanges(BuildContext context) async {
    setLoading(true);
    try {
      await userRepository.patchUser(
        role: state.role,
        skills: state.skills,
        category: state.category,
        location: state.location.text,
      );
      setLoading(false);
    } catch (e, s) {
      setLoading(false);
      log(
        "Unable to save step 2 changes: ",
        error: e,
        stackTrace: s,
      );
    }
  }
}

class Step2State {
  final String role;
  final List<Skill> skills;
  final String category;
  final TextEditingController location;
  final bool isLoading;
  final bool isLocationLoading;
  final bool isButtonEnabled;

  const Step2State({
    this.role = '',
    this.skills = const [],
    this.category = 'Electrical',
    required this.location,
    this.isLocationLoading = false,
    this.isLoading = false,
    this.isButtonEnabled = false,
  });

  Step2State copyWith({
    String? role,
    List<Skill>? skills,
    String? category,
    TextEditingController? location,
    bool? isLocationLoading,
    bool? isLoading,
    bool? isButtonEnabled,
  }) {
    return Step2State(
      role: role ?? this.role,
      skills: skills ?? this.skills,
      category: category ?? this.category,
      location: location ?? this.location,
      isLoading: isLoading ?? this.isLoading,
      isLocationLoading: isLocationLoading ?? this.isLocationLoading,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }
}
