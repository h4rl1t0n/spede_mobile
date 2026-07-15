import 'package:flutter/material.dart';

import '../theme/styles/text_styles.dart';

class ItemTile extends StatelessWidget {
  final String title;
  final String? subTitle;
  final TextAlign textAlign;
  final Widget? subTitleWidget; // Adiciona suporte para RichText opcional
  final TextOverflow? overflow;
  final Color? colorSubTitleText;

  const ItemTile({
    super.key,
    required this.title,
    this.subTitle,
    this.subTitleWidget,
    this.textAlign = TextAlign.justify,
    this.overflow,
    this.colorSubTitleText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, overflow: overflow, style: context.textStyles.textTitleItemList.copyWith(fontSize: 16)),
          subtite(context),
        ],
      ),
    );
  }

  Widget subtite(BuildContext context) {
    if (subTitleWidget != null) {
      return subTitleWidget!;
    }

    final subTitleString = subTitle ?? '';

    if (subTitleString.isEmpty) {
      return SizedBox.shrink();
    }

    return Text(
      textAlign: textAlign,
      overflow: overflow,
      subTitleString,
      style: context.textStyles.textSubTitleItemList.copyWith(color: colorSubTitleText ?? Colors.grey.shade600),
    );
  }
}
