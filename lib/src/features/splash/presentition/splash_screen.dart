import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids_tasks_manager/src/routing/app_router.gr.dart';
import 'package:maids_tasks_manager/src/shared_cubits/app/app_cubit.dart';
import 'package:maids_tasks_manager/src/theme/app_colors.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final appCubit = context.read<AppCubit>();

    final state = appCubit.state;
    if (state is Authenticated) {
      context.replaceRoute(const TasksRoute());
    } else {
      context.replaceRoute(const LoginRoute());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      color: AppColors.whiteSmoke,
    ));
  }
}
