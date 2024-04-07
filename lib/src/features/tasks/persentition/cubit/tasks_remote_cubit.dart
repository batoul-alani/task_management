import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maids_tasks_manager/src/features/tasks/data/tasks_repository.dart';
import 'package:maids_tasks_manager/src/features/tasks/domain/task.dart';
import 'package:maids_tasks_manager/src/features/tasks/persentition/cubit/tasks_local_cubit.dart';
import 'package:maids_tasks_manager/src/injection_container.dart';

part 'tasks_remote_state.dart';

class TasksRemoteCubit extends Cubit<TasksRemoteState> {
  TasksRemoteCubit() : super(TasksInitial());

  final int pageSize = 6;

  Future<void> getRemoteTasks(int page) async {
    if (page == 0) emit(TasksLoading());
    try {
      final newItems = await getIt<TaskRepository>().getTasks(page);
      if (page == 0) {
        getIt<TasksLocalCubit>().insertTasks(newItems.data);
      }
      final isLastPage = newItems.data.length < pageSize;
      emit(TasksRemoteSuccess(
          tasks: newItems.data, isLastPage: isLastPage, page: page));
    } catch (error) {
      emit(TasksRemoteFailure(error: error.toString()));
    }
  }

  Future<void> deleteTask(Task task) async {
    final previusState = state;
    emit(TasksLoading());
    try {
      await getIt<TaskRepository>().deleteTask(task.id);

      emit(TasksRemoteSuccess(
          isLastPage: (previusState as TasksRemoteSuccess).isLastPage,
          page: previusState.page,
          tasks: previusState.tasks
              .where((element) => element.id != task.id)
              .toList()));
    } catch (e) {
      emit(TasksFailure(error: e.toString()));
    }
  }

  Future<void> addTask(String name, String job) async {
    final previusState = state;
    emit(TasksLoading());
    try {
      final task = await getIt<TaskRepository>().addTask(name, job);

      emit(TasksRemoteSuccess(
          tasks: [...(previusState as TasksRemoteSuccess).tasks, task],
          page: previusState.page,
          isLastPage: previusState.isLastPage));
    } catch (e) {
      emit(TasksFailure(error: e.toString()));
    }
  }

  Future<void> editTask(String name, String job, int taskId) async {
    final previusState = state;
    emit(TasksLoading());
    try {
      final newTask = await getIt<TaskRepository>().editTask(name, job, taskId);
      emit(TasksRemoteSuccess(tasks: [
        for (final task in (previusState as TasksRemoteSuccess).tasks)
          if (task.id == taskId) newTask else task
      ], page: previusState.page, isLastPage: previusState.isLastPage));
    } catch (e) {
      emit(TasksFailure(error: e.toString()));
    }
  }
}
