import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/ui/theme/styles/text_styles.dart';
import '../../../core/ui/widgets/info_card.dart';
import '../../../models/documento_model.dart';
import 'acao_solcitacao_sheet.dart';

class ItemSolicitacao extends StatelessWidget {
  final DocumentoModel solicitacao;

  const ItemSolicitacao({super.key, required this.solicitacao});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final corSituacao = solicitacao.corSituacao();
    final corDocumento = solicitacao.corDocumento();

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),

      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 6, color: corDocumento),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        solicitacao.image,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(solicitacao.tipoDocumento.name, style: context.textStyles.textSubTitleItemList),
                              Text(solicitacao.numero, style: context.textStyles.textTitleItemList),
                            ],
                          ),
                        ),

                        const SizedBox(width: 8),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: corSituacao.withValues(alpha: .12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            solicitacao.tipoSituacao.name.toUpperCase(),
                            style: textTheme.labelSmall?.copyWith(
                              color: corSituacao,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Assunto
                    Text(solicitacao.assunto, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),

                    const SizedBox(height: 10),

                    // Detalhes com Ícones (Método extraído para limpeza do código)
                    InfoCard(
                      icon: Icons.description_outlined,
                      titulo: 'Solicitação',
                      valor: solicitacao.tipoSolicitacao.name,
                    ),
                    const SizedBox(height: 8),
                    InfoCard(icon: Icons.person_outline, titulo: 'De', valor: solicitacao.remetente),
                    const SizedBox(height: 8),
                    InfoCard(icon: Icons.person_pin_circle_outlined, titulo: 'Para', valor: solicitacao.destinatario),
                    const SizedBox(height: 8),
                    InfoCard(
                      icon: Icons.calendar_month_outlined,
                      titulo: 'Data Solicitação',
                      valor: DateFormat('dd/MM/yyyy').format(solicitacao.dataSolicitacao),
                    ),

                    const SizedBox(height: 12),
                    Divider(),

                    Row(
                      mainAxisAlignment: .end,
                      children: [
                        TextButton.icon(
                          onPressed: () => _abrirAcoes(context),
                          icon: const Icon(Icons.more_horiz, size: 20),
                          label: const Text('Outras ações'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- MÉTODOS AUXILIARES ---

  Future<void> _abrirAcoes(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => AcaoSolcitacaoSheet(solicitacao: solicitacao),
    );
  }
}
