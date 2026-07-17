import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../enum/tipo_caixa.dart';
import '../../models/usuario_model.dart';
import 'home_controller.dart';
import 'pages/agenda/agenda_page.dart';
import 'pages/solicitacao/solicitacao_page.dart';
import 'widgets/drawer/custom_drawer.dart';
import 'widgets/selecionar_setor_dialog/selecionar_setor_dialog.dart';

class HomePage extends StatefulWidget {
  final UsuarioModel usuario;
  const HomePage({super.key, required this.usuario});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();

    controller.usuario = widget.usuario;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.initController();
      if (!mounted) return;
      await openSelecionarSetorDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final page = controller.currentPage;
        final setor = controller.setorSelecionado;
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            leading: Image.asset('assets/images/spede_home_prod.png', fit: .contain),
            title: Visibility(
              visible: setor != null,
              child: Align(
                alignment: .centerLeft,
                child: Text(
                  setor?.nome.toUpperCase() ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
            actions: [
              Builder(
                builder: (context) =>
                    IconButton(icon: const Icon(Icons.menu), onPressed: () => Scaffold.of(context).openEndDrawer()),
              ),
              IconButton(
                onPressed: () {},
                icon: CircleAvatar(child: Text(controller.usuario?.avatar ?? '')),
              ),

              const SizedBox(width: 10),
            ],
          ),
          endDrawer: CustomDrawer(controller: controller),
          body: Builder(
            builder: (context) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: IndexedStack(
                  key: ValueKey(page),
                  index: page,
                  children: [
                    SolicitacaoPage(
                      key: ValueKey(controller.setorSelecionado?.id),
                      caixa: TipoCaixa.enviadas,
                      setor: controller.setorSelecionado,
                    ),
                    SolicitacaoPage(
                      key: ValueKey(controller.setorSelecionado?.id),
                      caixa: TipoCaixa.recebidas,
                      setor: controller.setorSelecionado,
                    ),
                    AgendaPage(),
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade400, width: .5)),
            ),
            child: NavigationBar(
              selectedIndex: page,
              onDestinationSelected: controller.setPage,
              destinations: [
                NavigationDestination(
                  icon: Icon(CupertinoIcons.tray_arrow_up),
                  selectedIcon: Icon(CupertinoIcons.tray_arrow_up_fill),
                  label: 'Solicitações Enviadas',
                ),
                NavigationDestination(
                  icon: Icon(CupertinoIcons.tray_arrow_down),
                  selectedIcon: Icon(CupertinoIcons.tray_arrow_down_fill),
                  label: 'Solicitações Recebidas',
                ),
                NavigationDestination(
                  icon: Badge.count(count: 3, child: Icon(Icons.calendar_month_outlined)),
                  selectedIcon: Badge.count(count: 3, child: Icon(Icons.calendar_month)),
                  label: 'Minha Agenda',
                  tooltip: '8',
                ),
              ],
            ),
          ),
        );
      },
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
