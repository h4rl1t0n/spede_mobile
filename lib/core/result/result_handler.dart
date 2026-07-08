import 'dart:developer';

import 'package:multiple_result/multiple_result.dart';

import 'failure.dart';

/// Função genérica para lidar com operações que retornam um [Result].
/// Aceita a operação, uma função de sucesso e uma função de erro.
Future<void> fetch<T>(
  Future<Result<T, Failure>> operation, {
  required Function(T success) onSuccess,
  required Function(String errorMessage) onError,
}) async {
  try {
    final result = await operation;
    switch (result) {
      case Success():
        onSuccess(result.success);
        break;
      case Error():
        onError(result.error.message ?? 'Erro desconhecido');
        break;
    }
  } catch (e, s) {
    log('Erro durante a operação local', error: e, stackTrace: s);
    onError('Erro ao realizar a operação');
  }
}
