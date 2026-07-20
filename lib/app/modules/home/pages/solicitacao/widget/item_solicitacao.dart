import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../../../core/ui/theme/styles/text_styles.dart';
import '../../../../../core/ui/widgets/item_tile.dart';
import '../../../../../models/documento_model.dart';
import '../solicitacao_controller.dart';
import 'acao_solcitacao_sheet.dart';

class ItemSolicitacao extends StatelessWidget {
  final SolicitacaoController controller;
  final DocumentoModel solicitacao;

  const ItemSolicitacao({super.key, required this.solicitacao, required this.controller});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary.withValues(alpha: .2);
    final expansibleController = ExpansibleController();
    final corDocumento = solicitacao.corDocumento();

    return Observer(
      builder: (context) {
        final documentos = controller.selecionados;
        final isSelecionado = documentos.contains(solicitacao);
        return Dismissible(
          key: ValueKey(solicitacao.id),
          dismissThresholds: const {DismissDirection.endToStart: 0.1},
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              toggleSelecionado();
            }

            return false; // impede a remoção
          },

          child: GestureDetector(
            onLongPress: toggleSelecionado,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              // Substituímos o IntrinsicHeight e a Row por um Stack
              child: Stack(
                children: [
                  Positioned(top: 0, bottom: 0, left: 0, width: 5, child: Container(color: corDocumento)),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: ExpansionTile(
                      splashColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      controller: expansibleController,
                      dense: true,
                      collapsedBackgroundColor: isSelecionado ? secondary.withValues(alpha: .15) : Colors.white,
                      backgroundColor: isSelecionado ? secondary.withValues(alpha: .15) : Colors.white,
                      leading: controller.modoSelecao
                          ? InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashColor: secondary.withValues(alpha: .5),
                              onTap: controller.modoSelecao ? toggleSelecionado : null,
                              child: Icon(
                                isSelecionado ? Icons.check_circle : Icons.circle_outlined,
                                color: isSelecionado ? primary : Colors.grey,
                              ),
                            )
                          : null,
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
                                padding: EdgeInsets.zero,
                                title: 'Documento',
                                subTitle: solicitacao.tipoDocumento.name,
                              ),
                            ),
                            Expanded(
                              child: ItemTile(
                                padding: EdgeInsets.zero,
                                title: 'Assunto',
                                subTitle: solicitacao.assunto,
                              ),
                            ),
                          ],
                        ),
                      ),
                      showTrailingIcon: false,
                      children: [
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ItemTile(
                                    padding: EdgeInsets.zero,
                                    title: 'Solicitação',
                                    subTitle: solicitacao.tipoSolicitacao.name,
                                  ),
                                ),
                                Expanded(
                                  child: ItemTile(
                                    padding: EdgeInsets.zero,
                                    title: 'Data Solicitação',
                                    subTitle: DateFormat('dd/MM/yyyy').format(solicitacao.dataSolicitacao),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            ItemTile(padding: EdgeInsets.zero, title: 'Remetente', subTitle: solicitacao.remetente),
                            const SizedBox(height: 5),
                            ItemTile(
                              padding: EdgeInsets.zero,
                              title: 'Destinatário',
                              subTitle: solicitacao.destinatario,
                            ),
                            const SizedBox(height: 15),
                            Divider(color: Colors.grey.shade300),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  onPressed: toggleSelecionado,
                                  iconAlignment: IconAlignment.end,
                                  icon: const Icon(Icons.chevron_right),
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

  Future<void> abrirAcoes(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => AcaoSolcitacaoSheet(solicitacao: solicitacao),
    );
  }

  void toggleSelecionado() {
    final documentos = controller.selecionados;

    if (documentos.contains(solicitacao)) {
      documentos.remove(solicitacao);
    } else {
      documentos.add(solicitacao);
    }
  }
}
