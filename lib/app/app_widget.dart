import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/global/global_context.dart';
import 'core/ui/theme/theme_config.dart';

class AppWidget extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  AppWidget({super.key, required this.navigatorKey}) {
    GlobalContext.instance.navigatorKey = navigatorKey;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: ThemeConfig.lightTheme,
      routerConfig: ModularApp.routerConfigOf(context),

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
    );
  }
}
