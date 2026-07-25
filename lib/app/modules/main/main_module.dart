import 'package:flutter_modular/flutter_modular.dart';

import '../../core/constants/routes.dart';
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

final mainModule = createModule(
  path: Routes.main,
  register: (c) {
    c.module(coreModule);

    c.addSingleton<SolicitacaoDatasource>(SolicitacaoDatasourceImpl.new);
    c.addSingleton<SolicitacaoRepository>(SolicitacaoRepositoryImpl.new);
    c.addSingleton(SolicitacaoService.new);

    c.addSingleton(MainController.new);

    c.add(HomeController.new);
    c.add(AgendaController.new);
    c.add(DashboardItemCardStore.new);
    c.add(SolicitacaoController.new);

    c.route(
      '/',
      child: (context, state) {
        final args = state.arguments as Map<String, dynamic>;
        return MainPage(usuario: args['usuario'], setores: args['setores'], resumo: args['resumo']);
      },
    );

    c.module(decidirSolicitacaoModule);
  },
);
