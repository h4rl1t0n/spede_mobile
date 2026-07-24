import 'package:flutter_modular/flutter_modular.dart';

import '../core/core_module.dart';
import './notificacao_controller.dart';
import './notificacao_page.dart';

class NotificacaoModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addSingleton(NotificacaoController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const NotificacaoPage());
  }
}
