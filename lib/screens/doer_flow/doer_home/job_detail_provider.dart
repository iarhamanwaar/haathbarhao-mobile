import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/providers/tasks_repo_provider.dart';

final jobDetailProvider = StateNotifierProvider<JobDetailNotifier, bool>((ref) {
  final taskRepository = ref.read(tasksRepositoryProvider);
  return JobDetailNotifier(taskRepository);
});

class JobDetailNotifier extends StateNotifier<bool> {
  final TaskRepository taskRepository;

  JobDetailNotifier(this.taskRepository) : super(false);

  Future<void> applyForJob(String taskId) async {
    state = true;
    await taskRepository.applyForTask(taskId);
    state = false;
  }
}
