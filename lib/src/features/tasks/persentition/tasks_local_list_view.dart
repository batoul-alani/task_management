import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids_tasks_manager/src/features/tasks/persentition/cubit/tasks_local_cubit.dart';
import 'package:maids_tasks_manager/src/features/tasks/persentition/widget/task_list_item.dart';

class TasksLocalListView extends StatefulWidget {
  const TasksLocalListView({super.key});

  @override
  State<TasksLocalListView> createState() => _TasksLocalListViewState();
}

class _TasksLocalListViewState extends State<TasksLocalListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksLocalCubit, TasksLocalState>(
        builder: (context, state) {
      return state is TasksLocalSuccess
          ? ListView.separated(
              itemCount: state.tasks.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) =>
                  TaskListItem(task: state.tasks[index], fromServer: false,),
            )
          : state is TasksLocalLoading
              ? const Center(child: CircularProgressIndicator.adaptive())
              : state is TasksLocalFailure
                  ? Text(state.error)
                  : const SizedBox.shrink();
    });
  }
}
