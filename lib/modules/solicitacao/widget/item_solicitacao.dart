import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/ui/widgets/info_card.dart';
import '../../../models/documento_model.dart';

class ItemSolicitacao extends StatelessWidget {
  final DocumentoModel item;

  const ItemSolicitacao({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final color = item.corSituacao();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                children: [
                  item.image,

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.tipoDocumento.name, style: TextStyle(color: Colors.grey.shade600)),
                        Text(item.numero, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: .12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      item.tipoSituacao.name,
                      style: TextStyle(color: color, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Expanded(
                    child: InfoCard(icon: Icons.description_outlined, titulo: 'Assunto', valor: item.assunto),
                  ),
                  Expanded(
                    child: InfoCard(
                      icon: Icons.assignment_turned_in_outlined,
                      titulo: 'Solicitação',
                      valor: item.tipoSolicitacao.name,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              InfoCard(icon: Icons.person_outline, titulo: 'Remetente', valor: item.remetente),

              const SizedBox(height: 12),

              InfoCard(icon: Icons.person_pin_circle_outlined, titulo: 'Destinatário', valor: item.destinatario),

              const SizedBox(height: 12),

              InfoCard(
                icon: Icons.calendar_today_outlined,
                titulo: 'Data da Solicitação',
                valor: DateFormat('dd/MM/yyyy').format(item.dataSolicitacao),
              ),

              const Divider(height: 20),

              Row(
                mainAxisAlignment: .end,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz),
                    label: const Text('Outras ações'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
