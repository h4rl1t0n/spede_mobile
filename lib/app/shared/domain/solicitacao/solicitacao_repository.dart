import 'package:multiple_result/multiple_result.dart';

import '../../../core/exceptions/failure.dart';
import '../../data/solicitacao/dto/solicitacao_response_dto.dart';

abstract class SolicitacaoRepository {
  Future<Result<SolicitacoesResponse, Failure>> carregarTodasSolicitacoes();
}
