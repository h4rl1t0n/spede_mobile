import 'package:flutter_modular/flutter_modular.dart';

import '../../core/constants/routes.dart';
import '../../models/usuario_model.dart';
import '../core/core_module.dart';
import 'controller/perfil_controller.dart';
import 'perfil_page.dart';

final perfilModule = createModule(
  path: Routes.perfil,
  register: (c) {
    c.module(coreModule);
    c.addSingleton(PerfilController.new);
    c.route(
      '/',
      child: (context, state) {
        final arguments = state.arguments as UsuarioModel;
        return PerfilPage(usuario: arguments);
      },
    );
  },
);
