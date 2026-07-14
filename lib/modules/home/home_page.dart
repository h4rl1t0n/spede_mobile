import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../agenda/agenda_page.dart';
import '../perfil/perfil_page.dart';
import '../solicitacao/solicitacao_page.dart';
import 'home_controller.dart';
import 'widgets/drawer/custom_drawer.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.initController();

      if (controller.setorSelecionado == null) {
        await openSelecionarSetorDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
      drawer: CustomDrawer(controller: controller),
      body: SolicitacaoPage(title: widget.title),
    );
  }

  Future<void> openSelecionarSetorDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SelecionarSetorDialog(controller: controller);
      },
    );
  }
}
