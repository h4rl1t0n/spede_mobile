import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/global/local_storage_utils.dart';
import '../../../../mock/documentos.dart';
import '../../pages/agenda/agenda_page.dart';
import '../../../inicializar_app/inicializar_app_page.dart';
import '../../home_controller.dart';
import '../menu_drawer/menu_drawer.dart';
import '../selecionar_setor_dialog/selecionar_setor_dialog.dart';

class DrawerContent extends StatefulWidget {
  final HomeController controller;
  const DrawerContent({super.key, required this.controller});

  @override
  State<DrawerContent> createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  HomeController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final idSetor = controller.setorSelecionado?.id;
    final badge = documentos.where((element) => element.setorModel.id == idSetor).toList().length;

    return ListView(
      padding: const EdgeInsets.only(top: 8, bottom: 0, left: 16, right: 16),
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'SOLICITAÇÕES',
            style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.5),
          ),
        ),
        MenuDrawer(
          icon: CupertinoIcons.tray_arrow_down_fill,
          title: 'Solicitações Recebidas',
          trailing: Badge.count(count: badge, maxCount: 10, padding: .all(4), backgroundColor: cs.secondary),
          onTap: () {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (_) => const HomePage(title: 'Solicitações Recebidas')),
            // );
          },
        ),
        MenuDrawer(
          icon: CupertinoIcons.tray_arrow_up_fill,
          title: 'Solicitações Enviadas',
          trailing: Badge.count(count: badge, maxCount: 10, padding: .all(4), backgroundColor: cs.secondary),
          onTap: () {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (_) => const HomePage(title: 'Solicitações Enviadas')),
            // );
          },
        ),

        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'OUTROS',
            style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.5),
          ),
        ),
        MenuDrawer(
          icon: CupertinoIcons.calendar_today,
          title: 'Agenda',
          trailing: Icon(Icons.chevron_right),
          onTap: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (_) => const AgendaPage()));
          },
        ),
        MenuDrawer(
          icon: Icons.business,
          trailing: Icon(Icons.chevron_right),
          title: 'Alterar Setor',
          onTap: () async => openSelecionarSetorDialog(),
        ),
        MenuDrawer(
          icon: CupertinoIcons.square_arrow_right,
          title: 'Sair',
          trailing: Icon(Icons.chevron_right),
          color: cs.error,
          onTap: () async {
            await sair();
          },
        ),
      ],
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

  Future<void> sair() async {
    await LocalStorageUtils.clean();

    if (mounted) {
      final navigator = Navigator.of(context);
      await navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const InicializarAppPage()),
        (route) => false,
      );
    }
  }
}
