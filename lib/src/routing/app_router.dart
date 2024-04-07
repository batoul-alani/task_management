import 'package:auto_route/auto_route.dart';
import 'package:maids_tasks_manager/src/routing/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: TasksRoute.page),
        AutoRoute(page: AddEditTaskRoute.page),
      ];
}
