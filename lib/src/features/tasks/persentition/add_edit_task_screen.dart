import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids_tasks_manager/src/features/tasks/domain/task.dart';
import 'package:maids_tasks_manager/src/features/tasks/persentition/cubit/tasks_remote_cubit.dart';

@RoutePage()
class AddEditTaskScreen extends StatefulWidget {
  final Task? task;
  const AddEditTaskScreen({super.key, this.task});

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  late String _name;
  late String _job;

  @override
  void initState() {
    _name = widget.task == null ? "" : widget.task!.firstName;
    _job = widget.task == null ? "" : widget.task!.lastName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksRemoteCubit, TasksRemoteState>(
        listener: (context, state) {
      if (state is TasksRemoteSuccess) {
        context.maybePop();
        context.read<TasksRemoteCubit>().getRemoteTasks(0);
      } else if (state is TasksFailure) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.error)));
      }
    }, builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: Text(widget.task == null ? "Add Task" : "Edit Task"),
            leading: IconButton(
                onPressed: () {
                  if (widget.task != null) {
                    context.read<TasksRemoteCubit>().deleteTask(widget.task!);
                  }
                },
                icon: const Icon(Icons.delete)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _globalKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _name,
                      onSaved: (value) => _name = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: "Name"),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: _job,
                      onSaved: (value) => _job = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: "Job"),
                    ),
                    const SizedBox(height: 16),
                    state is TasksLoading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive())
                        : ElevatedButton(
                            onPressed: () {
                              _globalKey.currentState!.save();
                              if (_globalKey.currentState!.validate()) {
                                widget.task == null
                                    ? context
                                        .read<TasksRemoteCubit>()
                                        .addTask(_name, _job)
                                    : context
                                        .read<TasksRemoteCubit>()
                                        .editTask(_name, _job, widget.task!.id);
                              }
                            },
                            child: Text(widget.task == null ? "Add" : "Edit"))
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
