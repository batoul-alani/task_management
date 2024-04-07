import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids_tasks_manager/src/features/tasks/persentition/tasks_list_view.dart';
import 'package:maids_tasks_manager/src/routing/app_router.gr.dart';
import 'package:maids_tasks_manager/src/shared_cubits/app/app_cubit.dart';

@RoutePage()
class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Manager Screen"),
        leading: IconButton(
            onPressed: () {
              context.read<AppCubit>().setUnauthenticated();
            },
            icon: const Icon(
              Icons.logout,
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushRoute(AddEditTaskRoute());
        },
        child: const Icon(Icons.add),
      ),
      body: const TasksListView(),
    );
  }
}
