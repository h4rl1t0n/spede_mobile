import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../app_module.dart';
import '../../core/helpers/loader.dart';
import '../../core/helpers/messages.dart';
import '../../enum/tipo_caixa.dart';
import '../../models/setor_model.dart';
import '../../models/usuario_model.dart';
import '../../shared/data/solicitacao/dto/solicitacao_response_dto.dart';
import 'home_controller.dart';
import 'pages/agenda/agenda_page.dart';
import 'pages/solicitacao/solicitacao_page.dart';
import 'widgets/selecionar_setor_dialog/selecionar_setor_dialog.dart';

class HomePage extends StatefulWidget {
  final UsuarioModel usuario;
  final List<SetorModel> setores;
  final SolicitacoesResponse solicitacao;

  const HomePage({super.key, required this.usuario, required this.setores, required this.solicitacao});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Loader, Messages {
  final controller = Modular.get<HomeController>();

  UsuarioModel get usuario => widget.usuario;
  List<SetorModel>? get setores => widget.setores;
  SolicitacoesResponse get solicitacao => widget.solicitacao;
  late List<ReactionDisposer> disposers = [];

  @override
  void initState() {
    controller.listaDeSetores = setores ?? [];
    controller.usuario = usuario;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.atualizarBadges(solicitacao.enviadas.length, solicitacao.recebidas.length);
      await controller.initController();
      setupReactions();
    });

    super.initState();
  }

  @override
  void dispose() {
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
        final setor = controller.setorSelecionado;
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            leadingWidth: 60,
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
              IconButton(
                onPressed: () async {
                  await Modular.to.pushNamed(Routes.notificacao);
                },
                icon: Icon(Icons.notifications),
              ),
              IconButton(
                onPressed: () async {
                  await Modular.to.pushNamed(Routes.perfil, arguments: controller.usuario);
                },
                icon: CircleAvatar(child: Text(controller.usuario?.avatar ?? '')),
              ),

              const SizedBox(width: 10),
            ],
          ),

          body: Builder(
            builder: (context) {
              final enviadas = solicitacao.enviadas;
              final recebidas = solicitacao.recebidas;
              return IndexedStack(
                index: page,
                children: [
                  SolicitacaoPage(solicitacaoes: enviadas, tipoCaixa: TipoCaixa.enviadas),
                  SolicitacaoPage(solicitacaoes: recebidas, tipoCaixa: TipoCaixa.recebidas),
                  AgendaPage(),
                ],
              );
            },
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade400, width: .5)),
            ),
            child: Observer(
              builder: (context) {
                final qtdEnviadas = controller.qtdEnviadas;
                final qtdRecebidas = controller.qtdRecebidas;

                return NavigationBar(
                  selectedIndex: page,
                  onDestinationSelected: controller.setPage,
                  destinations: [
                    NavigationDestination(
                      icon: Badge.count(count: qtdEnviadas, child: Icon(CupertinoIcons.tray_arrow_up)),
                      selectedIcon: Badge.count(count: qtdEnviadas, child: Icon(CupertinoIcons.tray_arrow_up_fill)),
                      label: 'Solicitações Enviadas',
                    ),
                    NavigationDestination(
                      icon: Badge.count(count: qtdRecebidas, child: Icon(CupertinoIcons.tray_arrow_down)),
                      selectedIcon: Badge.count(count: qtdRecebidas, child: Icon(CupertinoIcons.tray_arrow_down_fill)),
                      label: 'Solicitações Recebidas',
                    ),
                    NavigationDestination(
                      icon: Badge.count(count: 3, child: Icon(Icons.calendar_month_outlined)),
                      selectedIcon: Badge.count(count: 3, child: Icon(Icons.calendar_month)),
                      label: 'Lembretes',
                      tooltip: 'Lembretes',
                    ),
                  ],
                );
              },
            ),
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
}
