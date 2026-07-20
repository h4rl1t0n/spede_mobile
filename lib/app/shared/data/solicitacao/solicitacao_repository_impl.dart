import 'package:multiple_result/multiple_result.dart';

import '../../../core/exceptions/failure.dart';
import '../../../enum/tipo_caixa.dart';
import '../../../models/documento_model.dart';
import '../../domain/solicitacao/solicitacao_repository.dart';
import 'datasource/solicitacao_datasource.dart';

class SolicitacaoRepositoryImpl implements SolicitacaoRepository {
  final SolicitacaoDatasource datasource;

  SolicitacaoRepositoryImpl(this.datasource);

  @override
  Future<Result<List<DocumentoModel>, Failure>> carregarTodasSolicitacoes({required TipoCaixa tipoCaixa}) async {
    return datasource.carregarTodasSolicitacoes(tipoCaixa: tipoCaixa);
  }
}
