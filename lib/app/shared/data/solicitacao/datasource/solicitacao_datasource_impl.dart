import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/rest_client/error/custom_message_error.dart';
import '../../../../enum/tipo_caixa.dart';
import '../../../../mock/documentos.dart';
import '../../../../models/documento_model.dart';
import 'solicitacao_datasource.dart';

class SolicitacaoDatasourceImpl extends SolicitacaoDatasource {
  @override
  Future<Result<List<DocumentoModel>, Failure>> carregarTodasSolicitacoes({required TipoCaixa caixa}) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final lista = documentos.where((e) => e.tipoCaixa == caixa).toList();
      return Success(lista);
    } on DioException catch (err) {
      return Error(CustomMessageError.getMessage(err));
    }
  }
}
