import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  // Azul principal do logo
  primary: Color(0xFF114B8B),
  onPrimary: Colors.white,
  primaryContainer: Color(0xFFD8E8FF),
  onPrimaryContainer: Color(0xFF0D2C55),

  // Azul secundário
  secondary: Color(0xFF3D8DDA),
  onSecondary: Colors.white,
  secondaryContainer: Color(0xFFE7F2FF),
  onSecondaryContainer: Color(0xFF143A66),

  // Vermelho institucional (prédio)
  tertiary: Color(0xFF9E2F45),
  onTertiary: Colors.white,
  tertiaryContainer: Color(0xFFF9DDE3),
  onTertiaryContainer: Color(0xFF4A0D19),

  error: Color(0xFFD32F2F),
  onError: Colors.white,
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF410002),

  // Cinza da fachada
  surface: Color(0xFFF6F7F9),
  onSurface: Color(0xFF1A2333),

  surfaceContainerHighest: Color(0xFFE8EBF0),
  onSurfaceVariant: Color(0xFF505C6C),

  outline: Color(0xFF9CA7B5),
  outlineVariant: Color(0xFFD4DAE2),

  inverseSurface: Color(0xFF1F2937),
  onInverseSurface: Colors.white,

  inversePrimary: Color(0xFF78AFFF),

  shadow: Colors.black,
  scrim: Colors.black,
  surfaceTint: Color(0xFF1E5AA8),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  primary: Color(0xFF7DB5FF),
  onPrimary: Color(0xFF002D63),
  primaryContainer: Color(0xFF124C91),
  onPrimaryContainer: Color(0xFFEAF4FF),

  secondary: Color(0xFF9CCEFF),
  onSecondary: Color(0xFF103A69),
  secondaryContainer: Color(0xFF295C91),
  onSecondaryContainer: Color(0xFFEAF4FF),

  tertiary: Color(0xFFE68A9C),
  onTertiary: Color(0xFF551322),
  tertiaryContainer: Color(0xFF7E263A),
  onTertiaryContainer: Color(0xFFFFE6EB),

  error: Color(0xFFFF8A80),
  onError: Color(0xFF5A0000),
  errorContainer: Color(0xFFA61B1B),
  onErrorContainer: Color(0xFFFFE5E5),

  surface: Color(0xFF101826),
  onSurface: Color(0xFFF6F8FB),

  surfaceContainerHighest: Color(0xFF243246),
  onSurfaceVariant: Color(0xFFD3DBE8),

  outline: Color(0xFF718198),
  outlineVariant: Color(0xFF3B4A5E),

  inverseSurface: Color(0xFFF6F8FB),
  onInverseSurface: Color(0xFF101826),

  inversePrimary: Color(0xFF1E5AA8),

  shadow: Colors.black,
  scrim: Colors.black,
  surfaceTint: Color(0xFF7DB5FF),
);
