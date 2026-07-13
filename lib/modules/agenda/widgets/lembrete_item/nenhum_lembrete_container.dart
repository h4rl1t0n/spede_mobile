import 'package:flutter/material.dart';

class NenhumLembreteContainer extends StatelessWidget {
  const NenhumLembreteContainer({super.key});

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
            const Text('Nenhum lembrete encontrado', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(
              'Não há lembretes cadastrados para esta data.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
