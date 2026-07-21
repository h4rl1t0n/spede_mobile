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
    final secondary = Theme.of(context).colorScheme.secondary.withValues(alpha: .08);
    final expansibleController = ExpansibleController();
    final corDocumento = solicitacao.corDocumento();

    return Observer(
      builder: (context) {
        final documentos = controller.selecionados;
        final isSelecionado = documentos.contains(solicitacao);
        return Dismissible(
          key: ValueKey(solicitacao.id),
          dismissThresholds: const {DismissDirection.endToStart: 0.1},
          confirmDismiss: confirmDismiss,
          child: Row(
            children: [
              if (controller.modoSelecao) ...[
                IconButton(
                  onPressed: toggleSelecionado,
                  icon: Icon(isSelecionado ? Icons.radio_button_on : Icons.radio_button_off),
                ),
              ],
              Flexible(
                child: GestureDetector(
                  onLongPress: toggleSelecionado,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
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
                            collapsedBackgroundColor: isSelecionado ? secondary : Colors.white,
                            backgroundColor: isSelecionado ? secondary : Colors.white,
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  solicitacao.image,
                                  Expanded(
                                    child: Text(solicitacao.numero, style: context.textStyles.textTitleItemList),
                                  ),
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
                                  ItemTile(
                                    padding: EdgeInsets.zero,
                                    title: 'Remetente',
                                    subTitle: solicitacao.remetente,
                                  ),
                                  const SizedBox(height: 5),
                                  ItemTile(
                                    padding: EdgeInsets.zero,
                                    title: 'Destinatário',
                                    subTitle: solicitacao.destinatario,
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
              ),
            ],
          ),
        );
      },
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

  Future<bool?> confirmDismiss(DismissDirection direction) async {
    if (direction == DismissDirection.endToStart) {
      toggleSelecionado();
    }

    return false;
  }
}
