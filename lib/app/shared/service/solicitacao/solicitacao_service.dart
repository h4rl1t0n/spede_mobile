import 'dart:developer';

import 'package:multiple_result/multiple_result.dart';

import '../../../core/exceptions/failure.dart';
import '../../../enum/tipo_caixa.dart';
import '../../../models/documento_model.dart';
import '../../domain/solicitacao/solicitacao_repository.dart';

class SolicitacaoService {
  final SolicitacaoRepository repository;

  SolicitacaoService(this.repository);

  Future<Result<List<DocumentoModel>, Failure>> carregarTodasSolicitacoes({required TipoCaixa tipoCaixa}) async {
    final result = await repository.carregarTodasSolicitacoes(tipoCaixa: tipoCaixa);

    return result.when(
      (success) {
        log('Carregou ${success.length} ${tipoCaixa.descricao.toLowerCase()}');
        return Success(success);
      },
      (error) {
        return Error(error);
      },
    );
  }
}
