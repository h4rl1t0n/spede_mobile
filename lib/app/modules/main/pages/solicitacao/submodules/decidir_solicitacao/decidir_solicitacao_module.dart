import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/core_module.dart';
import 'decidir_solicitacao_controller.dart';
import 'decidir_solicitacao_page.dart';

final decidirSolicitacaoModule = createModule(
  path: '/decidir-solicitacao/',
  register: (c) {
    c.module(coreModule);
    c.add(DecidirSolicitacaoController.new);
    c.route(
      '/',
      child: (context, state) {
        final args = state.arguments as Map<String, dynamic>;
        return DecidirSolicitacaoPage(acao: args['acao'], selecionados: args['selecionados']);
      },
    );
  },
);
