import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/rest_client/error/custom_message_error.dart';
import '../../../../core/rest_client/error/dio_failure.dart';
import '../../../../mock/usuarios.dart';
import '../dto/auth_request_dto.dart';
import 'auth_datasource.dart';

class AuthDatasourceImpl implements AuthDatasource {
  @override
  Future<Result<String, Failure>> login({required AuthRequestDto auth}) async {
    try {
      await Future.delayed(Duration(seconds: 3));

      final usuario = usuarios.firstWhereOrNull((element) => element.username == auth.login);

      if (usuario != null) {
        final ativo = usuario.ativo;

        if (ativo) {
          return Success(usuario.username);
        }

        return Error(DioFailure(message: 'Usuário ${usuario.username} inativo.', statusCode: 404));
      }

      return Error(DioFailure(message: 'Usuário não encontrado!', statusCode: 404));
    } on DioException catch (err) {
      return Error(CustomMessageError.getMessage(err));
    }
  }

  // @override
  // Future<Result<AuthResponseDto, Failure>> login({required AuthRequestDto auth}) async {
  //   try {
  //     final response = await client.post('auth', data: auth.toJson());

  //     if (response.statusCode == 200) {
  //       final result = AuthResponseDto.fromMap(response.data);
  //       return Success(result);
  //     }

  //     if (response.statusCode == 401) {
  //       return Error(
  //         DioFailure(
  //           message: response.data['errors'] ?? 'Erro ao fazer login, tente novamente!',
  //           statusCode: response.statusCode,
  //         ),
  //       );
  //     }

  //     return Error(DioFailure(message: 'Erro ao fazer login, tente novamente!', statusCode: 404));
  //   } on DioException catch (err) {
  //     return Error(CustomMessageError.getMessage(err));
  //   }
  // }
}
