import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/models/user_model.dart';
import 'package:haathbarhao_mobile/providers/user_repo_provider.dart';

final userProvider = FutureProvider<User>((ref) async {
  final userRepository = ref.read(userRepositoryProvider);

  return await userRepository.getUser();
});
