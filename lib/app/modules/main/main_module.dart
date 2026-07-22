import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/data/solicitacao/datasource/solicitacao_datasource.dart';
import '../../shared/data/solicitacao/datasource/solicitacao_datasource_impl.dart';
import '../../shared/data/solicitacao/solicitacao_repository_impl.dart';
import '../../shared/domain/solicitacao/solicitacao_repository.dart';
import '../../shared/service/solicitacao/solicitacao_service.dart';
import '../core/core_module.dart';
import 'main_controller.dart';
import 'main_page.dart';
import 'pages/agenda/agenda_controller.dart';
import 'pages/home/home_controller.dart';
import 'pages/home/widgets/dashboard_item_card/dashboard_item_card_store.dart';
import 'pages/solicitacao/solicitacao_controller.dart';
import 'pages/solicitacao/submodules/decidir_solicitacao/decidir_solicitacao_module.dart';

class MainModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addSingleton<SolicitacaoDatasource>(SolicitacaoDatasourceImpl.new);
    i.addSingleton<SolicitacaoRepository>(SolicitacaoRepositoryImpl.new);
    i.addSingleton(SolicitacaoService.new);

    i.addSingleton(MainController.new);

    i.add(HomeController.new);
    i.add(AgendaController.new);
    i.add(DashboardItemCardStore.new);
    i.add(SolicitacaoController.new);
  }

  @override
  void routes(r) {
    r.child(
      Modular.initialRoute,
      child: (context) {
        return MainPage(
          usuario: r.args.data['usuario'],
          setores: r.args.data['setores'],
          resumo: r.args.data['resumo'],
        );
      },
    );
    r.module('/decidir-solicitacao/', module: DecidirSolicitacaoModule());
  }
}
