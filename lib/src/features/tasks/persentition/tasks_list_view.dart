import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:maids_tasks_manager/src/features/tasks/domain/task.dart';
import 'package:maids_tasks_manager/src/features/tasks/persentition/cubit/tasks_local_cubit.dart';
import 'package:maids_tasks_manager/src/features/tasks/persentition/cubit/tasks_remote_cubit.dart';
import 'package:maids_tasks_manager/src/features/tasks/persentition/tasks_local_list_view.dart';
import 'package:maids_tasks_manager/src/features/tasks/persentition/widget/task_list_item.dart';

class TasksListView extends StatefulWidget {
  const TasksListView({super.key});

  @override
  State<TasksListView> createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {
  final PagingController<int, Task> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    context.read<TasksRemoteCubit>().getRemoteTasks(0);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    final tasksRemoteCubit = context.read<TasksRemoteCubit>();
    await tasksRemoteCubit.getRemoteTasks(pageKey);

    if (tasksRemoteCubit.state is TasksRemoteSuccess) {
      final tasksRemoteSuccess = (tasksRemoteCubit.state as TasksRemoteSuccess);

      if (tasksRemoteSuccess.isLastPage) {
        _pagingController.appendLastPage(tasksRemoteSuccess.tasks);
      } else {
        final nextPageKey = tasksRemoteSuccess.page + 1;
        _pagingController.appendPage(tasksRemoteSuccess.tasks, nextPageKey);
      }
    }
    if (tasksRemoteCubit.state is TasksRemoteFailure) {
      _pagingController.error =
          (tasksRemoteCubit.state as TasksRemoteFailure).error;
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TasksRemoteCubit, TasksRemoteState>(
          builder: (context, state) {
        return state is TasksLoading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : state is TasksFailure
                ? Center(child: Text(state.error))
                : state is TasksRemoteSuccess
                    ? PagedListView<int, Task>(
                        pagingController: _pagingController,
                        builderDelegate: PagedChildBuilderDelegate<Task>(
                          itemBuilder: (context, item, index) => TaskListItem(
                            task: item,
                            fromServer: true,
                          ),
                        ),
                      )
                    : state is TasksRemoteFailure
                        ? BlocProvider(
                            create: (_) => TasksLocalCubit()..getLocalTasks(),
                            child: const TasksLocalListView())
                        : const SizedBox.shrink();
      });

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
