import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../menu_drawer/menu_drawer.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Builder(
      builder: (context) {
        return ListView(
          padding: const EdgeInsets.only(top: 8, bottom: 20, left: 8, right: 8),
          children: [
            SizedBox(height: 5),
            Row(
              spacing: 5,
              children: [
                Icon(Icons.person, color: cs.primary, size: 20),
                Text('Pessoal', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
              ],
            ),
            // MenuDrawer(icon: Icons.inbox, title: 'Caixa de Entrada'),
            // MenuDrawer(icon: Icons.work_outline, title: 'Caixa de Trabalho'),
            // MenuDrawer(icon: Icons.outbox, title: 'Caixa de Saída'),
            MenuDrawer(icon: CupertinoIcons.tray_arrow_down, title: 'Solicitações Recebidas'),
            MenuDrawer(icon: CupertinoIcons.tray_arrow_up, title: 'Solicitações Enviadas'),

            SizedBox(height: 20),

            Row(
              spacing: 5,
              children: [
                Icon(Icons.business_center, color: cs.primary, size: 20),
                Text('Unidade', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
              ],
            ),
            // MenuDrawer(icon: Icons.inbox, title: 'Caixa de Entrada'),
            // MenuDrawer(icon: Icons.work_outline, title: 'Caixa de Trabalho'),
            // MenuDrawer(icon: Icons.outbox, title: 'Caixa de Saída'),
            MenuDrawer(icon: CupertinoIcons.tray_arrow_down, title: 'Solicitações Recebidas'),
            MenuDrawer(icon: CupertinoIcons.tray_arrow_up, title: 'Solicitações Enviadas'),
          ],
        );
      },
    );
  }
}
