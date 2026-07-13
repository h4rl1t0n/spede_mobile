import 'package:flutter/material.dart';

import '../../../../core/ui/theme/styles/text_styles.dart';
import '../../../../models/lembrete_model.dart';

class LembreteItem extends StatelessWidget {
  final LembreteModel lembrete;

  const LembreteItem({super.key, required this.lembrete});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final corDestaque = lembrete.cor;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Theme(
              data: theme.copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: const EdgeInsets.only(left: 12, right: 16, top: 4, bottom: 4),
                childrenPadding: const EdgeInsets.only(left: 12, right: 12, bottom: 16),
                iconColor: theme.colorScheme.primary,
                title: Text(
                  lembrete.titulo,
                  textAlign: .justify,
                  style: context.textStyles.textTitleItemList.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    spacing: 5,
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        lembrete.numero,
                        style: context.textStyles.textSubTitleItemList.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: .w700,
                        ),
                      ),
                      Text(lembrete.assunto, style: context.textStyles.textSubTitleItemList),
                    ],
                  ),
                ),
                children: [
                  if (lembrete.descricao != null && lembrete.descricao!.isNotEmpty) ...[
                    Align(
                      alignment: .topStart,
                      child: Text(
                        'Descrição:',
                        textAlign: TextAlign.justify,
                        style: context.textStyles.textTitleItemList.copyWith(fontSize: 14),
                      ),
                    ),
                    Text(
                      lembrete.descricao!,
                      textAlign: TextAlign.justify,
                      style: context.textStyles.textSubTitleItemList,
                    ),
                    const SizedBox(height: 10),
                  ],

                  // Bloco de metadados
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: .5)),
                    ),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 12,
                      children: [
                        _buildDetalhe(label: 'Tipo', value: lembrete.tipo, theme: theme),
                        _buildDetalhe(label: 'Órgão', value: lembrete.orgao, theme: theme, isFullWidth: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(top: 0, bottom: 0, left: 0, child: Container(width: 5, color: corDestaque)),
        ],
      ),
    );
  }

  Widget _buildDetalhe({
    required String label,
    required String value,
    required ThemeData theme,
    bool isFullWidth = false,
  }) {
    return FractionallySizedBox(
      widthFactor: isFullWidth ? 1.0 : 0.45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              fontSize: 10,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
