import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;
  ColorsApp._();
  static ColorsApp get instance {
    _instance ??= ColorsApp._();
    return _instance!;
  }

  Color get primary => const Color(0xFF365365);
  Color get secondary => const Color(0xFF3D8DDA);
  Color get black => const Color(0xFF1F2937);
  Color get lightGrey => const Color(0xFFF3FAF8);
}

extension ColorsAppExceptions on BuildContext {
  ColorsApp get colors => ColorsApp.instance;
}
