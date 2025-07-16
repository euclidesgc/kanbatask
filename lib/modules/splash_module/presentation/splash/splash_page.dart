import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kanbatask/modules/auth_module/shared/presentation/cubits/auth_cubit.dart';

class SplashPage extends StatefulWidget {
  static Widget providerPageBuilder(BuildContext context, GoRouterState state) {
    return const SplashPage();
  }

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const Duration _minimumDisplayTime = Duration(
    seconds: 3,
  ); // ← Controle aqui

  bool _hasMinimumTimePassed = false;
  bool _hasAuthResolved = false;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _startMinimumTimer();
  }

  void _startMinimumTimer() {
    Future.delayed(_minimumDisplayTime, () {
      if (mounted) {
        setState(() {
          _hasMinimumTimePassed = true;
        });
        _tryNavigate();
      }
    });
  }

  void _tryNavigate() {
    // Só navega se ambas condições forem atendidas
    if (_hasMinimumTimePassed && _hasAuthResolved && !_hasNavigated) {
      _hasNavigated = true;
      final authState = context.read<AuthCubit>().state;

      log(
        '🚀 Splash navegando após ${_minimumDisplayTime.inSeconds}s com estado: $authState',
      );

      if (authState is AuthAuthenticated) {
        context.go('/home');
      } else if (authState is AuthUnauthenticated) {
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          log('💫 Splash - Auth mudou para: $state');

          // Marca que auth foi resolvido quando sai dos estados iniciais
          if (state is AuthAuthenticated || state is AuthUnauthenticated) {
            if (!_hasAuthResolved) {
              setState(() {
                _hasAuthResolved = true;
              });
              _tryNavigate();
            }
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo ou ícone do app
              Icon(
                Icons.task_alt,
                size: 100,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 24),
              Text(
                'KanbaTask',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 48),
              // Loading indicator
              CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 24),
              // Indicador de progresso opcional
              Text(
                'Carregando...',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
