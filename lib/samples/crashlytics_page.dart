import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CrashlyticsPage extends StatefulWidget {
  const CrashlyticsPage({super.key});

  @override
  State<CrashlyticsPage> createState() => _CrashlyticsPageState();
}

class _CrashlyticsPageState extends State<CrashlyticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crashlytics')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Teste Crashlytics'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Força um crash fatal
                throw Exception('Crash de teste!');
              },
              child: const Text('Forçar Crash Fatal'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Registra erro não fatal
                await FirebaseCrashlytics.instance.recordError(
                  Exception('Erro não fatal de teste!'),
                  StackTrace.current,
                  reason: 'Teste manual',
                );
                // Envia os relatórios pendentes imediatamente
                await FirebaseCrashlytics.instance.sendUnsentReports();
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Erro não fatal registrado e enviado!'),
                  ),
                );
              },
              child: const Text('Registrar Erro Não Fatal'),
            ),
          ],
        ),
      ),
    );
  }
}
