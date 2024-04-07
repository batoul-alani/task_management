part of 'tasks_remote_cubit.dart';

sealed class TasksRemoteState extends Equatable {
  const TasksRemoteState();
}

final class TasksInitial extends TasksRemoteState {
  @override
  List<Object?> get props => [];
}

final class TasksLoading extends TasksRemoteState {
  @override
  List<Object?> get props => [];
}

final class TasksRemoteSuccess extends TasksRemoteState {
  final List<Task> tasks;
  final bool isLastPage;
  final int page;
  const TasksRemoteSuccess(
      {required this.tasks, required this.isLastPage, required this.page});

  @override
  List<Object?> get props => [tasks, isLastPage, page];
}

final class TasksRemoteFailure extends TasksRemoteState {
  final String error;
  const TasksRemoteFailure({required this.error});

  @override
  List<Object?> get props => throw UnimplementedError();
}

final class TasksFailure extends TasksRemoteState {
  final String error;
  const TasksFailure({required this.error});

  @override
  List<Object?> get props => throw UnimplementedError();
}
