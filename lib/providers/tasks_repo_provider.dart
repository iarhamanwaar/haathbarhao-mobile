import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/models/tasks_model.dart';
import 'api_provider.dart';

final tasksRepositoryProvider = StateProvider((ref) {
  final apiService = ref.read(apiProvider);

  return TaskRepository(apiService, ref);
});

class TaskRepository {
  late APIService apiService;
  final Ref ref;

  TaskRepository(this.apiService, this.ref);

  Future<Task> postTask({
    required String title,
    required String description,
    required String category,
    required String location,
    required DateTime date,
    List<String>? pictures,
  }) async {
    try {
      final body = jsonEncode({
        "title": title,
        "description": description,
        "category": category,
        "location": location,
        "date": date,
        if (pictures != null) "pictures": pictures,
      });

      final response = await apiService.post(
        endpoint: '/api/tasks/',
        body: body,
      );

      if (response.statusCode == 200) {
        final task =
            taskFromJson(jsonEncode(jsonDecode(response.data)['data']));

        return task;
      } else {
        log(jsonDecode(response.data)['message']);
        throw jsonDecode(response.data)['message'];
      }
    } catch (e) {
      log(jsonDecode(e.toString()));
      throw jsonDecode(e.toString());
    }
  }

  Future<List<Task>> getTasks(String status) async {
    try {
      final response = await apiService.get(
        endpoint: '/api/users/tasks?status=$status',
      );

      if (response.statusCode == 200) {
        final tasks =
            tasksFromJson(jsonEncode(jsonDecode(response.data)['data']));

        return tasks;
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
