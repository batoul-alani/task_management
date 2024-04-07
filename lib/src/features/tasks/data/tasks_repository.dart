import 'package:dio/dio.dart';
import 'package:maids_tasks_manager/src/common_models/app_response.dart';
import 'package:maids_tasks_manager/src/constants/end_points.dart';
import 'package:maids_tasks_manager/src/features/tasks/domain/task.dart';
import 'package:maids_tasks_manager/src/network/network_service.dart';

class TaskRepository {
  late NetworkService<Response> networkService;
  TaskRepository({required this.networkService});

  Future<AppResponse<List<Task>>> getTasks(int page) async {
    Map<String, dynamic> params = {"page": page};

    final data = await networkService.get(
        endpoint: Endpoints.getTasks, queryParameters: params);
    if (data.statusCode != 200) {
      throw AppException(data.statusMessage);
    }

    final AppResponse<List<Task>> appResponse = AppResponse.fromMap(
        data.data, (json) => List<Task>.from(json.map((x) => Task.fromMap(x))));

    return appResponse;
  }

  Future<void> deleteTask(int taskId) async {
    final data =
        await networkService.delete(endpoint: "${Endpoints.getTasks}/$taskId");
    if (data.statusCode != 204) {
      throw AppException(data.statusMessage);
    }

    return;
  }

  Future<Task> addTask(String name, String job) async {
    Map<String, dynamic> fields = {
      "name": name,
      "job": job,
    };

    final Response data =
        await networkService.post(endpoint: Endpoints.getTasks, data: fields);

    if (data.statusCode != 201) {
      throw AppException(data.statusMessage);
    }
    final Task task = Task.fromEditMap(data.data);

    return task;
  }

  Future<Task> editTask(String name, String job, int taskId) async {
    Map<String, dynamic> fields = {
      "name": name,
      "job": job,
    };

    final Response data = await networkService.put(
        endpoint: "${Endpoints.getTasks}/$taskId", data: fields);

    if (data.statusCode != 200) {
      throw AppException(data.statusMessage);
    }
    final task  = Task.fromEditMap(data.data);
    return task;
  }
}
