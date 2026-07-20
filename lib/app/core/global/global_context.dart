import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app_module.dart';
import 'local_storage_utils.dart';

class GlobalContext {
  late final GlobalKey<NavigatorState> _navigatorKey;
  static GlobalContext? _instance;

  GlobalContext._();

  static GlobalContext get instance {
    _instance ??= GlobalContext._();
    return _instance!;
  }

  set navigatorKey(GlobalKey<NavigatorState> key) => _navigatorKey = key;

  Future<void> loginExpire() async {
    await LocalStorageUtils.clean();
    ScaffoldMessenger.of(_navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.red,
        content: const Text('Login Expirado, faça login novamente'),
      ),
    );
    Modular.to.navigate(Routes.inicializar);
  }
}
