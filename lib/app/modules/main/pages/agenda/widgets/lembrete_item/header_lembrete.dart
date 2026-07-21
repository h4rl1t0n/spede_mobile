import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderLembrete extends StatelessWidget {
  final DateTime data;
  final int quantidade;

  const HeaderLembrete({super.key, required this.data, required this.quantidade});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final formatter = DateFormat('d MMMM y', 'pt_BR');
    final texto = '${formatter.format(data)[0].toUpperCase()}${formatter.format(data).substring(1)}';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Row(
        spacing: 8,
        children: [
          CircleAvatar(
            backgroundColor: cs.primary,
            child: Icon(Icons.calendar_month_outlined, color: Colors.white),
          ),
          Text(
            '${texto.toUpperCase()} ${quantidade > 0 ? '($quantidade)' : ''}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
