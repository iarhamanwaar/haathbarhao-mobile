import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/models/tasks_model.dart';
import 'package:haathbarhao_mobile/providers/tasks_repo_provider.dart';

final taskNotifierProvider =
    StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  final taskRepository = ref.watch(tasksRepositoryProvider);
  return TaskNotifier(taskRepository);
});

class TaskNotifier extends StateNotifier<List<Task>> {
  final TaskRepository taskRepository;
  List<Task> _allTasks = [];

  TaskNotifier(this.taskRepository) : super([]);

  Future<void> fetchTasks() async {
    try {
      final tasks = await taskRepository.getJobs();
      _allTasks = tasks;
      state = tasks;
    } catch (e) {
      // Handle the error
      state = [];
    }
  }

  void filterTasks(String query) {
    if (query.isEmpty) {
      state = _allTasks;
    } else {
      state = _allTasks
          .where((task) =>
              task.title!.toLowerCase().contains(query.toLowerCase()) ||
              task.description!.toLowerCase().contains(query.toLowerCase()) ||
              task.category!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
