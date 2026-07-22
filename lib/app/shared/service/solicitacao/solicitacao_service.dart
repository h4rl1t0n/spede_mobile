import 'package:multiple_result/multiple_result.dart';

import '../../../core/exceptions/failure.dart';
import '../../../enum/tipo_caixa.dart';
import '../../../models/documento_model.dart';
import '../../data/solicitacao/dto/dashboard_resumo_model.dart';
import '../../domain/solicitacao/solicitacao_repository.dart';

class SolicitacaoService {
  final SolicitacaoRepository repository;

  SolicitacaoService(this.repository);

  Future<Result<List<DocumentoModel>, Failure>> carregarTodasSolicitacoes({required TipoCaixa caixa}) async {
    return repository.carregarTodasSolicitacoes(caixa: caixa);
  }

  Future<Result<DashboardResumoModel, Failure>> carregarResumoDashboard() async {
    return repository.carregarResumoDashboard();
  }
}
