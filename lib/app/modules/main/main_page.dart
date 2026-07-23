import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/constants/images.dart';
import '../../core/constants/routes.dart';
import '../../core/helpers/loader.dart';
import '../../core/helpers/messages.dart';
import '../../enum/tipo_caixa.dart';
import '../../models/setor_model.dart';
import '../../models/usuario_model.dart';
import '../../shared/data/solicitacao/dto/dashboard_resumo_model.dart';
import 'main_controller.dart';
import 'pages/agenda/agenda_page.dart';
import 'pages/home/home_page.dart';
import 'pages/solicitacao/solicitacao_page.dart';
import 'widgets/selecionar_setor_dialog/selecionar_setor_dialog.dart';

class MainPage extends StatefulWidget {
  final UsuarioModel usuario;
  final DashboardResumoModel resumo;
  final List<SetorModel> setores;

  const MainPage({super.key, required this.usuario, required this.setores, required this.resumo});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with Loader, Messages, SingleTickerProviderStateMixin {
  final controller = Modular.get<MainController>();

  DashboardResumoModel get resumo => widget.resumo;
  UsuarioModel get usuario => widget.usuario;
  List<SetorModel>? get setores => widget.setores;
  late List<ReactionDisposer> disposers = [];
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    controller.listaDeSetores = setores ?? [];
    controller.usuario = usuario;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.initController();
      setupReactions();
    });

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();

    for (final disposer in disposers) {
      disposer();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final page = controller.currentPage;
        return Scaffold(
          backgroundColor: const Color(0xffF5F7FB),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            toolbarHeight: 80,
            leading: Image.asset(Images.spedeAppBar, fit: .contain),
            title: buildTitle(),
            actions: [
              IconButton(
                onPressed: () async {
                  await Modular.to.pushNamed(Routes.notificacao);
                },
                icon: Icon(Icons.notifications),
              ),
              IconButton(
                onPressed: () async {
                  await Modular.to.pushNamed(Routes.perfil, arguments: controller.usuario);
                  await controller.initController();
                },
                icon: CircleAvatar(child: Text(controller.usuario?.avatar ?? '')),
              ),
              const SizedBox(width: 10),
            ],
          ),

          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(Images.logoTCE), fit: BoxFit.cover),
            ),
            child: TabBarView(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                HomePage(usuarioLogado: controller.usuario ?? usuario, resumo: resumo),
                SolicitacaoPage(caixa: TipoCaixa.recebidas),
                SolicitacaoPage(caixa: TipoCaixa.enviadas),
                AgendaPage(),
              ],
            ),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: page,
            onDestinationSelected: (index) {
              tabController.animateTo(index, duration: const Duration(milliseconds: 350), curve: Curves.easeInOutCubic);
              controller.setPage(index);
            },
            destinations: [
              NavigationDestination(
                icon: Icon(CupertinoIcons.house),
                selectedIcon: Icon(CupertinoIcons.house_fill),
                label: 'Home',
                tooltip: 'Home',
              ),
              NavigationDestination(
                icon: Icon(CupertinoIcons.tray_arrow_down),
                selectedIcon: Icon(CupertinoIcons.tray_arrow_down_fill),
                label: 'Solic. Recebidas',
                tooltip: 'Solicitações Recebidas',
              ),
              NavigationDestination(
                icon: Icon(CupertinoIcons.tray_arrow_up),
                selectedIcon: Icon(CupertinoIcons.tray_arrow_up_fill),
                label: 'Solic. Enviadas',
                tooltip: 'Solicitações Enviadas',
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_month_outlined),
                selectedIcon: Icon(Icons.calendar_month),
                label: 'Lembretes',
                tooltip: 'Lembretes',
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> openSelecionarSetorDialog({required bool initializer}) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: SelecionarSetorDialog(controller: controller, initializer: initializer),
        );
      },
    );
  }

  void setupReactions() {
    disposers = [
      reaction((_) => controller.setorSelecionado, (setorSelecionado) async {
        if (!mounted) return;

        if (setorSelecionado == null) {
          if (controller.listaDeSetores.length == 1) {
            controller.idSetorSelecionado = controller.listaDeSetores.first.id;
            await controller.salvarSetorSelecionado();
          } else {
            await openSelecionarSetorDialog(initializer: true);
          }
        }
      }, fireImmediately: true),
    ];
  }

  Widget buildTitle() => InkWell(
    onTap: () async {
      await openSelecionarSetorDialog(initializer: false);
    },
    child: Observer(
      builder: (context) {
        final nome = controller.usuario?.nome;
        final setor = controller.setorSelecionado?.sigla;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (setor != null) Text(setor, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            if (nome != null)
              Text(
                nome.toUpperCase(),
                style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400),
                overflow: TextOverflow.ellipsis,
              ),
          ],
        );
      },
    ),
  );
}
