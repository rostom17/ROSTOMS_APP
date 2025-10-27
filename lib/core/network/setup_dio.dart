import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:rostoms_app/core/network/interceptors/logger_interceptor.dart';
import '/core/constants/api_constants.dart';

Dio getDioInstance() {
  BaseOptions dioOptions = BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    headers: {"content-type": "application/json"},
    connectTimeout: ApiConstants.connectionTimeOut,
    sendTimeout: ApiConstants.sendTimeout,
    receiveTimeout: ApiConstants.receiveTimeout,
  );

  final Dio dio = Dio(dioOptions);

  List<Interceptor> interceptors = [
    RetryInterceptor(
      dio: dio,
      retries: ApiConstants.maxRetries,
      retryDelays: ApiConstants.retryDelays,
    ),
    LoggerInterceptor(),
  ];
  dio.interceptors.addAll(interceptors);

  return dio;
}
