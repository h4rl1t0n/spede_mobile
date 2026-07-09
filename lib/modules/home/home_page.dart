import 'package:flutter/material.dart';

import '../calendario/calendario_page.dart';
import '../perfil/perfil_page.dart';
import '../solicitacao/solicitacao_page.dart';
import 'widgets/drawer/drawer_home.dart';

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
          IconButton(
            icon: Icon(Icons.calendar_month),
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (_) => const CalendarPage()));
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
      drawer: DrawerHome(),
      body: SolicitacaoPage(title: title),
    );
  }
}
