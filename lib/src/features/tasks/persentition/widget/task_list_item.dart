import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:maids_tasks_manager/src/features/tasks/domain/task.dart';
import 'package:maids_tasks_manager/src/routing/app_router.gr.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final bool fromServer;
  const TaskListItem({super.key, required this.task, required this.fromServer});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListTile(
          onTap: () {
            fromServer ? context.pushRoute(AddEditTaskRoute(task: task)) : null;
          },
          title: Text("${task.firstName}, ${task.lastName}"),
          subtitle: Text(task.email),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: task.avatar,
              width: 40,
              height: 40,
            ),
          )),
    );
  }
}
