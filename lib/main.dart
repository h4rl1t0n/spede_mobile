import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/core/constants/routes.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    ModularApp(
      module: appModule,
      navigatorKey: navigatorKey,
      initialRoute: Routes.inicializar,
      child: AppWidget(navigatorKey: navigatorKey),
    ),
  );
}
