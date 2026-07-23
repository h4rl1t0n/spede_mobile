import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/helpers/loader.dart';
import '../../../../core/helpers/messages.dart';
import '../../../../enum/page_status.dart';
import '../../../../models/usuario_model.dart';
import '../../../../shared/data/solicitacao/dto/dashboard_resumo_model.dart';
import 'home_controller.dart';
import 'widgets/dashboard_item_card/dashboard_item_card.dart';

class HomePage extends StatefulWidget {
  final UsuarioModel usuarioLogado;
  final DashboardResumoModel resumo;
  const HomePage({super.key, required this.usuarioLogado, required this.resumo});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Messages, Loader {
  final controller = Modular.get<HomeController>();

  UsuarioModel get usuarioLogado => widget.usuarioLogado;
  DashboardResumoModel get resumo => widget.resumo;

  late List<ReactionDisposer> disposers = [];

  @override
  void initState() {
    super.initState();
    controller.setResumo(value: resumo);
    WidgetsBinding.instance.addPostFrameCallback((_) async => setupReactions());
  }

  @override
  void dispose() {
    for (var dispose in disposers) {
      dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;
    final secondary = colorScheme.secondary;
    final tertiary = colorScheme.tertiary;

    return SafeArea(
      child: Observer(
        builder: (context) {
          final resumo = controller.resumo;

          if (resumo == null) {
            return Center(child: Text(controller.errorMessage ?? 'Erro ao carregar os dados do dashboard'));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Olá, ${usuarioLogado.firstName}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text('Bem-vindo ao sistema', style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ),

              SizedBox(height: 10),

              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.carregarResumoDashboard();
                  },
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      DashboardCard(
                        title: 'Solicitações Recebidas',
                        value: resumo.totalRecebidos.toString(),
                        icon: CupertinoIcons.tray_arrow_down,
                        color: secondary,
                        items: resumo.setoresRecebidos,
                      ),
                      DashboardCard(
                        title: 'Solicitações Enviadas',
                        value: resumo.totalEnviados.toString(),
                        icon: CupertinoIcons.tray_arrow_up,
                        color: tertiary,
                        items: resumo.setoresEnviados,
                      ),
                      DashboardCard(
                        title: 'Eventos da Agenda',
                        value: '26',
                        icon: CupertinoIcons.calendar,
                        color: primary,
                        items: [],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void setupReactions() {
    disposers = [
      reaction((_) => controller.status, (status) {
        switch (status) {
          case PageStatus.initial:
            break;
          case PageStatus.loading:
            showLoader();
            break;
          case PageStatus.loaded:
            hideLoader();
            break;
          case PageStatus.success:
            hideLoader();
            break;
          case PageStatus.error:
            hideLoader();
            showError(controller.errorMessage ?? 'Erro ao carregar os dados do dashboard');
            break;
        }
      }),
    ];
  }
}
