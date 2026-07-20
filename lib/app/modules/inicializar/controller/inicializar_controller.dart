import 'package:mobx/mobx.dart';

import '../../../core/result/result_handler.dart';
import '../../../shared/data/solicitacao/dto/solicitacao_response_dto.dart';
import '../../../shared/service/solicitacao/solicitacao_service.dart';

part 'inicializar_controller.g.dart';

class InicializarController = InicializarControllerBase with _$InicializarController;

abstract class InicializarControllerBase with Store {
  final SolicitacaoService service;

  @observable
  String? errorMessage;

  @action
  Future<SolicitacoesResponse> carregarSolicitacoes() async {
    var result = SolicitacoesResponse(enviadas: [], recebidas: []);
    errorMessage = null;
    await fetch(
      service.carregarTodasSolicitacoes(),
      onSuccess: (solicitacoes) {
        result = solicitacoes;
      },
      onError: (message) {
        errorMessage = message;
      },
    );

    return result;
  }

  InicializarControllerBase(this.service);
}
