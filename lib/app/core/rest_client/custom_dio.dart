import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../global/env.dart';
import 'interceptors/auth_interceptor.dart';

class CustomDio extends DioForNative {
  CustomDio()
    : super(
        BaseOptions(
          baseUrl: Env.apiUrl,
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 60),
          receiveDataWhenStatusError: true,
        ),
      ) {
    interceptors.add(AuthInterceptor());
  }
}
