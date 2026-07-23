import 'package:flutter/material.dart';

class RequiredLabel extends StatelessWidget {
  final String label;
  const RequiredLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return RichText(
      text: TextSpan(
        text: label,
        style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.w600),
        children: [
          TextSpan(
            text: ' *',
            style: TextStyle(color: colorScheme.error, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
