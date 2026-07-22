import 'package:multiple_result/multiple_result.dart';

import '../../../core/exceptions/failure.dart';
import '../../../enum/tipo_caixa.dart';
import '../../../models/documento_model.dart';
import '../../domain/solicitacao/solicitacao_repository.dart';
import 'datasource/solicitacao_datasource.dart';
import 'dto/dashboard_resumo_model.dart';

class SolicitacaoRepositoryImpl implements SolicitacaoRepository {
  final SolicitacaoDatasource datasource;

  SolicitacaoRepositoryImpl(this.datasource);

  @override
  Future<Result<List<DocumentoModel>, Failure>> carregarTodasSolicitacoes({required TipoCaixa caixa}) async {
    return datasource.carregarTodasSolicitacoes(caixa: caixa);
  }

  @override
  Future<Result<DashboardResumoModel, Failure>> carregarResumoDashboard() async {
    return datasource.carregarResumoDashboard();
  }
}
