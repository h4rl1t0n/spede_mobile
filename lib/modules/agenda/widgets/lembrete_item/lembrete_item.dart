import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      // Substituímos o IntrinsicHeight e Row por um Stack
      child: Stack(
        children: [
          // O conteúdo dita a altura do card
          Padding(
            padding: const EdgeInsets.only(left: 4.0), // Dá espaço para a faixa colorida
            child: Theme(
              data: theme.copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: const EdgeInsets.only(left: 12, right: 16, top: 4, bottom: 4),
                childrenPadding: const EdgeInsets.only(left: 12, right: 12, bottom: 16),
                iconColor: theme.colorScheme.primary,
                collapsedIconColor: Colors.grey.shade600,

                // --- ÁREA SEMPRE VISÍVEL ---
                title: Text(
                  lembrete.titulo,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: lembrete.isLembrete ? corDestaque : theme.colorScheme.onSurface,
                    fontSize: 16,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  // Trocamos Row por Wrap para evitar estouros laterais em telas pequenas
                  child: Wrap(
                    spacing: 12, // Espaço horizontal entre os itens
                    runSpacing: 4, // Espaço vertical se quebrar a linha
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.calendar_month_rounded, size: 16, color: corDestaque),
                          const SizedBox(width: 6),
                          Text(
                            'Vence em: ${DateFormat('dd/MM/yyyy').format(lembrete.data)}',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: corDestaque,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      if (lembrete.isLembrete)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.notifications_active, color: Colors.orange.shade700, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              'Lembrete',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.orange.shade700,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                // --- ÁREA EXPANSÍVEL (Detalhes) ---
                children: [
                  if (lembrete.descricao != null && lembrete.descricao!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      lembrete.descricao!,
                      textAlign: TextAlign.justify,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 16),
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
                      spacing: 16,
                      runSpacing: 12,
                      children: [
                        _buildDetalhe(label: 'Tipo', value: lembrete.tipo, theme: theme),
                        _buildDetalhe(label: 'Número', value: lembrete.numero, theme: theme),
                        _buildDetalhe(label: 'Assunto', value: lembrete.assunto, theme: theme, isFullWidth: true),
                        _buildDetalhe(label: 'Órgão', value: lembrete.orgao, theme: theme, isFullWidth: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // A faixa colorida posicionada no Stack acompanhando a altura dinamicamente!
          Positioned(top: 0, bottom: 0, left: 0, child: Container(width: 4, color: corDestaque)),
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
          const SizedBox(height: 2),
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
