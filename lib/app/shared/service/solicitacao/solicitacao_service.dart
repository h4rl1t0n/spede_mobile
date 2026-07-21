import 'dart:developer';

import 'package:multiple_result/multiple_result.dart';

import '../../../core/exceptions/failure.dart';
import '../../../enum/tipo_caixa.dart';
import '../../../models/documento_model.dart';
import '../../domain/solicitacao/solicitacao_repository.dart';

class SolicitacaoService {
  final SolicitacaoRepository repository;

  SolicitacaoService(this.repository);

  Future<Result<List<DocumentoModel>, Failure>> carregarTodasSolicitacoes({required TipoCaixa caixa}) async {
    final result = await repository.carregarTodasSolicitacoes(caixa: caixa);

    return result.when(
      (success) {
        log('Carregou ${success.length} ${caixa.descricao.toLowerCase()}');
        return Success(success);
      },
      (error) {
        return Error(error);
      },
    );
  }
}
