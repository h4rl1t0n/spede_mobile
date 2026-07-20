import 'package:dio/io.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/rest_client/custom_dio.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton<DioForNative>(CustomDio.new);
    super.exportedBinds(i);
  }
}
