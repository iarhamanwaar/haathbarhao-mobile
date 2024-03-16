import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    required String email,
    required String password,
  }) async {
    try {
      final body = jsonEncode({
        "email": email,
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
    required String email,
    required String password,
  }) async {
    try {
      final body = jsonEncode({
        "name": name,
        "role": role,
        "email": email,
        "password": password,
      });

      final response = await apiService.post(
        endpoint: '/api/users/register',
        body: body,
      );

      if (response.statusCode == 201) {
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

  Future<User> patchUser({
    String? name,
    String? email,
    String? password,
  }) async {
    try {
      final body = jsonEncode({
        if (name != null) "name": name,
        if (email != null) "email": email,
        if (password != null) "password": password,
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
