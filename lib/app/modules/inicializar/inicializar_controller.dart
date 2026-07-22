import 'package:mobx/mobx.dart';

import '../../core/result/result_handler.dart';
import '../../shared/data/solicitacao/dto/dashboard_resumo_model.dart';
import '../../shared/service/solicitacao/solicitacao_service.dart';

part 'inicializar_controller.g.dart';

class InicializarController = InicializarControllerBase with _$InicializarController;

abstract class InicializarControllerBase with Store {
  final SolicitacaoService service;

  @observable
  String? errorMessage;

  InicializarControllerBase(this.service);

  @action
  Future<DashboardResumoModel> carregarResumoDashboard() async {
    var data = DashboardResumoModel(setoresEnviados: [], setoresRecebidos: [], totalEnviados: 0, totalRecebidos: 0);

    errorMessage = null;
    await fetch(
      service.carregarResumoDashboard(),
      onSuccess: (result) {
        data = result;
      },
      onError: (message) {
        data = DashboardResumoModel(setoresEnviados: [], setoresRecebidos: [], totalEnviados: 0, totalRecebidos: 0);
      },
    );

    return data;
  }
}
