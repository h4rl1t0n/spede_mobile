import 'package:flutter_modular/flutter_modular.dart';

import '../core/core_module.dart';
import 'controller/perfil_controller.dart';
import 'perfil_page.dart';

class PerfilModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addSingleton(PerfilController.new);
  }

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => PerfilPage(usuario: r.args.data));
  }
}
