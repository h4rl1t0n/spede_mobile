import 'dart:developer';

import 'package:multiple_result/multiple_result.dart';

import '../../../core/exceptions/failure.dart';
import '../../data/solicitacao/dto/solicitacao_response_dto.dart';
import '../../domain/solicitacao/solicitacao_repository.dart';

class SolicitacaoService {
  final SolicitacaoRepository repository;

  SolicitacaoService(this.repository);

  Future<Result<SolicitacoesResponse, Failure>> carregarTodasSolicitacoes() async {
    final result = await repository.carregarTodasSolicitacoes();

    return result.when(
      (success) {
        log('enviadas ${success.enviadas.length} | recebidas ${success.recebidas.length}');
        return Success(success);
      },
      (error) {
        return Error(error);
      },
    );
  }
}
