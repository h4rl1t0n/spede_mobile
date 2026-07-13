import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../agenda/agenda_page.dart';
import '../login/login_page.dart';
import '../perfil/perfil_page.dart';
import '../solicitacao/solicitacao_page.dart';
import 'widgets/drawer/drawer_content.dart';
import 'widgets/drawer/drawer_head.dart';
import 'widgets/menu_drawer/menu_drawer.dart';
import 'widgets/selecionar_setor_dialog/selecionar_setor_dialog.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => openSelecionarSetorDialog());
  }

  String nomeSetor = 'Setin';

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
            DrawerHead(nomeSetor: nomeSetor),
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
      body: SolicitacaoPage(title: widget.title),
    );
  }

  Future<void> openSelecionarSetorDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return SelecionarSetorDialog();
      },
    );

    setState(() {
      nomeSetor = result ?? 'Setin';
    });
  }
}
