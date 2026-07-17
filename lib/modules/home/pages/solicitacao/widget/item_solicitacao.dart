import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../../../core/ui/theme/styles/text_styles.dart';
import '../../../../../core/ui/widgets/item_tile.dart';
import '../../../../../models/documento_model.dart';
import '../solicitacao_controller.dart';

class ItemSolicitacao extends StatelessWidget {
  final SolicitacaoController controller;
  final DocumentoModel solicitacao;

  const ItemSolicitacao({super.key, required this.solicitacao, required this.controller});

  @override
  Widget build(BuildContext context) {
    final teste = Theme.of(context).colorScheme.secondary.withValues(alpha: .1);
    final expansibleController = ExpansibleController();
    final corDocumento = solicitacao.corDocumento();

    return Observer(
      builder: (context) {
        return GestureDetector(
          onLongPress: () {
            if (controller.listDocumentosSelecionados.contains(solicitacao)) {
              controller.listDocumentosSelecionados.remove(solicitacao);
              return;
            }

            controller.listDocumentosSelecionados.add(solicitacao);
          },
          child: Container(
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
                    child: ExpansionTile(
                      controller: expansibleController,
                      collapsedBackgroundColor: controller.listDocumentosSelecionados.contains(solicitacao)
                          ? teste
                          : Colors.white,
                      backgroundColor: controller.listDocumentosSelecionados.contains(solicitacao)
                          ? teste
                          : Colors.white,
                      dense: true,
                      title: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            solicitacao.image,
                            Expanded(child: Text(solicitacao.numero, style: context.textStyles.textTitleItemList)),
                            Icon(expansibleController.isExpanded ? Icons.expand_less : Icons.expand_more),
                          ],
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: ItemTile(
                                padding: .zero,
                                title: 'Documento',
                                subTitle: solicitacao.tipoDocumento.name,
                              ),
                            ),
                            Expanded(
                              child: ItemTile(padding: .zero, title: 'Assunto', subTitle: solicitacao.assunto),
                            ),
                          ],
                        ),
                      ),
                      showTrailingIcon: false,
                      children: [
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: .start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ItemTile(
                                    padding: .zero,
                                    title: 'Solicitação',
                                    subTitle: solicitacao.tipoSolicitacao.name,
                                  ),
                                ),
                                Expanded(
                                  child: ItemTile(
                                    padding: .zero,
                                    title: 'Data Solicitação',
                                    subTitle: DateFormat('dd/MM/yyyy').format(solicitacao.dataSolicitacao),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            ItemTile(padding: .zero, title: 'Remetente', subTitle: solicitacao.remetente),
                            const SizedBox(height: 5),
                            ItemTile(padding: .zero, title: 'Destinatário', subTitle: solicitacao.destinatario),
                            const SizedBox(height: 15),

                            Divider(color: Colors.grey.shade300),

                            Row(
                              mainAxisAlignment: .end,
                              children: [
                                TextButton.icon(
                                  onPressed: () => _abrirAcoes(context),
                                  iconAlignment: .end,
                                  icon: Icon(Icons.chevron_right),
                                  label: const Text('Outras ações', style: TextStyle(fontSize: 15)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // --- MÉTODOS AUXILIARES ---

  Future<void> _abrirAcoes(BuildContext context) async {
    if (controller.listDocumentosSelecionados.contains(solicitacao)) {
      controller.listDocumentosSelecionados.remove(solicitacao);
      return;
    }

    controller.listDocumentosSelecionados.add(solicitacao);
    // await showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   builder: (_) => AcaoSolcitacaoSheet(solicitacao: solicitacao),
    // );
  }
}
