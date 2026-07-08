import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../mock/mock.dart';

class ListaEventos extends StatelessWidget {
  final DateTime data;

  const ListaEventos({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final eventosDoDia = eventos.where((evento) {
      return evento.date.year == data.year && evento.date.month == data.month && evento.date.day == data.day;
    }).toList();

    return Column(
      children: [
        _Header(data: data, quantidade: eventosDoDia.length),

        Expanded(
          child: eventosDoDia.isEmpty
              ? const _EmptyState()
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: eventosDoDia.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (_, index) {
                    final item = eventosDoDia[index];

                    return _EventoCard(item: item);
                  },
                ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final DateTime data;
  final int quantidade;

  const _Header({required this.data, required this.quantidade});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat("EEEE, d 'de' MMMM 'de' y", 'pt_BR');

    final texto = '${formatter.format(data)[0].toUpperCase()}${formatter.format(data).substring(1)}';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(texto, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            quantidade == 0 ? 'Nenhum evento' : '$quantidade evento${quantidade > 1 ? "s" : ""}',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

class _EventoCard extends StatelessWidget {
  final dynamic item;

  const _EventoCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),

      child: GestureDetector(
        onTap: () {
          // abrir detalhes futuramente
        },
        child: Row(
          children: [
            const SizedBox(width: 5),
            Container(
              width: 4,
              height: 100,
              decoration: BoxDecoration(color: item.color, borderRadius: BorderRadius.circular(4)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: item.color.withOpacity(.12),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        item.category,
                        style: TextStyle(color: item.color, fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Icon(Icons.folder_outlined, size: 18, color: Colors.grey.shade600),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text('Processo ${item.process}', style: TextStyle(color: Colors.grey.shade700)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey.shade600),
                        const SizedBox(width: 8),
                        Text(DateFormat('dd/MM/yyyy').format(item.date), style: TextStyle(color: Colors.grey.shade700)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Icon(Icons.chevron_right_rounded, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 5,
          children: [
            Icon(Icons.calendar_month, size: 64, color: Colors.grey.shade400),
            const Text('Nenhum evento encontrado', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(
              'Não há compromissos cadastrados para esta data.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
