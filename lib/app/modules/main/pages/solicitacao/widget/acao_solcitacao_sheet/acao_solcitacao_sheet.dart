import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../../enum/acao_solicitacao.dart';
import '../../../../../../enum/tipo_caixa.dart';
import '../../submodules/decidir_solicitacao/decidir_solicitacao_page.dart';
import '../../solicitacao_controller.dart';
import 'action_button.dart';
import 'item_solicitacao_sheet.dart';

class AcaoSolcitacaoSheet extends StatefulWidget {
  final TipoCaixa caixa;
  final SolicitacaoController controller;

  const AcaoSolcitacaoSheet({super.key, required this.controller, required this.caixa});

  @override
  State<AcaoSolcitacaoSheet> createState() => _AcaoSolcitacaoSheetState();
}

class _AcaoSolcitacaoSheetState extends State<AcaoSolcitacaoSheet> {
  SolicitacaoController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: MediaQuery.of(context).padding.bottom + 16),
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Observer(
              builder: (context) {
                final selecionados = controller.selecionados;

                if (selecionados.isEmpty) return SizedBox.shrink();

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.caixa.descricao,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cabin',
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          spacing: 4,
                          children: [
                            Icon(Icons.business_center, size: 15, color: colorScheme.onSurfaceVariant),
                            Text(
                              '${selecionados.length} ${selecionados.length == 1 ? 'solicitação' : 'solicitações'} de ${selecionados.first.tipoSolicitacao.name.toLowerCase()}',
                              style: TextStyle(fontSize: 14, fontFamily: 'Cabin', color: colorScheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    const Divider(indent: 20, endIndent: 20),
                    const SizedBox(height: 4),

                    Expanded(
                      child: ListView.separated(
                        controller: scrollController,
                        itemCount: selecionados.length,
                        separatorBuilder: (ctx, i) {
                          return Divider(
                            height: 1,
                            indent: 16,
                            endIndent: 16,
                            color: colorScheme.outlineVariant.withValues(alpha: 0.16),
                          );
                        },
                        itemBuilder: (ctx, index) {
                          final solicitacao = selecionados[index];
                          return ItemSolicitacaoSheet(solicitacao: solicitacao);
                        },
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey.shade300)),
                      ),
                      child: Row(
                        spacing: 5,
                        children: [
                          Expanded(
                            child: ActionButton(
                              icon: controller.acao == .atender ? Icons.radio_button_on : Icons.radio_button_off,
                              title: 'Atender solicitação',
                              subtitle: 'Abrir o documento para analisar e registrar a decisão.',
                              isNull: controller.acao == null,
                              onTap: () {
                                controller.acao = .atender;
                              },
                            ),
                          ),
                          Expanded(
                            child: ActionButton(
                              icon: controller.acao == .rejeitar ? Icons.radio_button_on : Icons.radio_button_off,
                              title: 'Rejeitar solicitação',
                              subtitle: 'Recusar a solicitação e informar o motivo da rejeição.',
                              isNull: controller.acao == null,
                              onTap: () {
                                controller.acao = .rejeitar;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: Observer(
                        builder: (context) {
                          final acao = controller.acao;
                          return ElevatedButton(
                            onPressed: acao == null ? null : () async => toDecidirSolicitacaoPage(acao: acao),
                            child: Text(textButton),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  String get textButton {
    final acao = controller.acao;

    if (acao == null) return 'Selecione uma opção';
    return acao == .atender ? 'Atender' : 'Rejeitar';
  }

  Future<void> toDecidirSolicitacaoPage({required AcaoSolicitacao acao}) async {
    Navigator.pop(context, acao);

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return DecidirSolicitacaoPage(controller: controller);
        },
      ),
    );
  }
}
