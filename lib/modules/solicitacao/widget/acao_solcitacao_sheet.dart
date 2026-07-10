import 'package:flutter/material.dart';

import '../../../../../../../core/ui/theme/styles/text_styles.dart';
import '../../../models/documento_model.dart';
import '../../aceitar_solicitacao/aceitar_solitacao.dart';
import '../../rejeitar_solicitacao/rejeitar_solicitacao.dart';

enum AcaoSolicitacao {
  atender('Atender'),
  rejeitar('Rejeitar');

  final String label;

  const AcaoSolicitacao(this.label);
}

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
              contentPadding: EdgeInsets.zero,
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

            const Divider(height: 5),

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
                    secondary: const Icon(Icons.check_circle, color: Colors.green),
                  ),
                  RadioListTile<AcaoSolicitacao>(
                    value: AcaoSolicitacao.rejeitar,
                    title: const Text('Rejeitar solicitação'),
                    subtitle: const Text('Recusar a solicitação e informar o motivo da rejeição.'),
                    secondary: const Icon(Icons.cancel, color: Colors.red),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _acao == null
                    ? null
                    : () async {
                        switch (_acao) {
                          case AcaoSolicitacao.atender:
                            Navigator.pop(context, AcaoSolicitacao.atender);
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  return AceitarSolicitacao(solicitacoes: [solicitacao]);
                                },
                              ),
                            );
                            break;

                          case AcaoSolicitacao.rejeitar:
                            Navigator.pop(context, AcaoSolicitacao.rejeitar);
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  return RejeitarSolicitacao(solicitacoes: [solicitacao]);
                                },
                              ),
                            );
                            break;

                          case null:
                            break;
                        }
                      },
                child: Text(textButton),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get textButton {
    final value = _acao;

    if (value == null) {
      return 'Selecione uma opção';
    }

    return value == .atender ? AcaoSolicitacao.atender.label : AcaoSolicitacao.rejeitar.label;
  }
}
