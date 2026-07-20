import 'package:multiple_result/multiple_result.dart';

import '../../../../core/exceptions/failure.dart';
import '../dto/solicitacao_response_dto.dart';

abstract class SolicitacaoDatasource {
  Future<Result<SolicitacoesResponse, Failure>> carregarTodasSolicitacoes();
}
