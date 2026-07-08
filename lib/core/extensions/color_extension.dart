import 'package:flutter/material.dart';

extension ColorExtension on Color {
  String toHexadecimal() {
    return '#${toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}'.toUpperCase();
  }
}
