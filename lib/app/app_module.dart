import 'package:flutter_modular/flutter_modular.dart';

import 'modules/core/core_module.dart';
import 'modules/inicializar/inicializar_module.dart';
import 'modules/login/login_module.dart';
import 'modules/main/main_module.dart';
import 'modules/notificacao/notificacao_module.dart';
import 'modules/perfil/perfil_module.dart';

final appModule = createModule(
  register: (c) {
    c.module(coreModule);
    c.module(inicializarModule);
    c.module(loginModule);
    c.module(mainModule);
    c.module(perfilModule);
    c.module(notificacaoModule);
  },
);
