import 'package:flutter/material.dart';

class DiaDaSemana extends StatelessWidget {
  final String title;
  const DiaDaSemana(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600, fontSize: 13, letterSpacing: .3),
        ),
      ),
    );
  }
}
