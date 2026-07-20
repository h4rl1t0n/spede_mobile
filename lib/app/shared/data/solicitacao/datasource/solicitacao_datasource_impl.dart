import 'dart:math';

import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/rest_client/error/custom_message_error.dart';
import '../../../../mock/documentos.dart';
import '../dto/solicitacao_response_dto.dart';
import 'solicitacao_datasource.dart';

class SolicitacaoDatasourceImpl extends SolicitacaoDatasource {
  @override
  Future<Result<SolicitacoesResponse, Failure>> carregarTodasSolicitacoes() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final random = Random();

      final lista = [...documentos];
      lista.shuffle();

      final quantidadeEnviadas = random.nextInt(lista.length - 1) + 1;

      final enviadas = lista.take(quantidadeEnviadas).toList();
      final recebidas = lista.skip(quantidadeEnviadas).toList();
      final resultado = SolicitacoesResponse(enviadas: enviadas, recebidas: recebidas);

      return Success(resultado);
    } on DioException catch (err) {
      return Error(CustomMessageError.getMessage(err));
    }
  }
}
