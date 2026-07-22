import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app_module.dart';
import '../../core/global/local_storage_utils.dart';
import '../../models/usuario_model.dart';
import 'controller/perfil_controller.dart';
import 'widgets/header_perfil_container.dart';
import 'widgets/menu_pefil_tile.dart';
import 'widgets/selecionar_setor_dialog.dart';

class PerfilPage extends StatefulWidget {
  final UsuarioModel usuario;

  const PerfilPage({super.key, required this.usuario});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final controller = Modular.get<PerfilController>();
  UsuarioModel get usuario => widget.usuario;

  @override
  void initState() {
    super.initState();
    controller.usuario = widget.usuario;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.initController();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Perfil', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [cs.primary, Color.lerp(cs.primary, Colors.black, .18)!],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          HeaderPerfilContainer(controller: controller),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 16, bottom: 0, left: 16, right: 16),
              children: [
                MenuPefilTile(
                  icon: Icons.business,
                  trailing: const Icon(Icons.chevron_right),
                  title: 'Alterar Setor',
                  onTap: () async => openSelecionarSetorDialog(),
                ),
                MenuPefilTile(
                  icon: CupertinoIcons.square_arrow_right,
                  title: 'Sair',
                  trailing: const Icon(Icons.chevron_right, color: Colors.red),
                  color: cs.error,
                  onTap: () async {
                    await sair();
                  },
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0).copyWith(bottom: 10),
            child: Text(
              'v2.10.30',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
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
    Modular.to.navigate(Routes.inicializar);
  }
}
