import 'package:flutter/material.dart';

import '../../../../../../../core/ui/theme/styles/text_styles.dart';
import '../../../../../../../core/ui/widgets/info_card.dart';
import '../../../../../../../models/documento_model.dart';

class ItemSolicitacaoDecidirCard extends StatelessWidget {
  final DocumentoModel solicitacao;

  const ItemSolicitacaoDecidirCard({super.key, required this.solicitacao});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        color: colorScheme.surface,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 6, color: solicitacao.corDocumento()),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        solicitacao.image,
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(solicitacao.tipoDocumento.name, style: context.textStyles.textSubTitleItemList),
                              Text(solicitacao.numero, style: context.textStyles.textTitleItemList),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    InfoCard(
                      
                      titulo: 'Assunto/Natureza',
                      valor: solicitacao.assunto,
                    ),
                    const SizedBox(height: 8),

                    InfoCard(
                      
                      titulo: 'Solicitação',
                      valor: solicitacao.tipoSolicitacao.name,
                    ),

                    const SizedBox(height: 8),

                    InfoCard( titulo: 'Remetente', valor: solicitacao.remetente),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
