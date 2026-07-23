import 'package:flutter_modular/flutter_modular.dart';

import 'core/constants/routes.dart';
import 'modules/core/core_module.dart';
import 'modules/inicializar/inicializar_module.dart';
import 'modules/login/login_module.dart';
import 'modules/main/main_module.dart';
import 'modules/perfil/perfil_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module('/', module: InicializarModule());
    r.module(Routes.inicializar, module: InicializarModule());
    r.module(Routes.login, module: LoginModule());
    r.module(Routes.main, module: MainModule());
    r.module(Routes.perfil, module: PerfilModule());
  }
}
