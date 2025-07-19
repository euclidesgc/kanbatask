import 'package:go_router/go_router.dart';
import 'package:kanbatask/modules/home_module/presentation/home_page.dart';

class HomeRoutes {
  static GoRoute get route => GoRoute(
    path: '/home',
    name: 'home',
    builder: HomePage.providerPageBuilder,
  );
}
