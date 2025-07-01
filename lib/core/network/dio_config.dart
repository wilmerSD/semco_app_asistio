import 'package:dio/dio.dart';
import 'package:semco_app_asistio/core/environment/env.dart';
import 'package:semco_app_asistio/core/network/interceptors/logger_interceptor.dart';

class DioConfig {
  static Future<Dio> initialize() async {
     final dio = Dio(
        BaseOptions(
          baseUrl: Environment.appConfig["baseUrl"],
          connectTimeout: Duration(
            milliseconds: Environment.appConfig["connectTimeout"],
          ),
          receiveTimeout: Duration(
            milliseconds: Environment.appConfig["receiveTimeout"],
          ),
          responseType: ResponseType.json,
         
        ),
      );
      dio.interceptors.addAll([
          LoggerInterceptor(),
        ]);
      return dio;
  }
} 

/* class DioProvider {
  static Dio createDio() {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://api.example.com/', // Reemplaza con tu URL base
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
    dio.interceptors.add(LoggerInterceptor()); // Agrega tu interceptor
    return dio;
  }
}
 */