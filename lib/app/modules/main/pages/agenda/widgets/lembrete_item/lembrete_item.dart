import 'package:flutter/material.dart';

import '../../../../../../core/extensions/string_extension.dart';
import '../../../../../../core/ui/theme/styles/text_styles.dart';
import '../../../../../../shared/domain/agenda/entities/agenda_entity.dart';
import 'detalhe_lembrete_item.dart';

class LembreteItem extends StatelessWidget {
  final AgendaEntity lembrete;

  const LembreteItem({super.key, required this.lembrete});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: ExpansionTile(
              dense: true,
              backgroundColor: Colors.white,
              tilePadding: const EdgeInsets.only(left: 12, right: 16, top: 4, bottom: 4),
              childrenPadding: const EdgeInsets.only(left: 12, right: 12, bottom: 16),
              iconColor: colors.primary,
              title: Text(
                lembrete.titulo,
                textAlign: .justify,
                style: context.textStyles.textTitleItemList.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.onSurface,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      lembrete.numeroProcesso,
                      style: context.textStyles.textSubTitleItemList.copyWith(color: colors.primary, fontWeight: .w700),
                    ),
                    Text(lembrete.descricaoProcesso, style: context.textStyles.textSubTitleItemList),
                  ],
                ),
              ),
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: colors.outlineVariant.withValues(alpha: .5)),
                  ),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 12,
                    children: [
                      DetalheLembreteItem(
                        label: 'Descrição'.capitalize(),
                        value: lembrete.descricao,
                        isFullWidth: true,
                      ),
                      DetalheLembreteItem(label: 'Tipo', value: lembrete.tipoProcesso),
                      DetalheLembreteItem(label: 'Número', value: lembrete.numeroProcesso),
                      DetalheLembreteItem(label: 'Assunto/Natureza', value: lembrete.descricaoProcesso),
                      DetalheLembreteItem(label: 'Órgão', value: lembrete.orgaoProcesso, isFullWidth: true),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(top: 0, bottom: 0, left: 0, child: Container(width: 5, color: colors.secondary)),
        ],
      ),
    );
  }
}
