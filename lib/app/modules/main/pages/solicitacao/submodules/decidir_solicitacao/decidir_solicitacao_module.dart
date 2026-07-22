import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/core_module.dart';
import 'decidir_solicitacao_controller.dart';
import 'decidir_solicitacao_page.dart';

class DecidirSolicitacaoModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.add(DecidirSolicitacaoController.new);
  }

  @override
  void routes(r) {
    r.child(
      Modular.initialRoute,
      child: (context) {
        return DecidirSolicitacaoPage(acao: r.args.data['acao'], selecionados: r.args.data['selecionados']);
      },
    );
  }
}
