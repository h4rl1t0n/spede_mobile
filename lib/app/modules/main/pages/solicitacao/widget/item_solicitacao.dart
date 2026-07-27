import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../../../core/ui/theme/styles/text_styles.dart';
import '../../../../../core/ui/widgets/item_tile.dart';
import '../../../../../models/documento_model.dart';
import '../solicitacao_controller.dart';

class ItemSolicitacao extends StatefulWidget {
  final SolicitacaoController controller;
  final DocumentoModel solicitacao;

  const ItemSolicitacao({super.key, required this.solicitacao, required this.controller});

  @override
  State<ItemSolicitacao> createState() => _ItemSolicitacaoState();
}

class _ItemSolicitacaoState extends State<ItemSolicitacao> {
  SolicitacaoController get controller => widget.controller;
  DocumentoModel get solicitacao => widget.solicitacao;
  late final ExpansibleController expansibleController;

  @override
  void initState() {
    super.initState();
    expansibleController = ExpansibleController();
  }

  @override
  void dispose() {
    expansibleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final secondary = Theme.of(context).colorScheme.secondary.withValues(alpha: .08);
    final corDocumento = widget.solicitacao.corDocumento();

    return Observer(
      builder: (context) {
        final documentos = widget.controller.selecionados;
        final isSelecionado = documentos.contains(widget.solicitacao);
        final color = isSelecionado ? secondary : Colors.white;

        return Dismissible(
          key: ValueKey(widget.solicitacao.id),
          dismissThresholds: const {DismissDirection.endToStart: 0.1},
          confirmDismiss: confirmDismiss,
          child: Row(
            children: [
              if (widget.controller.modoSelecao) ...[
                Checkbox(
                  visualDensity: .compact,
                  value: isSelecionado,
                  onChanged: (bool? value) {
                    toggleSelecionado();
                  },
                ),
              ],
              Flexible(
                child: GestureDetector(
                  //  New
                  onTap: controller.modoSelecao ? toggleSelecionado : null,

                  onLongPress: toggleSelecionado,
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
                            //  New
                            enabled: !controller.modoSelecao,
                            splashColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            controller: expansibleController,
                            dense: true,
                            collapsedBackgroundColor: color,
                            backgroundColor: color,
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  widget.solicitacao.image,
                                  Expanded(
                                    child: Text(widget.solicitacao.numero, style: context.textStyles.textTitleItemList),
                                  ),
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
                                      subTitle: widget.solicitacao.tipoDocumento.name,
                                    ),
                                  ),
                                  Expanded(
                                    child: ItemTile(
                                      padding: EdgeInsets.zero,
                                      title: 'Assunto',
                                      textAlign: .start,
                                      subTitle: widget.solicitacao.assunto,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //  showTrailingIcon: false,
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
                                          subTitle: widget.solicitacao.tipoSolicitacao.label,
                                        ),
                                      ),
                                      Expanded(
                                        child: ItemTile(
                                          padding: EdgeInsets.zero,
                                          title: 'Data Solicitação',
                                          subTitle: DateFormat('dd/MM/yyyy').format(widget.solicitacao.dataSolicitacao),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  ItemTile(
                                    padding: EdgeInsets.zero,
                                    title: 'Remetente',
                                    subTitle: widget.solicitacao.remetente,
                                  ),
                                  const SizedBox(height: 5),
                                  ItemTile(
                                    padding: EdgeInsets.zero,
                                    title: 'Destinatário',
                                    subTitle: widget.solicitacao.destinatario,
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
    widget.controller.toggle(widget.solicitacao);
  }

  Future<bool?> confirmDismiss(DismissDirection direction) async {
    if (direction == .endToStart) toggleSelecionado();
    return false;
  }
}
