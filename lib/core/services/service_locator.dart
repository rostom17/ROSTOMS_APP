import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rostoms_app/features/products/presentation/bloc/product_bloc.dart';
import '../network/connectivity/connectivity_checker.dart';
import '../network/errors/default_error_mapper.dart';
import '../network/errors/error_mapper.dart';
import '../network/network_executor.dart';
import '../network/setup_dio.dart';

import 'package:rostoms_app/features/products/data/data_sources/product_remote_data_source.dart';
import 'package:rostoms_app/features/products/data/data_sources/product_remote_data_source_impl.dart';
import 'package:rostoms_app/features/products/data/repositories/product_repository_impl.dart';
import 'package:rostoms_app/features/products/domain/repositories/product_repository.dart';
import 'package:rostoms_app/features/products/domain/usecases/fetch_products_usecase.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  //network management instances
  serviceLocator.registerSingleton<Dio>(getDioInstance());
  serviceLocator.registerSingleton<ConnectivityChecker>(ConnectivityChecker());
  serviceLocator.registerSingleton<ErrorMapper>(DefaultErrorMapper());
  serviceLocator.registerSingleton(
    NetworkExecutor(
      dio: serviceLocator<Dio>(),
      connectivityChecker: serviceLocator<ConnectivityChecker>(),
      errorMapper: serviceLocator<ErrorMapper>(),
    ),
  );

  //data source instances
  serviceLocator.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(
      networkExecutor: serviceLocator<NetworkExecutor>(),
    ),
  );

  //repository instances
  serviceLocator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      productRemoteDataSource: serviceLocator<ProductRemoteDataSource>(),
    ),
  );

  //usecase instances
  serviceLocator.registerLazySingleton(
    () => FetchProductsUsecase(
      productRepository: serviceLocator<ProductRepository>(),
    ),
  );

  //Bloc instances
  serviceLocator.registerFactory<ProductBloc>(
    () => ProductBloc(
      getLimitedProductsUsecase: serviceLocator<FetchProductsUsecase>(),
    ),
  );
}
