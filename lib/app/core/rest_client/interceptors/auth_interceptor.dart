import 'dart:developer';

import 'package:dio/dio.dart';

import '../../global/env.dart';
import '../../global/global_context.dart';
import '../../global/local_storage_utils.dart';

class AuthInterceptor extends Interceptor {
  final Dio dioRefreshToken = Dio(
    BaseOptions(
      baseUrl: Env.apiUrl,
      connectTimeout: const Duration(seconds: 90),
      receiveTimeout: const Duration(seconds: 90),
      sendTimeout: const Duration(seconds: 90),
      receiveDataWhenStatusError: true,
    ),
  );

  AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    log('[onRequest] /"${options.uri}"', name: options.method);

    try {
      final String token = await LocalStorageUtils.getAccessToken();
      final bool pathIsNotLogin = !options.path.contains('auth/login');

      if (token.isNotEmpty && pathIsNotLogin) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      log('Error fetching token: ${e.toString()}');
    }

    super.onRequest(options, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    log('[${err.requestOptions.method}] /"${err.requestOptions.uri}"', name: 'onError - ${err.response?.statusCode}');

    try {
      final response = err.response;

      if (response?.statusCode == 401 && !response!.realUri.path.contains('auth/login')) {
        final refreshed = await _refreshToken();

        if (refreshed) {
          // Se o token fou atualizado, adiciona o novo token ao cabeçalho
          final token = await LocalStorageUtils.getAccessToken();
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer $token';

          // Refaz a requisição original com o novo token
          final cloneReq = await dioRefreshToken.request(
            opts.path,
            options: Options(method: opts.method, headers: opts.headers),
            data: opts.data,
            queryParameters: opts.queryParameters,
          );
          return handler.resolve(cloneReq);
        } else {
          await GlobalContext.instance.loginExpire();
          handler.next(err);
        }
      } else {
        handler.next(err);
      }
    } catch (e) {
      log('Erro durante a tentativa de atualizar os tokens(access refresh): ${e.toString()}');
    }

    super.onError(err, handler);
  }

  Future<bool> _refreshToken() async {
    try {
      final String refreshToken = await LocalStorageUtils.getRefreshToken();

      if (refreshToken.isNotEmpty) {
        final response = await dioRefreshToken.post('/auth/refresh-token', data: {'refreshToken': refreshToken});
        if (response.statusCode == 200) {
          final access = response.data['token'];
          final refresh = response.data['refreshToken'];

          await LocalStorageUtils.saveTokens(accessToken: access, refreshToken: refresh);
          return true;
        }
      }
    } catch (e) {
      log('Error during token refresh request: ${e.toString()}');
    }

    await LocalStorageUtils.clean();
    return false;
  }
}
