import 'package:flutter/material.dart';

import '../../extensions/string_extension.dart';
import '../theme/styles/text_styles.dart';
import 'item_tile.dart';

class HighlightedItemTile extends StatelessWidget {
  const HighlightedItemTile({
    super.key,
    required this.search,
    required this.title,
    this.text,
    this.title2,
    this.text2,
    this.colorSubTitleText,
  });

  final String search;
  final String title;
  final String? text;
  final String? title2;
  final String? text2;
  final Color? colorSubTitleText;

  TextStyles get textStyles => TextStyles.instance;

  @override
  Widget build(BuildContext context) {
    return _selectType(context);
  }

  Widget _selectType(BuildContext context) {
    if (title2 == null) {
      return _buildItemTile(title, text, context);
    } else {
      return _buildRow(context);
    }
  }

  Widget _buildItemTile(String titulo, String? texto, BuildContext ctx) {
    return search.isEmpty
        ? ItemTile(title: titulo, subTitle: texto, colorSubTitleText: colorSubTitleText)
        : ItemTile(
            title: titulo,
            subTitleWidget: RichText(text: _highlightedText(texto, ctx), textAlign: TextAlign.justify),
          );
  }

  Widget _buildRow(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildItemTile(title, text, context)),
        Expanded(child: _buildItemTile(title2!, text2, context)),
      ],
    );
  }

  TextSpan _highlightedText(String? text, BuildContext context) {
    final texto = text ?? '-';
    final query = search.normalizar();
    final normalizedTexto = texto.normalizar();

    final spans = <TextSpan>[];
    int start = 0;

    while (true) {
      final index = normalizedTexto.indexOf(query, start);
      if (index == -1) {
        // Duarante a pesquisa diminui a fonte do subtitulo para 13
        spans.add(
          TextSpan(
            text: texto.substring(start),
            style: textStyles.textSubTitleItemList.copyWith(
              color:
                  texto.toLowerCase().contains('expirado') || texto.toLowerCase().contains('aguardando preenchimento')
                  ? Colors.red
                  : null,
            ),
          ),
        );
        break;
      }
      if (index > start) {
        spans.add(
          TextSpan(
            text: texto.substring(start, index),
            style: textStyles.textSubTitleItemList.copyWith(
              color:
                  texto.toLowerCase().contains('expirado') || texto.toLowerCase().contains('aguardando preenchimento')
                  ? Colors.red
                  : null,
            ),
          ),
        );
      }
      spans.add(
        TextSpan(
          text: texto.substring(index, index + query.length),
          style: textStyles.textSubTitleItemList.copyWith(backgroundColor: Colors.blue.withValues(alpha: 0.4)),
        ),
      );
      start = index + query.length;
    }

    return TextSpan(children: spans, style: DefaultTextStyle.of(context).style);
  }
}
