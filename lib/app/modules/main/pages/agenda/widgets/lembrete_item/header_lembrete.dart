import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderLembrete extends StatelessWidget {
  final DateTime data;
  final int quantidade;

  const HeaderLembrete({super.key, required this.data, required this.quantidade});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final String dataFormatada = DateFormat('dd MMM y', 'pt_BR').format(data).toUpperCase();
    final String total = quantidade == 1 ? '1 lembrete' : '$quantidade lembretes';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      decoration: BoxDecoration(color: cs.surface),
      child: Row(
        spacing: 12,
        children: [
          CircleAvatar(
            backgroundColor: cs.primary,
            foregroundColor: cs.onPrimary,
            child: const Icon(Icons.calendar_month_outlined),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  dataFormatada,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  total,
                  style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
