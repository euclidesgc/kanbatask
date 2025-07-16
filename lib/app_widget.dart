import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_routes.dart';
import 'modules/auth_module/cubit/auth_cubit.dart';

class AppWidget extends StatelessWidget with AppRoutes {
  AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return MaterialApp.router(
      title: 'KanbaTask',
      debugShowCheckedModeBanner: false,
      routerConfig: createAppRoutes(authCubit),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
