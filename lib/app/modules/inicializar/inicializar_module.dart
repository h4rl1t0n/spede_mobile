import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/data/solicitacao/datasource/solicitacao_datasource.dart';
import '../../shared/data/solicitacao/datasource/solicitacao_datasource_impl.dart';
import '../../shared/data/solicitacao/solicitacao_repository_impl.dart';
import '../../shared/domain/solicitacao/solicitacao_repository.dart';
import '../../shared/service/solicitacao/solicitacao_service.dart';
import '../core/core_module.dart';
import 'inicializar_controller.dart';
import 'inicializar_page.dart';

class InicializarModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addSingleton<SolicitacaoDatasource>(SolicitacaoDatasourceImpl.new);
    i.addSingleton<SolicitacaoRepository>(SolicitacaoRepositoryImpl.new);
    i.addSingleton(SolicitacaoService.new);

    i.addSingleton(InicializarController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const InicializarPage());
  }
}
