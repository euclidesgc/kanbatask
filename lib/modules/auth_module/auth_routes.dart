import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'login/presentation/pages/login_page.dart';

class AuthRoutes {
  static GoRoute get route => GoRoute(
    path: '/login',
    name: 'login',
    builder: LoginPage.providerPageBuilder,
    routes: [
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const Scaffold(
          body: Center(
            child: Text('Register Page - Em construção'),
          ),
        ),
      ),
    ],
  );
}
