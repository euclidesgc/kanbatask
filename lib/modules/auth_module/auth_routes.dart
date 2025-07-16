import 'package:go_router/go_router.dart';

import 'forgot_password/presentation/pages/forgot_password_page.dart';
import 'login/presentation/pages/login_page.dart';
import 'register/presentation/pages/register_page.dart';

class AuthRoutes {
  static List<GoRoute> get routes => [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: LoginPage.providerPageBuilder,
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: RegisterPage.providerPageBuilder,
    ),
    GoRoute(
      path: '/forgot-password',
      name: 'forgot-password',
      builder: ForgotPasswordPage.providerPageBuilder,
    ),
  ];
}
