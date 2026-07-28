import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../../../core/ui/theme/styles/text_styles.dart';
import '../../../../../core/ui/widgets/item_tile.dart';
import '../../../../../enum/tipo_solicitacao.dart';
import '../../../../../models/documento_model.dart';
import '../solicitacao_controller.dart';

class ItemSolicitacao extends StatelessWidget {
  final TipoSolicitacao? categoriaSelecionada;
  final SolicitacaoController controller;
  final DocumentoModel solicitacao;

  const ItemSolicitacao({super.key, required this.solicitacao, required this.controller, this.categoriaSelecionada});

  @override
  Widget build(BuildContext context) {
    final secondary = Theme.of(context).colorScheme.secondary.withValues(alpha: .08);
    final corDocumento = solicitacao.corDocumento();

    return Observer(
      builder: (context) {
        final documentos = controller.selecionados;
        final isSelecionado = documentos.contains(solicitacao);
        final color = isSelecionado ? secondary : Colors.white;

        return Row(
          children: [
            if (categoriaSelecionada != null) ...[
              Visibility(
                visible: controller.modoSelecao,
                child: Checkbox(
                  visualDensity: .compact,
                  value: isSelecionado,
                  onChanged: (bool? value) {
                    toggleSelecionado();
                  },
                ),
              ),
            ],
            Flexible(
              child: GestureDetector(
                onTap: controller.modoSelecao ? toggleSelecionado : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
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
                          dense: true,
                          visualDensity: .compact,
                          enabled: !controller.modoSelecao,
                          collapsedBackgroundColor: color,
                          backgroundColor: color,
                          title: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                solicitacao.image,
                                Expanded(child: Text(solicitacao.numero, style: context.textStyles.textTitleItemList)),
                              ],
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ItemTile(padding: EdgeInsets.zero, title: 'Setor', subTitle: solicitacao.setor.nome),
                          ),

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
                                        title: 'Documento',
                                        subTitle: solicitacao.tipoDocumento.name,
                                      ),
                                    ),
                                    Expanded(
                                      child: ItemTile(
                                        padding: EdgeInsets.zero,
                                        title: 'Assunto',
                                        textAlign: .start,
                                        subTitle: solicitacao.assunto,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ItemTile(
                                        padding: EdgeInsets.zero,
                                        title: 'Solicitação',
                                        subTitle: solicitacao.tipoSolicitacao.label,
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
        );
      },
    );
  }

  void toggleSelecionado() {
    controller.toggle(solicitacao);
  }

  Future<bool?> confirmDismiss(DismissDirection direction) async {
    if (direction == .endToStart) toggleSelecionado();
    return false;
  }
}
