import 'package:flutter_modular/flutter_modular.dart';

import '../../core/constants/routes.dart';
import '../../shared/data/auth/auth_repository_impl.dart';
import '../../shared/data/auth/datasource/auth_datasource.dart';
import '../../shared/data/auth/datasource/auth_datasource_impl.dart';
import '../../shared/domain/auth/auth_repository.dart';
import '../../shared/service/auth/auth_service.dart';
import '../core/core_module.dart';
import 'login_controller.dart';
import 'login_page.dart';

final loginModule = createModule(
  path: Routes.login,
  register: (c) {
    c.module(coreModule);
    c.addSingleton<AuthDatasource>(AuthDatasourceImpl.new);
    c.addSingleton<AuthRepository>(AuthRepositoryImpl.new);
    c.addSingleton(AuthService.new);
    
    c.addSingleton(LoginController.new);

    c.route('/', child: (context, state) => const LoginPage());
  },
);
