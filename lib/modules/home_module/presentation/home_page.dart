import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  static Widget providerPageBuilder(BuildContext context, GoRouterState state) {
    return const HomePage();
  }

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text(
          'Welcome to the Home Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
