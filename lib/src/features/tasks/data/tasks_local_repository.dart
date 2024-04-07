import 'package:maids_tasks_manager/src/features/tasks/domain/task.dart';
import 'package:maids_tasks_manager/src/network/network_service.dart';
import 'package:sqflite/sqflite.dart';

class TasksLocalRepository {
  final Database database;
  TasksLocalRepository({required this.database});

  Future<List<Task>> getRemoteTasks() async {
    try {
      final List<Map<String, dynamic>> maps = await database.query("task");
      final List<Task> tasks =
          List.generate(maps.length, (index) => Task.fromMap(maps[index]));
      return tasks;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  Future<List<Task>> insertTasks(List<Task> tasks) async {
    try {
      // Delete all tasks in case there are some tasks deleted from server and has been stored on local
      await _deleteTasks();

      // Insert tasks to the empty database
      for (Task task in tasks) {
        await _inserTask(task);
      }
      return await getRemoteTasks();
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  Future<void> _deleteSingleItem(Task task) async {
    await database.rawDelete("DELETE FROM task WHERE id = ? ", [task.id]);
  }

  Future<void> _inserTask(Task task) async {
    await database.insert("task", task.toMap());
  }

  Future<void> _deleteTasks() async {
    List<Task> tasks = await getRemoteTasks();
    for (Task task in tasks) {
      await _deleteSingleItem(task);
    }
  }
}
