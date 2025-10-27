import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rostoms_app/core/services/service_locator.dart';
import 'package:rostoms_app/features/products/presentation/bloc/product_bloc.dart';

class BlocProviders {
  static List<BlocProvider> get blocProviders => [
    BlocProvider<ProductBloc>(create: (_)=> serviceLocator<ProductBloc>()),
  ];
}
