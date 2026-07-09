import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Importa o modelo Calendario que já existe no projeto
import '../../../models/calendario.dart';

/// Card individual de um processo.
/// Recebe um objeto [Calendario] e renderiza título, categoria, número e data.
/// Não contém lógica de negócio — é puramente visual.
class ItemProcesso extends StatelessWidget {
  final Calendario item;

  const ItemProcesso({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: GestureDetector(
        // Por enquanto sem ação — futuramente abrirá detalhes do processo
        onTap: () {},
        child: Row(
          children: [
            const SizedBox(width: 5),

            // Barra lateral colorida — indica visualmente a categoria
            Container(
              width: 4,
              height: 100,
              decoration: BoxDecoration(
                color: item.color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            // Conteúdo principal do card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título do evento/processo
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Badge da categoria com cor de fundo translúcida
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: item.color.withOpacity(.12),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        item.category,
                        style: TextStyle(
                          color: item.color,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Linha com ícone de pasta + número do processo
                    Row(
                      children: [
                        Icon(
                          Icons.folder_outlined,
                          size: 18,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Processo ${item.process}',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Linha com ícone de calendário + data formatada
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 16,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('dd/MM/yyyy').format(item.date),
                          style: TextStyle(color: Colors.grey.shade700),
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
              child: Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
