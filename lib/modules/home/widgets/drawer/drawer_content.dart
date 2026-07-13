import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../home_page.dart';
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
          padding: const EdgeInsets.only(top: 8, bottom: 20, left: 12, right: 12),
          children: [
            SizedBox(height: 5),
            Row(
              spacing: 5,
              children: [
                Icon(Icons.person, color: cs.primary, size: 20),
                Text('Pessoal', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
              ],
            ),
            MenuDrawer(
              icon: CupertinoIcons.tray_arrow_down,
              title: 'Solicitações Recebidas',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage(title: 'Pessoal > Solicitações Recebidas')),
                );
              },
            ),
            MenuDrawer(
              icon: CupertinoIcons.tray_arrow_up,
              title: 'Solicitações Enviadas',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage(title: 'Pessoal > Solicitações Enviadas')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
