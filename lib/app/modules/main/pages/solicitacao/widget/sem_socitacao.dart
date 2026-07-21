import 'package:flutter/material.dart';

import '../../../../../enum/tipo_caixa.dart';
import '../../../../../enum/tipo_solicitacao.dart';

class SemSocitacao extends StatelessWidget {
  final TipoCaixa caixa;
  final TipoSolicitacao? solicitacao;
  const SemSocitacao({super.key, required this.caixa, this.solicitacao});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.list, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 8),
            Text(
              solicitacao == null
                  ? 'Nenhuma ${caixa.descricao.toLowerCase()}.'
                  : 'Nenhuma solicitação de ${solicitacao?.name.toLowerCase()}.',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Não há solicitação disponíveis.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
