import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../mock/eventos.dart';
import '../../solicitacao/widget/item_solicitacao.dart';

class ListaEventos extends StatelessWidget {
  final DateTime data;

  const ListaEventos({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final eventosDoDia = eventos.where((evento) {
      return evento.dataSolicitacao.year == data.year &&
          evento.dataSolicitacao.month == data.month &&
          evento.dataSolicitacao.day == data.day;
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

                    return ItemSolicitacao(solicitacao: item);
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
