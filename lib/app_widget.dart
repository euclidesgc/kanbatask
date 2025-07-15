import 'package:flutter/material.dart';

import 'app_router.dart';

class AppWidget extends StatelessWidget with AppRouter {
  AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'KanbaTask',
      debugShowCheckedModeBanner: false,
      routerConfig: appRoutes,
      builder: (context, child) {
        // Exemplo de listener global de autenticação
        // return BlocListener<AuthCubit, AuthState>(
        //   listener: (context, state) {
        //     // Lógica de navegação e toasts
        //   },
        //   child: child,
        // );
        return child!;
      },
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      // Adicione localizações e temas customizados se necessário
    );
  }
}
