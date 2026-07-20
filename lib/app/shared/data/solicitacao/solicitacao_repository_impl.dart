import 'package:multiple_result/multiple_result.dart';

import '../../../core/exceptions/failure.dart';
import '../../domain/solicitacao/solicitacao_repository.dart';
import 'datasource/solicitacao_datasource.dart';
import 'dto/solicitacao_response_dto.dart';

class SolicitacaoRepositoryImpl implements SolicitacaoRepository {
  final SolicitacaoDatasource datasource;

  SolicitacaoRepositoryImpl(this.datasource);

  @override
  Future<Result<SolicitacoesResponse, Failure>> carregarTodasSolicitacoes() async {
    return datasource.carregarTodasSolicitacoes();
  }
}
