import 'package:mobx/mobx.dart';

import '../../../../core/result/result_handler.dart';
import '../../../../enum/page_status.dart';
import '../../../../shared/data/solicitacao/dto/dashboard_resumo_model.dart';
import '../../../../shared/service/solicitacao/solicitacao_service.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  final SolicitacaoService service;

  @observable
  DashboardResumoModel? resumo;

  @observable
  var status = PageStatus.initial;

  @observable
  String? errorMessage;

  HomeControllerBase(this.service);

  @action
  Future<void> carregarResumoDashboard() async {
    errorMessage = null;
    status = PageStatus.loading;
    await fetch(
      service.carregarResumoDashboard(),
      onSuccess: (result) {
        setResumo(value: result);
        status = PageStatus.loaded;
      },
      onError: (message) {
        status = PageStatus.error;
        errorMessage = message;
      },
    );
  }

  @action
  void setResumo({required DashboardResumoModel? value}) {
    resumo = value;
  }
}
