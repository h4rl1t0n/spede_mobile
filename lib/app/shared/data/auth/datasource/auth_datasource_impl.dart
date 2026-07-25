import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/global/local_storage_utils.dart';
import '../../../../core/rest_client/error/dio_failure.dart';
import '../../../../core/rest_client/error/message_error.dart';
import '../dto/auth_request_dto.dart';
import '../dto/auth_response_dto.dart';
import 'auth_datasource.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final DioForNative client;

  AuthDatasourceImpl(this.client);

  @override
  Future<Result<bool, Failure>> login({required AuthRequestDto auth}) async {
    try {
      final response = await client.post('login', data: auth.toJson());

      if (response.statusCode == 200) {
        final accessToken = response.headers.value('x-auth-token') ?? '';
        final user = AuthResponseDto.fromMap(response.data).toModel();

        log(accessToken);
        log(user.toString());

        await LocalStorageUtils.saveUser(user: user);
        await LocalStorageUtils.saveTokens(accessToken: accessToken);
        return Success(true);
      }

      if (response.statusCode == 401) {
        final message = response.data['errors'] ?? 'Usuário ou senha inválidos!';
        return Error(DioFailure(message: message, statusCode: response.statusCode));
      }

      return Error(DioFailure(message: 'Erro ao fazer login, tente novamente!', statusCode: 404));
    } on DioException catch (err) {
      return Error(MessageError.getMessage(err));
    }
  }
}
