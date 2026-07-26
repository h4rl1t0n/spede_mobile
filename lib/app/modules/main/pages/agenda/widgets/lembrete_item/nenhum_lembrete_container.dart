import 'package:flutter/material.dart';

class NenhumLembreteContainer extends StatelessWidget {
  const NenhumLembreteContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Não há lembretes cadastrados para esta data.',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}
