import 'package:flutter/material.dart';

import '../calendario/calendario_page.dart';
import '../perfil/perfil_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
    );
  }
}
