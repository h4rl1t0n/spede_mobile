import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:multiple_result/multiple_result.dart';

import '../exceptions/failure.dart';

Future<void> fetch<T>(
  Future<Result<T, Failure>> apiCall, {
  required Function(T success) onSuccess,
  required Function(String errorMessage) onError,
  VoidCallback? onFinally,
}) async {
  try {
    try {
      final result = await apiCall;
      switch (result) {
        case Success(success: final successValue):
          onSuccess(successValue);
          break;
        case Error(error: final errorValue):
          log(name: 'handleCall - Error', errorValue.message ?? 'Erro desconhecido retornado pela API');
          onError(errorValue.message ?? 'Erro desconhecido retornado pela API');
          break;
      }
    } catch (e, s) {
      log('Erro durante a chamada de API ou processamento', error: e, stackTrace: s);
      onError('Erro ao realizar a operação: $e');
    }
  } finally {
    onFinally?.call();
    log('handleApiCall: onFinally executado.');
  }
}
