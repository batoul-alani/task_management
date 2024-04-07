part of 'tasks_local_cubit.dart';

sealed class TasksLocalState extends Equatable {
  const TasksLocalState();

  @override
  List<Object> get props => [];
}

final class TasksLocalInitial extends TasksLocalState {}

final class TasksLocalLoading extends TasksLocalState {}

final class TasksLocalSuccess extends TasksLocalState {
  final List<Task> tasks;
  const TasksLocalSuccess({required this.tasks});
}

final class TasksLocalFailure extends TasksLocalState {
  final String error;
  const TasksLocalFailure({required this.error});
}
