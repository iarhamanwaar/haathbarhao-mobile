import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/models/job_counts_model.dart';
import 'package:haathbarhao_mobile/providers/static_providers.dart';
import 'package:haathbarhao_mobile/providers/tasks_repo_provider.dart';
import 'package:haathbarhao_mobile/providers/user_repo_provider.dart';
import 'package:haathbarhao_mobile/models/tasks_model.dart';

final userJobCountsProvider = FutureProvider<JobCounts>((ref) async {
  final userRepository = ref.read(userRepositoryProvider);

  return await userRepository.getUserJobCounts();
});

final tasksProvider = FutureProvider<List<Task>>((ref) async {
  final tasksRepository = ref.read(tasksRepositoryProvider);
  final selectedIndex = ref.watch(seekerOverviewTabSelectedIndexProvider);

  String status = 'upcoming';

  if (selectedIndex == 1) {
    status = 'ongoing';
  } else if (selectedIndex == 2) {
    status = 'completed';
  }

  return await tasksRepository.getTasks(status);
});
