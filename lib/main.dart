import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:maids_tasks_manager/src/app.dart';
import 'package:maids_tasks_manager/src/features/tasks/persentition/cubit/tasks_remote_cubit.dart';
import 'package:maids_tasks_manager/src/injection_container.dart';
import 'package:maids_tasks_manager/src/shared_cubits/app/app_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(Phoenix(
      child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<AppCubit>()),
            BlocProvider(create: (_) => getIt<TasksRemoteCubit>()),
          ],
          child: const MainApp())));
}
