import 'package:go_router/go_router.dart';
import 'package:rostoms_app/features/login/presentation/screen/login_screen.dart';
import 'package:rostoms_app/features/products/presentation/screens/products_list_screen.dart';

class AppRoutes {
  static const String loginScreen = "LoginScreen";
  static const String productScreen = "ProductScreen";

  static GoRouter router = GoRouter(
    initialLocation: "/productScreen",
    routes: <RouteBase>[
      GoRoute(
        path: "/productScreen",
        name: productScreen,
        builder: (context, state) => ProductsListScreen(),
      ),

      GoRoute(
        path: "/loginScreen",
        name: loginScreen,
        builder: (context, state) => LoginScreen(),
      ),
    ],
  );
}
