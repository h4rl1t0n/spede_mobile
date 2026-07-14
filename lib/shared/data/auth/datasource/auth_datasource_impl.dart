import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/rest_client/error/custom_message_error.dart';
import '../../../../core/rest_client/error/dio_failure.dart';
import '../../../../mock/token.dart';
import '../dto/auth_request_dto.dart';
import '../dto/auth_response_dto.dart';
import 'auth_datasource.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final DioForNative client;

  AuthDatasourceImpl(this.client);

  @override
  Future<Result<AuthResponseDto, Failure>> login({required AuthRequestDto auth}) async {
    try {
      await Future.delayed(Duration(seconds: 2));

      final response = data;

      if (response.isNotEmpty) {
        final result = AuthResponseDto.fromMap(response);
        return Success(result);
      }

      return Error(DioFailure(message: 'Erro ao fazer login, tente novamente!', statusCode: 404));
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
