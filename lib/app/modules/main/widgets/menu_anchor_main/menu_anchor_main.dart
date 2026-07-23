import 'package:flutter/cupertino.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

    return MenuAnchor(
      style: MenuStyle(
        elevation: WidgetStatePropertyAll(8),
        backgroundColor: WidgetStatePropertyAll(Colors.white),
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      ),
      animated: true,
      builder: (context, controller, child) {
        return IconButton(
          onPressed: () {
            controller.isOpen ? controller.close() : controller.open();
          },
          icon: CircleAvatar(child: Text(usuario?.avatar ?? '')),
        );
      },
      menuChildren: [
        SizedBox(
          width: 290,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: colorScheme.primary,
                      radius: 24,
                      child: Text(
                        usuario?.avatar ?? '',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            usuario?.firstName.toUpperCase() ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Observer(
                            builder: (context) {
                              final setor = controller.setorSelecionado;
                              final nome = setor?.nome ?? '';

                              return Text(
                                nome.toUpperCase(),
                                textAlign: .start,
                                style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              MenuItemButton(
                leadingIcon: const Icon(Icons.business_outlined),
                trailingIcon: const Icon(Icons.chevron_right),
                onPressed: openSelecionarSetorDialog,
                child: Text('Alterar Setor'),
              ),

              const Divider(height: 5),

              MenuItemButton(
                leadingIcon: const Icon(CupertinoIcons.square_arrow_right, color: Colors.red),
                onPressed: sair,
                trailingIcon: const Icon(Icons.chevron_right),
                child: Text('Sair', style: TextStyle(color: Colors.red)),
              ),

              SizedBox(height: 10),
            ],
          ),
        ),
      ],
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
