import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rostoms_app/core/routes/app_routes.dart';
import 'package:rostoms_app/core/services/bloc_providers.dart';
import 'package:rostoms_app/core/theme/app_theme.dart';
import 'core/services/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const RostomsApp());
}

class RostomsApp extends StatelessWidget {
  const RostomsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviders.blocProviders,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes.router,
        theme: AppTheme.lightTheme(),
      ),
    );
  }
}
