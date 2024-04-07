import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maids_tasks_manager/src/features/tasks/data/tasks_local_repository.dart';
import 'package:maids_tasks_manager/src/features/tasks/domain/task.dart';
import 'package:maids_tasks_manager/src/injection_container.dart';

part 'tasks_local_state.dart';

class TasksLocalCubit extends Cubit<TasksLocalState> {
  TasksLocalCubit() : super(TasksLocalInitial());

  Future<void> getLocalTasks() async {
    try {
      final data = await getIt<TasksLocalRepository>().getRemoteTasks();
      emit(TasksLocalSuccess(tasks: data));
    } catch (e) {
      emit(TasksLocalFailure(error: e.toString()));
    }
  }

  Future<void> insertTasks(List<Task> tasks) async {
    await getIt<TasksLocalRepository>().insertTasks(tasks);
  }
}
