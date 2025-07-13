import 'package:flutter/material.dart';

class CrashlyticsPage extends StatelessWidget {
  const CrashlyticsPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Crashlytics')),
    body: const Center(child: Text('Teste Crashlytics')),
  );
}
