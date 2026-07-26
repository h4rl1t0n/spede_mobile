import 'package:flutter/material.dart';

const _seedColor = Color(0xFF114B8B);

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: _seedColor,
  brightness: Brightness.light,
  primary: const Color(0xFF114B8B),
  secondary: const Color(0xFF3D8DDA),
  tertiary: const Color(0xFFD67D22),
  surface: Colors.white,
);

final darkColorScheme = ColorScheme.fromSeed(
  seedColor: _seedColor,
  brightness: Brightness.dark,
  primary: const Color(0xFF9CCEFF),
  secondary: const Color(0xFF7DB5FF),
  tertiary: const Color(0xFFFFB776),
  surface: const Color(0xFF101826),
);
