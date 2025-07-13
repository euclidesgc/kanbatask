import 'package:flutter/material.dart';
import 'package:kanbatask/samples/analytics_page.dart';
import 'package:kanbatask/samples/authentication_page.dart';
import 'package:kanbatask/samples/connectivity_page.dart';
import 'package:kanbatask/samples/crashlytics_page.dart';
import 'package:kanbatask/samples/projects_page.dart';
import 'package:kanbatask/samples/remote_config_page.dart';
import 'package:kanbatask/samples/storage_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KanbaTask - Testes')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AuthenticationPage()),
            ),
            child: const Text('Testar Autenticação'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProjectsPage()),
            ),
            child: const Text('Testar Firestore (Projetos)'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StoragePage()),
            ),
            child: const Text('Testar Storage'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AnalyticsPage()),
            ),
            child: const Text('Testar Analytics'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RemoteConfigPage()),
            ),
            child: const Text('Testar Remote Config'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CrashlyticsPage()),
            ),
            child: const Text('Testar Crashlytics'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ConnectivityPage()),
            ),
            child: const Text('Testar Conectividade'),
          ),
        ],
      ),
    );
  }
}
