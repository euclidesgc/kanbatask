import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'modules/auth_module/auth_routes.dart';
import 'modules/auth_module/cubit/auth_cubit.dart';
import 'modules/home_module/home_routes.dart';
import 'modules/splash_module/splash_routes.dart';

mixin AppRoutes {
  static final navigatorKey = GlobalKey<NavigatorState>();

  final appRoutes = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/splash',
    redirect: (context, state) {
      final authCubit = context.read<AuthCubit>();
      final authState = authCubit.state;

      final isAuthRoute =
          state.uri.toString().startsWith('/login') ||
          state.uri.toString().startsWith('/register');

      final isPublicRoute = [
        '/splash',
        '/login',
        '/register',
      ].contains(state.uri.toString());

      if (authState is AuthInitial || authState is AuthInProgress) {
        return null;
      }


      if (authState is AuthUnauthenticated && !isPublicRoute) {
        return '/login';
      }


      if (authState is AuthAuthenticated && isAuthRoute) {
        return '/home';
      }

      return null;
    },
    routes: [
      SplashRoutes.route,
      AuthRoutes.route,
      HomeRoutes.route,
    ],
  );
}
