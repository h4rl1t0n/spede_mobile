import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../core/constants/images.dart';
import '../../../../core/extensions/size_extension.dart';
import '../../../../core/helpers/loader.dart';
import '../../../../core/helpers/messages.dart';
import '../../../../enum/page_status.dart';
import 'agenda_controller.dart';
import 'widgets/calendario_item/calendario_item.dart';
import 'widgets/filtro_setor_dialog/filtro_setor_dialog.dart';
import 'widgets/lembrete_item/header_lembrete.dart';
import 'widgets/lembrete_item/lembrete_item.dart';
import 'widgets/lembrete_item/nenhum_lembrete_container.dart';
import 'widgets/secao_header.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> with Loader, Messages {
  final controller = inject<AgendaController>();
  final panelController = PanelController();
  late List<ReactionDisposer> disposers = [];

  @override
  void initState() {
    super.initState();
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
    final screenHeight = context.screenHeight;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(Images.logoTCE), fit: BoxFit.cover),
        ),
        child: Observer(
          builder: (context) {
            final mes = controller.mes;
            final data = controller.data;
            final listEventosPorDia = controller.listEventosPorDia;
            final setorFiltrado = controller.setorFiltrado;

            return SlidingUpPanel(
              controller: panelController,
              minHeight: screenHeight * 0.30,
              maxHeight: screenHeight * 0.70,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              color: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      height: context.screenHeight,
                      duration: const Duration(milliseconds: 250),
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: Column(
                        children: [
                          SecaoHeader(
                            title: setorFiltrado == null
                                ? 'Filtro: Todos os Setores'
                                : 'Filtro: Setor ${setorFiltrado.sigla}',
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.19),
                                  blurRadius: 3,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: CalendarioItem(
                                mes: mes,
                                selectedDate: data,
                                lembretesList: controller.listEventos,
                                calendarFormat: controller.calendarFormat,
                                onMonthChanged: (novoMes) async {
                                  controller.mes = novoMes;
                                  controller.data = novoMes;
                                  await controller.carregarEventos();
                                },
                                onDateSelected: (novaData) {
                                  controller.data = novaData;
                                },
                                onFormatChanged: controller.alterarFormato,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              panelBuilder: (ScrollController sc) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      HeaderLembrete(data: data, quantidade: listEventosPorDia.length),

                      const SizedBox(height: 5),

                      Expanded(
                        child: Builder(
                          builder: (context) {
                            if (listEventosPorDia.isEmpty) {
                              return const NenhumLembreteContainer();
                            }

                            return ListView.separated(
                              controller: sc,
                              padding: const EdgeInsets.all(16).copyWith(bottom: kFloatingActionButtonMargin + 80),
                              itemCount: listEventosPorDia.length,
                              separatorBuilder: (_, _) => const SizedBox(height: 12),
                              itemBuilder: (_, index) {
                                return LembreteItem(lembrete: listEventosPorDia[index]);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: abrirFiltroSetor,
        label: Text('Filtros da Consulta'),
        icon: Icon(Icons.tune_rounded),
      ),
    );
  }

  Future<void> abrirFiltroSetor() async {
    await showDialog(
      context: context,
      builder: (context) {
        return FiltroSetorDialog(controller: controller);
      },
    );
  }

  void setupReactions() {
    disposers = [
      reaction((_) => controller.status, (status) {
        switch (status) {
          case PageStatus.initial:
            break;
          case PageStatus.loading:
            showLoader(messageLoader: controller.messageLoader);
            break;
          case PageStatus.loaded:
            hideLoader();
            break;
          case PageStatus.success:
            hideLoader();
            break;
          case PageStatus.error:
            hideLoader();
            showError(controller.errorMessage ?? 'Erro ao carregar os lembretes');
            break;
        }
      }),
      when((_) => controller.listEventos.isEmpty, () {
        controller.carregarEventos();
      }),
    ];
  }
}
