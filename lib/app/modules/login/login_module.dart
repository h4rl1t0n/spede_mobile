import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/data/auth/auth_repository_impl.dart';
import '../../shared/data/auth/datasource/auth_datasource.dart';
import '../../shared/data/auth/datasource/auth_datasource_impl.dart';
import '../../shared/domain/auth/auth_repository.dart';
import '../../shared/service/auth/auth_service.dart';
import '../core/core_module.dart';
import 'controller/login_controller.dart';
import 'login_page.dart';

class LoginModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addSingleton<AuthDatasource>(AuthDatasourceImpl.new);
    i.addSingleton<AuthRepository>(AuthRepositoryImpl.new);
    i.addSingleton(AuthService.new);

    i.addSingleton(LoginController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const LoginPage());
  }
}
