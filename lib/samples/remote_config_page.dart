import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class RemoteConfigPage extends StatefulWidget {
  const RemoteConfigPage({super.key});

  @override
  State<RemoteConfigPage> createState() => _RemoteConfigPageState();
}

class _RemoteConfigPageState extends State<RemoteConfigPage> {
  String _welcomeMessage = 'Carregando...';
  bool _loading = true;

  Future<void> _fetchRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ),
    );
    await remoteConfig.setDefaults({'welcome_message': 'Bem-vindo ao app!'});
    await remoteConfig.fetchAndActivate();
    setState(() {
      _welcomeMessage = remoteConfig.getString('welcome_message');
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchRemoteConfig();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Remote Config')),
    body: Center(
      child: _loading
          ? const CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_welcomeMessage, style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      setState(() => _loading = true);
                      _fetchRemoteConfig();
                    },
                    child: const Text('Atualizar Configuração Remota'),
                  ),
                ],
              ),
            ),
    ),
  );
}
