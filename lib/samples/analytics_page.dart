import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  void _sendEvent(String name, Map<String, Object> parameters) {
    FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: parameters,
    );
  }

  // Exemplo de uso dos principais métodos do Firebase Analytics
  // Cada método tem um objetivo específico e pode ser útil para o contexto de um gerenciador de tarefas

  /// Registra o login do usuário
  Future<void> _logLogin() async {
    await FirebaseAnalytics.instance.logLogin(loginMethod: 'email');
  }

  /// Registra o cadastro de um novo usuário
  Future<void> _logSignUp() async {
    await FirebaseAnalytics.instance.logSignUp(signUpMethod: 'email');
  }

  /// Registra a visualização de uma tela específica
  Future<void> _logScreenView() async {
    await FirebaseAnalytics.instance.logScreenView(
      screenName: 'Dashboard',
      screenClass: 'DashboardPage',
    );
  }

  /// Registra a criação de uma nova tarefa (evento customizado)
  Future<void> _logCreateTask() async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'create_task',
      parameters: {'priority': 'alta', 'project': 'Projeto X'},
    );
  }

  /// Registra a conclusão de um tutorial
  Future<void> _logTutorialComplete() async {
    await FirebaseAnalytics.instance.logTutorialComplete();
  }

  /// Registra a conclusão de uma tarefa (evento customizado)
  Future<void> _logCompleteTask() async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'complete_task',
      parameters: {'task_id': '42', 'completed_by': 'user123'},
    );
  }

  /// Registra a visualização de uma lista de tarefas
  Future<void> _logViewItemList() async {
    await FirebaseAnalytics.instance.logViewItemList(
      itemListId: 'tasks_today',
      itemListName: 'Tarefas de Hoje',
      items: [
        AnalyticsEventItem(itemId: '1', itemName: 'Reunião'),
        AnalyticsEventItem(itemId: '2', itemName: 'Revisar código'),
      ],
    );
  }

  /// Registra a seleção de uma tarefa na lista
  Future<void> _logSelectItem() async {
    await FirebaseAnalytics.instance.logSelectItem(
      itemListId: 'tasks_today',
      itemListName: 'Tarefas de Hoje',
      items: [
        AnalyticsEventItem(itemId: '1', itemName: 'Reunião'),
      ],
    );
  }

  /// Registra a definição de uma propriedade do usuário (ex: cargo)
  Future<void> _setUserProperty() async {
    await FirebaseAnalytics.instance.setUserProperty(
      name: 'role',
      value: 'manager',
    );
  }

  @override
  Widget build(BuildContext context) {
    // Envia evento ao abrir a página
    FirebaseAnalytics.instance.logEvent(
      name: 'analytics_page_opened',
      parameters: {'timestamp': DateTime.now().toIso8601String()},
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Teste Analytics'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _logLogin,
                child: const Text('Log Login (login do usuário)'),
              ),
              ElevatedButton(
                onPressed: _logSignUp,
                child: const Text('Log SignUp (cadastro de usuário)'),
              ),
              ElevatedButton(
                onPressed: _logScreenView,
                child: const Text('Log ScreenView (visualização de tela)'),
              ),
              ElevatedButton(
                onPressed: _logCreateTask,
                child: const Text('Log Create Task (criação de tarefa)'),
              ),
              ElevatedButton(
                onPressed: _logCompleteTask,
                child: const Text('Log Complete Task (conclusão de tarefa)'),
              ),
              ElevatedButton(
                onPressed: _logTutorialComplete,
                child: const Text(
                  'Log Tutorial Complete (tutorial finalizado)',
                ),
              ),
              ElevatedButton(
                onPressed: _logViewItemList,
                child: const Text('Log View Item List (lista de tarefas)'),
              ),
              ElevatedButton(
                onPressed: _logSelectItem,
                child: const Text('Log Select Item (seleção de tarefa)'),
              ),
              ElevatedButton(
                onPressed: _setUserProperty,
                child: const Text('Set User Property (cargo do usuário)'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () =>
                    _sendEvent('custom_event', {'info': 'personalizado'}),
                child: const Text('Custom Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
