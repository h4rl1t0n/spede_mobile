import 'dart:math';

import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/rest_client/error/custom_message_error.dart';
import '../../../../enum/tipo_caixa.dart';
import '../../../../enum/tipo_situacao.dart';
import '../../../../mock/documentos.dart';
import '../../../../models/documento_model.dart';
import 'solicitacao_datasource.dart';

class SolicitacaoDatasourceImpl extends SolicitacaoDatasource {
  @override
  Future<Result<List<DocumentoModel>, Failure>> carregarTodasSolicitacoes({required TipoCaixa tipoCaixa}) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final random = Random();

      final lista = documentos.where((e) => e.tipoSituacao == TipoSituacao.pendente).toList();
      lista.shuffle();

      final quantidadeEnviadas = random.nextInt(lista.length - 1) + 1;

      final enviadas = lista.take(quantidadeEnviadas).toList();
      final recebidas = lista.skip(quantidadeEnviadas).toList();

      if (tipoCaixa == .enviadas) {
        return Success(enviadas);
      } else {
        return Success(recebidas);
      }
    } on DioException catch (err) {
      return Error(CustomMessageError.getMessage(err));
    }
  }
}
