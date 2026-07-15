import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
      await openSelecionarSetorDialog();
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
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: .centerStart,
              child: Image.asset('assets/images/spede_home_hml.png', height: 30, fit: .contain),
            ),
            Observer(
              builder: (context) {
                final setor = controller.setorSelecionado;

                if (setor != null) {
                  return Align(
                    alignment: .centerLeft,
                    child: Text(
                      setor.nome.toUpperCase(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  );
                }

                return SizedBox.shrink();
              },
            ),
          ],
        ),
        // actions: [
        //   IconButton(
        //     icon: CircleAvatar(child: Text('AS')),
        //     onPressed: () async {
        //       await Navigator.push(context, MaterialPageRoute(builder: (_) => const PerfilPage()));
        //     },
        //   ),
        //   SizedBox(width: 10),
        // ],
      ),
      drawer: CustomDrawer(controller: controller),
      body: Observer(
        builder: (_) {
          return SolicitacaoPage(
            key: ValueKey(controller.setorSelecionado?.id),
            title: widget.title,
            controller: controller,
          );
        },
      ),
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
