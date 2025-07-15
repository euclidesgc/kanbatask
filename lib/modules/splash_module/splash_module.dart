import 'package:go_router/go_router.dart';
import 'package:kanbatask/modules/splash_module/presentation/splash/splash_page.dart';

class SplashModule {
  static GoRoute get route => GoRoute(
    path: '/splash',
    name: 'splash',
    builder: SplashPage.providerPageBuilder,
    routes: [],
  );
}
