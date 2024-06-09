import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/models/job_counts_model.dart';
import 'package:haathbarhao_mobile/providers/token_provider.dart';
import '../models/user_model.dart';
import 'api_provider.dart';

final userRepositoryProvider = StateProvider((ref) {
  final apiService = ref.read(apiProvider);

  return UserRepository(apiService, ref);
});

class UserRepository {
  late APIService apiService;
  final Ref ref;

  UserRepository(this.apiService, this.ref);

  Future<User> loginWithEmail({
    required String phone,
    required String password,
  }) async {
    try {
      final body = jsonEncode({
        "phone": phone,
        "password": password,
      });

      final response = await apiService.post(
        endpoint: '/api/users/login',
        body: body,
      );

      if (response.statusCode == 200) {
        final user =
            userFromJson(jsonEncode(jsonDecode(response.data)['data']));

        ref
            .read(tokenProvider.notifier)
            .setToken(jsonDecode(response.data)['data']['token']);

        return user;
      } else {
        log(jsonDecode(response.data)['message']);
        throw jsonDecode(response.data)['message'];
      }
    } catch (e) {
      log(jsonDecode(e.toString()));
      throw jsonDecode(e.toString());
    }
  }

  Future<User> signupWithEmail({
    required String name,
    required String role,
    required String phone,
    required String password,
  }) async {
    try {
      final body = jsonEncode({
        "name": name,
        "role": role,
        "phone": phone,
        "password": password,
      });

      final response = await apiService.post(
        endpoint: '/api/users/register',
        body: body,
      );

      if (response.statusCode == 200) {
        final user =
            userFromJson(jsonEncode(jsonDecode(response.data)['data']));

        ref
            .read(tokenProvider.notifier)
            .setToken(jsonDecode(response.data)['data']['token']);

        return user;
      } else {
        log(jsonDecode(response.data)['message']);
        throw jsonDecode(response.data)['message'];
      }
    } catch (e) {
      log(jsonDecode(e.toString()));
      throw jsonDecode(e.toString());
    }
  }

  Future<User> getUser() async {
    try {
      final response = await apiService.get(
        endpoint: '/api/users/profile',
      );

      if (response.statusCode == 200) {
        final user =
            userFromJson(jsonEncode(jsonDecode(response.data)['data']));

        return user;
      } else {
        log(jsonDecode(response.data)['message']);
        throw jsonDecode(response.data)['message'];
      }
    } catch (e) {
      log(jsonDecode(e.toString()));
      throw jsonDecode(e.toString());
    }
  }

  Future<JobCounts> getUserJobCounts() async {
    try {
      final response = await apiService.get(
        endpoint: '/api/users/job-counts',
      );

      if (response.statusCode == 200) {
        final jobCounts =
            jobCountsFromJson(jsonEncode(jsonDecode(response.data)['data']));

        return jobCounts;
      } else {
        log(jsonDecode(response.data)['message']);
        throw jsonDecode(response.data)['message'];
      }
    } catch (e) {
      log(jsonDecode(e.toString()));
      throw jsonDecode(e.toString());
    }
  }

  Future<User> patchUser({
    String? name,
    String? phone,
    String? password,
    String? profilePicture,
    DateTime? dateOfBirth,
    String? role,
    List<Skill>? skills,
    String? category,
    String? location,
    String? cnicFront,
    String? cnicBack,
    bool? isHelperSubmitted,
    String? fcmToken,
  }) async {
    try {
      final body = jsonEncode({
        if (name != null) "name": name,
        if (phone != null) "phone": phone,
        if (password != null) "password": password,
        if (profilePicture != null) "profilePicture": profilePicture,
        if (dateOfBirth != null) "dateOfBirth": dateOfBirth.toIso8601String(),
        if (role != null) "role": role,
        if (skills != null)
          "skills": skills.map((skill) => skill.toJson()).toList(),
        if (category != null) "preferredCategory": category,
        if (location != null) "location": location,
        if (cnicFront != null) "cnicFront": cnicFront,
        if (cnicBack != null) "cnicBack": cnicBack,
        if (isHelperSubmitted != null) "isHelperSubmitted": isHelperSubmitted,
        if (fcmToken != null) "fcmToken": fcmToken,
      });

      final response = await apiService.put(
        endpoint: '/api/users/profile',
        body: body,
      );

      if (response.statusCode == 200) {
        final user =
            userFromJson(jsonEncode(jsonDecode(response.data)['data']));
        return user;
      } else {
        log(jsonDecode(response.data)['message']);
        throw jsonDecode(response.data)['message'];
      }
    } catch (e) {
      log(jsonDecode(e.toString()));
      throw jsonDecode(e.toString());
    }
  }
}
