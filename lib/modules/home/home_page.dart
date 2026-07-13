import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../agenda/agenda_page.dart';
import '../login/login_page.dart';
import '../perfil/perfil_page.dart';
import '../solicitacao/solicitacao_page.dart';
import 'home_controller.dart';
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
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => openSelecionarSetorDialog());
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        toolbarHeight: 80,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: .centerStart,
              child: Image.asset('assets/images/spede_home.png', height: 30, fit: .contain),
            ),
            Observer(
              builder: (context) {
                final setor = controller.setorSelecionado;

                if (setor != null) {
                  return Text(
                    setor.nome.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, color: Colors.white),
                  );
                }

                return SizedBox.shrink();
              },
            ),
          ],
        ),
        actions: [
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
            DrawerHead(controller: controller),
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
    if (controller.setorSelecionado != null) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SelecionarSetorDialog(controller: controller);
      },
    );
  }
}
