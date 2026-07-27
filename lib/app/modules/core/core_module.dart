import 'package:dio/io.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/rest_client/custom_dio.dart';

final coreModule = createModule(register: (c) => c.addSingleton<DioForNative>(CustomDio.new));
