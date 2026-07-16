import 'package:flutter/material.dart';

import '../../../../../../../core/ui/theme/styles/text_styles.dart';
import '../../../enum/acao_solicitacao.dart';
import '../../../models/documento_model.dart';
import '../../decidir_solicitacao/decidir_solicitacao_page.dart';

class AcaoSolcitacaoSheet extends StatefulWidget {
  final DocumentoModel solicitacao;

  const AcaoSolcitacaoSheet({super.key, required this.solicitacao});

  @override
  State<AcaoSolcitacaoSheet> createState() => _AcaoSolcitacaoSheetState();
}

class _AcaoSolcitacaoSheetState extends State<AcaoSolcitacaoSheet> {
  DocumentoModel get solicitacao => widget.solicitacao;

  AcaoSolicitacao? _acao;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final corSituacao = solicitacao.corSituacao();

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, MediaQuery.of(context).padding.bottom + 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Outras ações', style: context.textStyles.textTitle.copyWith(fontSize: 22)),

            ListTile(
              // contentPadding: EdgeInsets.zero,
              leading: solicitacao.image,
              title: Text(solicitacao.numero, style: context.textStyles.textTitleItemList),
              subtitle: Text(
                '${solicitacao.tipoDocumento.name} • ${solicitacao.tipoSolicitacao.name}',
                style: context.textStyles.textSubTitleItemList,
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: corSituacao.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  solicitacao.tipoSituacao.name.toUpperCase(),
                  style: textTheme.labelSmall?.copyWith(
                    color: corSituacao,

                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),

            Divider(height: 5, color: Colors.grey.shade300),

            RadioGroup<AcaoSolicitacao>(
              groupValue: _acao,
              onChanged: (value) {
                setState(() {
                  _acao = value;
                });
              },
              child: Column(
                children: [
                  RadioListTile<AcaoSolicitacao>(
                    value: AcaoSolicitacao.atender,
                    title: Text('Atender solicitação de ${solicitacao.tipoSolicitacao.name.toLowerCase()}'),
                    subtitle: const Text('Abrir o documento para analisar e registrar a decisão.'),
                  ),
                  RadioListTile<AcaoSolicitacao>(
                    value: AcaoSolicitacao.rejeitar,
                    title: const Text('Rejeitar solicitação'),
                    subtitle: const Text('Recusar a solicitação e informar o motivo da rejeição.'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: Builder(
                builder: (context) {
                  final acao = _acao;
                  return ElevatedButton(
                    onPressed: acao == null ? null : () async => toDecidirSolicitacaoPage(acao: acao),
                    child: Text(textButton),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get textButton {
    final value = _acao;
    if (value == null) return 'Selecione uma opção';
    return value == .atender ? 'Atender' : 'Rejeitar';
  }

  Future<void> toDecidirSolicitacaoPage({required AcaoSolicitacao acao}) async {
    Navigator.pop(context, acao);

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          // Envia 2 solicitações repetidas apenas para teste.
          final solicitacoes = [solicitacao, solicitacao];
          return DecidirSolicitacaoPage(solicitacoes: solicitacoes, acao: acao);
        },
      ),
    );
  }
}
