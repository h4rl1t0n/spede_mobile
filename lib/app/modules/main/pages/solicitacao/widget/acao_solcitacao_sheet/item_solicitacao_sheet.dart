import 'package:flutter/material.dart';

import '../../../../../../core/ui/theme/styles/text_styles.dart';
import '../../../../../../core/ui/widgets/info_card.dart';
import '../../../../../../models/documento_model.dart';

class ItemSolicitacaoSheet extends StatelessWidget {
  final DocumentoModel solicitacao;

  const ItemSolicitacaoSheet({super.key, required this.solicitacao});

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
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        solicitacao.image,
                        Text(solicitacao.numero, style: context.textStyles.textTitleItemList),
                      ],
                    ),

                    const SizedBox(height: 10),

                    InfoCard(titulo: 'Documento', valor: solicitacao.tipoDocumento.name),
                    const SizedBox(height: 5),
                    InfoCard(titulo: 'Assunto/Natureza', valor: solicitacao.assunto),
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
