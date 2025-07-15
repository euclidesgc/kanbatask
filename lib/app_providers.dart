import 'package:flutter/material.dart';

import 'app_router.dart';

class AppProviders extends StatelessWidget with AppRouter {
  final Widget child;

  AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
    // return MultiProvider(
    //   providers: [],
    //   child: child,
    // );
  }
}
