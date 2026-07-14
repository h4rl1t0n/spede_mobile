import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../home_controller.dart';

class DrawerHead extends StatelessWidget {
  final HomeController controller;

  const DrawerHead({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    const nomeUsuario = 'Antônio Hárliton Martins de Souza';

    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [cs.primary, Color.lerp(cs.primary, Colors.black, .18)!],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              spacing: 10,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'avatar_usuario',
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: .12),
                          border: Border.all(color: Colors.white.withValues(alpha: .35), width: 2),
                        ),
                        child: const Center(
                          child: Text(
                            'AH',
                            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 18),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bem-vindo', style: TextStyle(color: Colors.white.withValues(alpha: .75), fontSize: 13)),

                          const SizedBox(height: 4),

                          Text(
                            nomeUsuario.toUpperCase(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Observer(
                  builder: (_) {
                    final setor = controller.setorSelecionado;

                    if (setor == null) {
                      return const SizedBox.shrink();
                    }

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                      child: Row(
                        spacing: 5,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              maxLines: 3,
                              '${setor.sigla} • ${setor.nome}',
                              textAlign: .justify,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
