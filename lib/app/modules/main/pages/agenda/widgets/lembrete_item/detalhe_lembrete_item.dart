import 'package:flutter/material.dart';

import '../../../../../../core/ui/theme/styles/text_styles.dart';

class DetalheLembreteItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isFullWidth;

  const DetalheLembreteItem({super.key, required this.label, required this.value, this.isFullWidth = false});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return FractionallySizedBox(
      widthFactor: isFullWidth ? 1.0 : 0.45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: context.textStyles.textTitleItemList.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              fontSize: 10,
            ),
          ),
          Text(
            value,
            style: context.textStyles.textSubTitleItemList.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
