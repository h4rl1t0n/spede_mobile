import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../core/constants/routes.dart';
import '../../../../../../core/ui/theme/styles/button_styles.dart';
import '../../../../../../enum/acao_solicitacao.dart';
import '../../../../../../enum/tipo_caixa.dart';
import '../../solicitacao_controller.dart';
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

                    const SizedBox(height: 8),
                    Divider(indent: 20, endIndent: 20, color: Colors.grey.shade400),
                    const SizedBox(height: 4),

                    Container(
                      decoration: BoxDecoration(),
                      child: Row(
                        spacing: 10,
                        mainAxisAlignment: .center,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ButtonStyles.instance.secondary,
                              icon: Icon(Icons.check_circle),
                              label: Text('Atender'.toUpperCase()),
                              onPressed: () async {
                                await toRouteDecidirSolicitacaoPage(acao: .atender);
                              },
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ButtonStyles.instance.secondary.copyWith(
                                backgroundColor: WidgetStatePropertyAll(colorScheme.error),
                              ),
                              icon: Icon(Icons.cancel),
                              label: Text('Rejeitar'.toUpperCase()),
                              onPressed: () async {
                                await toRouteDecidirSolicitacaoPage(acao: .rejeitar);
                              },
                            ),
                          ),
                        ],
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

  Future<void> toRouteDecidirSolicitacaoPage({required AcaoSolicitacao acao}) async {
    Modular.to.pop(acao);

    await Modular.to.pushNamed(
      Routes.decidirSolicitacao,
      arguments: {'acao': acao, 'selecionados': controller.selecionados},
    );
  }
}
