import 'package:dio/dio.dart';

import 'dio_failure.dart';
import 'response_code.dart';
import 'status_code_error_enum.dart';

class CustomMessageError {
  static DioFailure getMessage(e) {
    String message = '';
    int? statusCode;
    if (e.response != null) {
      statusCode = e.response.statusCode;
      message = 'Erro desconhecido [Error ${e.response.statusCode}], tente novamente';
      if (statusCode == ResponseCode.notFound.code ||
          statusCode == ResponseCode.unauthorized.code ||
          statusCode == ResponseCode.badRequest.code) {
        message = getErrorFromData(e.response.data);
      }

      if (statusCode == ResponseCode.internalServerError.code) {
        message = getErrorFromData(e.response.data);
        if (message == 'Objeto não encontrado') {
          message = 'Erro interno no servidor [Error 500], tente novamente';
        }
      }
    } else {
      if (e is DioException) {
        switch (e.type) {
          case DioExceptionType.connectionTimeout:
            message = 'Tempo de conexão expirou, tente novamente';
            statusCode = StatusCodeErrorEnum.connectTimeout.value;
            break;
          case DioExceptionType.sendTimeout:
            message = 'Tempo de envio expirou, tente novamente';
            statusCode = StatusCodeErrorEnum.sendTimeout.value;
            break;
          case DioExceptionType.receiveTimeout:
            message = 'Tempo de recebimento expirou, tente novamente';
            statusCode = StatusCodeErrorEnum.receiveTimeout.value;
            break;
          case DioExceptionType.badResponse:
            message = 'Ocorreu um erro na resposta do servidor, tente novamente';
            statusCode = StatusCodeErrorEnum.response.value;
            break;
          case DioExceptionType.cancel:
            message = 'Requisição cancelada pelo usuário';
            statusCode = StatusCodeErrorEnum.cancel.value;
            break;
          case DioExceptionType.unknown:
            if (e.message != null && e.message!.contains('Network is unreachable')) {
              message = 'Conexão indisponível, tente novamente mais tarde';
            }
            statusCode = StatusCodeErrorEnum.other.value;
            break;
          default:
            message = 'Ocorreu um erro na conexão, tente novamente';
        }
      } else if (e is String) {
        message = e;
      } else {
        message = 'Ocorreu um erro desconhecido, tente novamente';
      }
    }

    return DioFailure(message: message, statusCode: statusCode);
  }

  static String getErrorFromData(dynamic data) {
    // String resultError = 'Objeto não encontrado';
    // if (data != null && data['errors'] != null) {
    //   final errorResponse = ErrorResponseDto.fromJson(data);
    //   resultError = errorResponse.errors.join(';\n');
    //   if (resultError == 'Bad credentials') {
    //     resultError = 'Usuário inexistente ou senha inválida';
    //   }
    // }
    return 'Houve um erro nesta requisição';
  }
}
