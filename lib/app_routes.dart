import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'modules/auth_module/auth_routes.dart';
import 'modules/auth_module/cubit/auth_cubit.dart';
import 'modules/home_module/home_routes.dart';
import 'modules/splash_module/splash_routes.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthCubit _authCubit;

  AuthNotifier(this._authCubit) {
    _authCubit.stream.listen((_) {
      notifyListeners();
    });
  }
}

mixin AppRoutes {
  static final navigatorKey = GlobalKey<NavigatorState>();

  GoRouter createAppRoutes(AuthCubit authCubit) {
    final authNotifier = AuthNotifier(authCubit);

    return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: '/splash',
      refreshListenable: authNotifier,
      redirect: (context, state) {
        final authState = authCubit.state;

        final isAuthRoute =
            state.uri.toString().startsWith('/login') ||
            state.uri.toString().startsWith('/register') ||
            state.uri.toString().startsWith('/forgot-password');

        final isPublicRoute = [
          '/splash',
          '/login',
          '/register',
          '/forgot-password',
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
        ...AuthRoutes.routes,
        HomeRoutes.route,
      ],
    );
  }
}
