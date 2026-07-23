import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../core/constants/routes.dart';
import '../../../../../../core/ui/theme/styles/button_styles.dart';
import '../../../../../../enum/acao_solicitacao.dart';
import '../../../../../../enum/tipo_caixa.dart';
import '../../../../../../enum/tipo_solicitacao.dart';
import '../../../../../../models/documento_model.dart';
import 'item_solicitacao_sheet.dart';

class AcaoSolcitacaoSheet extends StatefulWidget {
  final TipoCaixa caixa;
  final List<DocumentoModel> selecionados;

  const AcaoSolcitacaoSheet({super.key, required this.selecionados, required this.caixa});

  @override
  State<AcaoSolcitacaoSheet> createState() => _AcaoSolcitacaoSheetState();
}

class _AcaoSolcitacaoSheetState extends State<AcaoSolcitacaoSheet> {
  TipoCaixa get caixa => widget.caixa;
  List<DocumentoModel> get selecionados => widget.selecionados;
  TipoSolicitacao get solicitacao => selecionados.first.tipoSolicitacao;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 16),
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Solicitação de ${solicitacao.label}',
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
                            '${selecionados.length} ${selecionados.length == 1 ? 'item' : 'itens'} selecionados',
                            style: TextStyle(fontSize: 14, fontFamily: 'Cabin', color: colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),
                const Divider(indent: 20, endIndent: 20),
                const SizedBox(height: 4),

                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    controller: scrollController,
                    itemCount: selecionados.length,
                    itemBuilder: (ctx, index) {
                      final solicitacao = selecionados[index];
                      return ItemSolicitacaoSheet(solicitacao: solicitacao);
                    },
                  ),
                ),

                Divider(height: 1, indent: 20, endIndent: 20, color: Colors.red.shade300),
                const SizedBox(height: 10),

                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      children: [
                        if (caixa == TipoCaixa.recebidas) ...[
                          Expanded(
                            child: SizedBox(
                              height: 45,
                              child: ElevatedButton.icon(
                                style: ButtonStyles.instance.secondary,
                                icon: const Icon(Icons.check_circle),
                                label: const Text('Atender'),
                                onPressed: () async {
                                  await toRouteDecidirSolicitacaoPage(acao: AcaoSolicitacao.atender);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: ElevatedButton.icon(
                              style: ButtonStyles.instance.secondary.copyWith(
                                backgroundColor: WidgetStatePropertyAll(colorScheme.error),
                              ),
                              icon: const Icon(Icons.cancel),
                              label: const Text('Rejeitar'),
                              onPressed: () async {
                                await toRouteDecidirSolicitacaoPage(acao: AcaoSolicitacao.rejeitar);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> toRouteDecidirSolicitacaoPage({required AcaoSolicitacao acao}) async {
    Modular.to.pop(acao);
    await Modular.to.pushNamed(Routes.decidirSolicitacao, arguments: {'acao': acao, 'selecionados': selecionados});
  }
}
