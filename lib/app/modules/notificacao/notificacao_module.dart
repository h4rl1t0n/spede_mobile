import 'package:flutter_modular/flutter_modular.dart';

import '../../core/constants/routes.dart';
import '../core/core_module.dart';
import './notificacao_controller.dart';
import './notificacao_page.dart';

final notificacaoModule = createModule(
  path: Routes.notificacao,
  register: (c) {
    c.module(coreModule);
    c.addSingleton(NotificacaoController.new);
    c.route('/', child: (context, state) => const NotificacaoPage());
  },
);
