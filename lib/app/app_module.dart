import 'package:flutter_modular/flutter_modular.dart';

import 'modules/core/core_module.dart';
import 'modules/home/home_module.dart';
import 'modules/inicializar/inicializar_module.dart';
import 'modules/login/login_module.dart';
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
    r.module(Routes.home, module: HomeModule());
    r.module(Routes.perfil, module: PerfilModule());
  }
}

class Routes {
  static String get inicializar => '/inicializar/';
  static String get login => '/login/';
  static String get home => '/home/';
  static String get perfil => '/perfil/';
  static String get notificacao => '/notificacao/';

  // static String get agenda => '/agenda/';
  // static String get solicitacao => '/solicitacao/';
}
