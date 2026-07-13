import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderLembrete extends StatelessWidget {
  final DateTime data;
  final int quantidade;

  const HeaderLembrete({super.key, required this.data, required this.quantidade});

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
            quantidade == 0 ? 'Nenhum lembrete' : '$quantidade evento${quantidade > 1 ? "s" : ""}',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
