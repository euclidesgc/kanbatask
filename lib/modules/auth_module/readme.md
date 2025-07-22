# Sistema de Autenticação KanbaTask

## Visão Geral

O sistema de autenticação do KanbaTask utiliza Firebase Auth, Provider, Bloc e GoRouter para controlar o fluxo de autenticação, redirecionamento de usuários e gerenciamento de sessão. Este guia mostra como replicar o sistema em outros apps Flutter, com exemplos de código completos focando no controle de navegação conforme o estado de autenticação.

---

## 1. Dependências

Adicione ao `pubspec.yaml`:

```yaml
dependencies:
  firebase_core: ^x.x.x
  firebase_auth: ^x.x.x
  provider: ^x.x.x
  flutter_bloc: ^x.x.x
  bloc: ^x.x.x
  go_router: ^x.x.x
  equatable: ^x.x.x
```

---

## 2. Inicialização do Firebase

No `main.dart`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    AppProviders(
      child: AppWidget(),
    ),
  );
}
```

---

## 3. Injeção de Dependências

Utilize o `Provider` para injetar datasources, repositories, usecases e cubits:

```dart
MultiProvider(
  providers: [
    Provider<LoginDataSource>(create: (_) => LoginDataSource()),
    Provider<LoginRepository>(
      create: (context) => LoginRepositoryImpl(
        loginDataSource: context.read<LoginDataSource>(),
      ),
    ),
    Provider<LoginUseCase>(
      create: (context) => LoginUseCase(
        context.read<LoginRepository>(),
      ),
    ),
    BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(
        sessionRepository: context.read<SessionRepository>(),
        loginUseCase: context.read<LoginUseCase>(),
        logoutUseCase: context.read<LogoutUseCase>(),
      ),
    ),
    // ... outros providers
  ],
  child: child,
)
```

---

## 4. Controle de Estado e Redirecionamento

### 4.1. Cubit de Autenticação

```dart
class AuthCubit extends Cubit<AuthState> {
  final SessionRepository sessionRepository;
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;

  AuthCubit({
    required this.sessionRepository,
    required this.loginUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase(email, password);
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await logoutUseCase();
    emit(AuthUnauthenticated());
  }

  void checkSession() {
    final user = sessionRepository.getCurrentUser();
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
```

### 4.2. Notificador para GoRouter

```dart
class AuthNotifier extends ChangeNotifier {
  AuthNotifier(AuthCubit authCubit) {
    authCubit.stream.listen((_) {
      notifyListeners();
    });
  }
}
```

### 4.3. Configuração das Rotas

```dart
class AppRoutes {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static GoRouter createAppRoutes(AuthCubit authCubit) {
    return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: '/splash',
      refreshListenable: AuthNotifier(authCubit),
      redirect: (BuildContext context, GoRouterState state) {
        final currentLocation = state.matchedLocation;
        final authState = authCubit.state;

        // Não redireciona da splash
        if (currentLocation == '/splash') {
          return null;
        }

        if (authState is AuthAuthenticated) {
          if (currentLocation == '/login' ||
              currentLocation == '/register' ||
              currentLocation == '/forgot-password') {
            return '/home';
          }
        }

        if (authState is AuthUnauthenticated) {
          if (currentLocation == '/home') {
            return '/login';
          }
        }

        return null;
      },
      routes: [
        SplashRoutes.route,
        ...AuthRoutes.routes,
        HomeRoutes.route,
      ],
    );
  }
}
```

---

## 5. Widget Principal

No `AppWidget`, obtenha o `AuthCubit` do contexto e crie o GoRouter:

```dart
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
```

---

## 6. Fluxo Completo do Usuário

1. **Inicialização**: Firebase é inicializado, Providers e Cubits são injetados.
2. **Navegação**: GoRouter controla as rotas conforme o estado do AuthCubit.
3. **Login/Registro/Recuperação**: Usuário interage com as telas, que usam os Cubits para disparar ações.
4. **Sessão**: AuthCubit mantém o estado de autenticação e notifica mudanças.
5. **Logout**: AuthCubit executa o logout e atualiza o estado.

---

## 7. Replicando em Outro App

1. Instale as dependências.
2. Configure o Firebase.
3. Crie as camadas: DataSource, Repository, UseCase, Cubit.
4. Implemente Providers e BlocProviders.
5. Configure rotas com GoRouter e AuthNotifier.
6. Implemente as telas de login, registro, recuperação e home.
7. Utilize o padrão Provider + Bloc para injeção e gerenciamento de estado.

---

## 8. Referências

- [Firebase Auth](https://firebase.flutter.dev/docs/auth/overview)
- [Provider](https://pub.dev/packages/provider)
- [Bloc](https://bloclibrary.dev/#/)
- [GoRouter](https://pub.dev/packages/go_router)

---

Este guia cobre o controle de navegação e direcionamento dos usuários conforme o estado de autenticação, com exemplos práticos para replicação em outros projetos Flutter.
