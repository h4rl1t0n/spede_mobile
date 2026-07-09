import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../enum/tipo_situacao.dart';
import '../../../models/documento_model.dart';

class ItemSolicitacao extends StatelessWidget {
  final DocumentoModel item;

  const ItemSolicitacao({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: GestureDetector(
        onTap: () {},
        child: IntrinsicHeight(
          child: Row(
            children: [
              const SizedBox(width: 5),

              // Barra lateral colorida — indica visualmente a categoria
              Container(
                width: 4,
                height: 200,
                decoration: BoxDecoration(color: item.color, borderRadius: BorderRadius.circular(4)),
              ),

              // Conteúdo principal do card
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Linha 1: Image + TipoDocumento ... Badge TipoSolicitação
                      Row(
                        children: [
                          item.image,
                          const SizedBox(width: 5),
                          Text(
                            item.tipoDocumento.name,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                              color: item.color.withValues(alpha: .12),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              item.tipoSolicitacao.name,
                              style: TextStyle(color: item.color, fontWeight: FontWeight.w600, fontSize: 12),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Linha 2: Folder + Número
                      Row(
                        children: [
                          Icon(Icons.folder_outlined, size: 18, color: Colors.grey.shade600),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(item.numero, style: TextStyle(color: Colors.grey.shade700)),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Linha 3: Documento + Assunto
                      Row(
                        children: [
                          Icon(Icons.description_outlined, size: 18, color: Colors.grey.shade600),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(item.assunto, style: TextStyle(color: Colors.grey.shade700)),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Linha 4: Remetente
                      Row(
                        children: [
                          Icon(Icons.arrow_upward_rounded, size: 18, color: Colors.grey.shade600),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(item.remetente, style: TextStyle(color: Colors.grey.shade700)),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Linha 5: Destinatário
                      Row(
                        children: [
                          Icon(Icons.arrow_downward_rounded, size: 18, color: Colors.grey.shade600),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(item.destinatario, style: TextStyle(color: Colors.grey.shade700)),
                          ),
                        ],
                      ),

                      // Divider
                      const Divider(height: 20),

                      // Linha 6: Badge Situação + Data
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                              color: _corSituacao(item.tipoSituacao).withValues(alpha: .12),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              item.tipoSituacao.name,
                              style: TextStyle(
                                color: _corSituacao(item.tipoSituacao),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey.shade600),
                              const SizedBox(width: 8),
                              Text(
                                DateFormat('dd/MM/yyyy').format(item.dataSolicitacao),
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Chevron indicando que o card é clicável
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Icon(Icons.chevron_right_rounded, color: Colors.grey.shade500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Retorna a cor correspondente ao tipo de situação.
  Color _corSituacao(TipoSituacao situacao) {
    return switch (situacao) {
      TipoSituacao.pendente => Colors.amber.shade700,
      TipoSituacao.deferida => Colors.green,
      TipoSituacao.indeferida => Colors.red,
    };
  }
}
