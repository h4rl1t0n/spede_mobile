import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../agenda/agenda_page.dart';
import '../login/login_page.dart';
import '../perfil/perfil_page.dart';
import '../solicitacao/solicitacao_page.dart';
import 'widgets/drawer/drawer_content.dart';
import 'widgets/drawer/drawer_head.dart';
import 'widgets/menu_drawer/menu_drawer.dart';

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cs.primary,
        title: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              height: 50,
              child: Image.asset('assets/images/spede_home.png'),
            ),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () async {}),
          IconButton(
            icon: Icon(Icons.calendar_month),
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (_) => const AgendaPage()));
            },
          ),
          IconButton(
            icon: CircleAvatar(child: Text('AS')),
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (_) => const PerfilPage()));
            },
          ),
          SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,

        child: Column(
          children: [
            DrawerHead(),
            Expanded(child: DrawerContent()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: MenuDrawer(
                icon: CupertinoIcons.square_arrow_right,
                color: cs.error,
                title: 'Sair',
                onTap: () {
                  final navigator = Navigator.of(context);
                  navigator.pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ),
            Text('v2.10.30'),
            SizedBox(height: 30),
          ],
        ),
      ),
      body: SolicitacaoPage(title: title),
    );
  }
}
