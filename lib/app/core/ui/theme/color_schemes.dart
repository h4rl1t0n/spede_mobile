import 'package:flutter/material.dart';

// O azul principal da sua marca será a semente para toda a paleta
const _seedColor = Color(0xFF114B8B);

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: _seedColor,
  brightness: Brightness.light,

  // === Overrides (Sobrescrevendo as cores principais) ===
  // Forçamos as cores exatas da marca, deixando o Flutter calcular o resto
  primary: const Color(0xFF114B8B),
  secondary: const Color(0xFF3D8DDA),
  tertiary: const Color(0xFFD67D22),

  // Opcional: Se você quiser garantir que o fundo do app seja branco puro
  // em vez do tom levemente azulado que o Material 3 gera.
  surface: Colors.white,
);

final darkColorScheme = ColorScheme.fromSeed(
  seedColor: _seedColor,
  brightness: Brightness.dark,

  // === Overrides para o Dark Mode ===
  // Passamos as versões mais claras das cores para garantir legibilidade no escuro
  primary: const Color(0xFF9CCEFF),
  secondary: const Color(0xFF7DB5FF),
  tertiary: const Color(0xFFFFB776),

  // Opcional: Um fundo um pouco mais escuro e sólido para o dark mode
  surface: const Color(0xFF101826),
);
