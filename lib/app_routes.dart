import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:kanbatask/modules/auth_module/shared/presentation/cubits/auth_cubit.dart';

import 'modules/auth_module/auth_routes.dart';
import 'modules/home_module/home_routes.dart';
import 'modules/splash_module/splash_routes.dart';

class AuthNotifier extends ChangeNotifier {
  AuthNotifier(AuthCubit authCubit) {
    authCubit.stream.listen((_) {
      notifyListeners();
    });
  }
}

class AppRoutes {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static GoRouter createAppRoutes(AuthCubit authCubit) {
    return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: '/splash',
      refreshListenable: AuthNotifier(authCubit),
      redirect: (BuildContext context, GoRouterState state) {
        final currentLocation = state.matchedLocation;
        final authState = authCubit.state;

        log('🚦 Redirect - Location: $currentLocation, Auth: $authState');

        // IMPORTANTE: Não redirecionar DA splash - ela controla sua própria navegação
        if (currentLocation == '/splash') {
          return null; // Deixa splash decidir quando sair
        }

        if (authState is AuthAuthenticated) {
          if (currentLocation == '/login' ||
              currentLocation == '/register' ||
              currentLocation == '/forgot-password') {
            return '/home';
          }
        }

        // Se não está autenticado e tentando acessar home, redireciona para login
        if (authState is AuthUnauthenticated) {
          if (currentLocation == '/home') {
            return '/login';
          }
        }

        return null; // Não redirecionar
      },
      routes: [
        SplashRoutes.route,
        ...AuthRoutes.routes,
        HomeRoutes.route,
      ],
    );
  }
}
