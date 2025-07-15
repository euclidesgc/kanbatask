import 'package:go_router/go_router.dart';

import 'login/presentation/pages/login_page.dart';

class LoginModule {
  static GoRoute get route => GoRoute(
    path: '/login',
    name: 'login',
    builder: LoginPage.providerPageBuilder,
  );
}
