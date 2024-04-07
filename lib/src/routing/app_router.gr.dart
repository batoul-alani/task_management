// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:maids_tasks_manager/src/features/tasks/persentition/add_edit_task_screen.dart'
    as _i1;
import 'package:maids_tasks_manager/src/features/authantication/presentation/login_screen.dart'
    as _i2;
import 'package:maids_tasks_manager/src/features/splash/presentition/splash_screen.dart'
    as _i3;
import 'package:maids_tasks_manager/src/features/tasks/domain/task.dart' as _i7;
import 'package:maids_tasks_manager/src/features/tasks/persentition/tasks_screen.dart'
    as _i4;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    AddEditTaskRoute.name: (routeData) {
      final args = routeData.argsAs<AddEditTaskRouteArgs>(
          orElse: () => const AddEditTaskRouteArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddEditTaskScreen(
          key: args.key,
          task: args.task,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SplashScreen(),
      );
    },
    TasksRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.TasksScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddEditTaskScreen]
class AddEditTaskRoute extends _i5.PageRouteInfo<AddEditTaskRouteArgs> {
  AddEditTaskRoute({
    _i6.Key? key,
    _i7.Task? task,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          AddEditTaskRoute.name,
          args: AddEditTaskRouteArgs(
            key: key,
            task: task,
          ),
          initialChildren: children,
        );

  static const String name = 'AddEditTaskRoute';

  static const _i5.PageInfo<AddEditTaskRouteArgs> page =
      _i5.PageInfo<AddEditTaskRouteArgs>(name);
}

class AddEditTaskRouteArgs {
  const AddEditTaskRouteArgs({
    this.key,
    this.task,
  });

  final _i6.Key? key;

  final _i7.Task? task;

  @override
  String toString() {
    return 'AddEditTaskRouteArgs{key: $key, task: $task}';
  }
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SplashScreen]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.TasksScreen]
class TasksRoute extends _i5.PageRouteInfo<void> {
  const TasksRoute({List<_i5.PageRouteInfo>? children})
      : super(
          TasksRoute.name,
          initialChildren: children,
        );

  static const String name = 'TasksRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
