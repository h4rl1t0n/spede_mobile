import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/global/global_context.dart';
import 'core/ui/theme/theme_config.dart';

class AppWidget extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  AppWidget({super.key}) {
    GlobalContext.instance.navigatorKey = _navigatorKey;
  }

  @override
  Widget build(BuildContext context) {
    Modular.setNavigatorKey(_navigatorKey);
    return MaterialApp.router(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: ThemeConfig.lightTheme,
      routerConfig: Modular.routerConfig,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      // home: const InicializarAppPage(),
    );
  }
}
