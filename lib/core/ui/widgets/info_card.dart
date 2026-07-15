import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String titulo;
  final String valor;

  const InfoCard({super.key, required this.titulo, required this.valor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return RichText(
      text: TextSpan(
        style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
        children: [
          TextSpan(
            text: '$titulo: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: valor,
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
