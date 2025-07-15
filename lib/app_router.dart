import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:kanbatask/modules/login_module/login_module.dart';
import 'package:kanbatask/modules/splash_module/splash_module.dart';

mixin AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  final appRoutes = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/splash',
    routes: [
      SplashModule.route,
      LoginModule.route,
    ],
  );
}
