import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/global/local_storage_utils.dart';
import '../../../../models/usuario_model.dart';
import '../../main_controller.dart';
import '../selecionar_setor_dialog/selecionar_setor_dialog.dart';

class MenuAnchorMain extends StatefulWidget {
  final MainController controller;

  const MenuAnchorMain({super.key, required this.controller});

  @override
  State<MenuAnchorMain> createState() => _MenuAnchorMainState();
}

class _MenuAnchorMainState extends State<MenuAnchorMain> {
  MainController get controller => widget.controller;
  UsuarioModel? get usuario => controller.usuario;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: MenuStyle(
        elevation: const WidgetStatePropertyAll(6),
        backgroundColor: const WidgetStatePropertyAll(Colors.white),
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey.shade200),
          ),
        ),
      ),
      animated: true,
      builder: (context, controller, child) {
        return IconButton(
          onPressed: () {
            controller.isOpen ? controller.close() : controller.open();
          },
          icon: CircleAvatar(
            backgroundColor: Colors.blueGrey.shade50,
            foregroundColor: Colors.blueGrey.shade800,
            child: Text(usuario?.avatar ?? '', style: TextStyle(color: Colors.blueGrey.shade800)),
          ),
        );
      },
      menuChildren: [
        SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 13,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blueGrey.shade50,
                          foregroundColor: Colors.blueGrey.shade800,
                          radius: 26,
                          child: Text(
                            usuario?.avatar ?? 'AS',
                            style: TextStyle(
                              color: Colors.blueGrey.shade800,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                usuario?.firstName.toUpperCase() ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                usuario?.email.toLowerCase() ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Setor Selecionado',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87),
                    ),

                    Observer(
                      builder: (context) {
                        final setor = controller.setorSelecionado;
                        final nome = setor?.nome ?? '';

                        return Text(
                          nome.toUpperCase(),
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.grey.shade600,
                            height: 1.3,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              Divider(height: 1, color: Colors.grey.shade200, thickness: 1),

              const SizedBox(height: 8),

              _buildMenuItem(icon: Icons.domain, label: 'Alterar Setor', onPressed: openSelecionarSetorDialog),

              _buildMenuItem(icon: Icons.logout, label: 'Sair', onPressed: sair),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }

  // Widget auxiliar para padronizar os botões do menu
  Widget _buildMenuItem({required IconData icon, required String label, required VoidCallback onPressed}) {
    return MenuItemButton(
      style: MenuItemButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        foregroundColor: Colors.grey.shade700,
      ),
      leadingIcon: Icon(icon, color: Colors.grey.shade600, size: 22),
      onPressed: onPressed,
      trailingIcon: Icon(Icons.chevron_right_rounded, color: Colors.grey.shade600),
      child: Text(
        label,
        style: TextStyle(fontSize: 15, color: Colors.grey.shade700, fontWeight: FontWeight.w400),
      ),
    );
  }

  Future<void> sair() async {
    await LocalStorageUtils.clean();
    Modular.to.navigate(Routes.inicializar);
  }

  Future<void> openSelecionarSetorDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(canPop: false, child: SelecionarSetorDialog(controller: controller, initializer: false));
      },
    );
  }
}
