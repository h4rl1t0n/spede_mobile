import 'dart:developer';

import 'package:dio/dio.dart';

import '../../global/env.dart';
import '../../global/global_context.dart';
import '../../global/local_storage_utils.dart';
import '../error/response_code.dart';

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
    log('\x1B[2J\x1B[0;0H');
    log('[onRequest] /"${options.uri}"', name: options.method);

    try {
      final String token = await LocalStorageUtils.getAccessToken();
      final bool pathIsNotLogin = !options.path.contains('login');

      log('Antes => Headers: ${options.headers}');

      if (token.isNotEmpty && pathIsNotLogin) {
        options.headers['x-auth-token'] = token;
      }

      log('Depois => Headers: ${options.headers}');
    } catch (e) {
      log('Error fetching token: ${e.toString()}');
    }

    super.onRequest(options, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;
    final statusCode = err.response?.statusCode;

    log('[${requestOptions.method}] /"${requestOptions.uri}"', name: 'onError - $statusCode');

    try {
      final unauthorized = ResponseCode.unauthorized;
      final path = err.response!.realUri.path;

      if (statusCode == unauthorized.code && !path.contains('login')) {
        await GlobalContext.instance.loginExpire();
        handler.next(err);

        // final refreshed = await _refreshToken();

        // if (refreshed) {
        //   // Se o token fou atualizado, adiciona o novo token ao cabeçalho
        //   final token = await LocalStorageUtils.getAccessToken();
        //   final opts = err.requestOptions;
        //   opts.headers['x-auth-token'] = token;

        //   // Refaz a requisição original com o novo token
        //   final cloneReq = await dioRefreshToken.request(
        //     opts.path,
        //     options: Options(method: opts.method, headers: opts.headers),
        //     data: opts.data,
        //     queryParameters: opts.queryParameters,
        //   );
        //   return handler.resolve(cloneReq);
        // } else {
        //   await GlobalContext.instance.loginExpire();
        //   handler.next(err);
        // }
      } else {
        handler.next(err);
      }
    } catch (e) {
      log('Erro durante a tentativa de atualizar os tokens(access refresh): ${e.toString()}');
    }

    super.onError(err, handler);
  }

  // Future<bool> _refreshToken() async {
  //   try {
  //     final String refreshToken = await LocalStorageUtils.getRefreshToken();

  //     if (refreshToken.isNotEmpty) {
  //       final response = await dioRefreshToken.post('/auth/refresh-token', data: {'refreshToken': refreshToken});
  //       if (response.statusCode == 200) {
  //         final access = response.data['token'];
  //         final refresh = response.data['refreshToken'];

  //         await LocalStorageUtils.saveTokens(accessToken: access, refreshToken: refresh);
  //         return true;
  //       }
  //     }
  //   } catch (e) {
  //     log('Error during token refresh request: ${e.toString()}');
  //   }

  //   await LocalStorageUtils.clean();
  //   return false;
  // }
}
