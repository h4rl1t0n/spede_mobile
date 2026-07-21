import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../controller/perfil_controller.dart';

class HeaderPerfilContainer extends StatelessWidget {
  final PerfilController controller;

  const HeaderPerfilContainer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [cs.primary, Color.lerp(cs.primary, Colors.black, .18)!],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 10),
        child: Column(
          children: [
            Observer(
              builder: (context) {
                final usuario = controller.usuario;
                return Row(
                  spacing: 20,
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
                        child: Center(
                          child: Text(
                            usuario?.avatar ?? '',
                            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bem-vindo', style: TextStyle(color: Colors.white.withValues(alpha: .75), fontSize: 13)),
                          Text(
                            usuario?.nome.toUpperCase() ?? '',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            usuario?.email.toLowerCase() ?? '',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white.withValues(alpha: .90), fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 15),
            Divider(height: 0),
            SizedBox(height: 5),
            Observer(
              builder: (_) {
                final setor = controller.setorSelecionado;

                if (setor == null) {
                  return const SizedBox.shrink();
                }

                return Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    spacing: 5,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          maxLines: 3,
                          '${setor.sigla} • ${setor.nome}',
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
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
    );
  }
}
