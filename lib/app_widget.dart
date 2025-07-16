import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';
import 'modules/auth_module/cubit/auth_cubit.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    final authCubit = context.read<AuthCubit>();
    _router = AppRoutes.createAppRoutes(authCubit);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'KanbaTask',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
