import 'package:flutter/material.dart';

import '../../../../../models/usuario_model.dart';

class HeaderHomeContainer extends StatelessWidget {
  final UsuarioModel usuarioLogado;
  const HeaderHomeContainer({super.key, required this.usuarioLogado});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Olá, ${usuarioLogado.firstName}👋',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text('Bem-vindo ao sistema', style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}
