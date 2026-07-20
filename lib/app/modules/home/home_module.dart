import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/data/solicitacao/datasource/solicitacao_datasource.dart';
import '../../shared/data/solicitacao/datasource/solicitacao_datasource_impl.dart';
import '../../shared/data/solicitacao/solicitacao_repository_impl.dart';
import '../../shared/domain/solicitacao/solicitacao_repository.dart';
import '../../shared/service/solicitacao/solicitacao_service.dart';
import '../core/core_module.dart';
import 'home_controller.dart';
import 'home_page.dart';
import 'pages/agenda/agenda_controller.dart';
import 'pages/solicitacao/solicitacao_controller.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addSingleton<SolicitacaoDatasource>(SolicitacaoDatasourceImpl.new);
    i.addSingleton<SolicitacaoRepository>(SolicitacaoRepositoryImpl.new);
    i.addSingleton(SolicitacaoService.new);

    i.add(SolicitacaoController.new);
    i.addSingleton(AgendaController.new);
    i.addSingleton(HomeController.new);
  }

  @override
  void routes(r) {
    r.child(
      Modular.initialRoute,
      child: (context) {
        return HomePage(
          usuario: r.args.data['usuario'],
          setores: r.args.data['setores'],
          solicitacao: r.args.data['solicitacao'],
        );
      },
    );
  }
}
