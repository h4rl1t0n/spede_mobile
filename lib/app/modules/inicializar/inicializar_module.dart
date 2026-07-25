import 'package:flutter_modular/flutter_modular.dart';

import '../../core/constants/routes.dart';
import '../../shared/data/solicitacao/datasource/solicitacao_datasource.dart';
import '../../shared/data/solicitacao/datasource/solicitacao_datasource_impl.dart';
import '../../shared/data/solicitacao/solicitacao_repository_impl.dart';
import '../../shared/domain/solicitacao/solicitacao_repository.dart';
import '../../shared/service/solicitacao/solicitacao_service.dart';
import '../core/core_module.dart';
import 'inicializar_controller.dart';
import 'inicializar_page.dart';

final inicializarModule = createModule(
  path: Routes.inicializar,
  register: (c) {
    c.module(coreModule);

    c.addSingleton<SolicitacaoDatasource>(SolicitacaoDatasourceImpl.new);
    c.addSingleton<SolicitacaoRepository>(SolicitacaoRepositoryImpl.new);
    c.addSingleton(SolicitacaoService.new);

    c.addSingleton(InicializarController.new);

    c.route('/', child: (context, state) => const InicializarPage());
  },
);
