import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:maids_tasks_manager/src/shared_cubits/app/app_cubit.dart';
import 'package:maids_tasks_manager/src/routing/app_router.dart';
import 'package:maids_tasks_manager/src/theme/app_theme.dart';
import 'package:maids_tasks_manager/src/utils/app_constants.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) => Phoenix.rebirth(context),
        child: MaterialApp.router(
            routerConfig: _appRouter.config(),
            debugShowCheckedModeBanner: false,
            title: AppConstants.appTitle,
            theme: AppTheme.lightTheme()));
  }
}
