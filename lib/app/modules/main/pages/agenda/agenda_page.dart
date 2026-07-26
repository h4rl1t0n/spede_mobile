import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart'; // <-- Importe o pacote

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

    return Observer(
      builder: (context) {
        final mes = controller.mes;
        final data = controller.data;
        final listEventosPorDia = controller.listEventosPorDia;
        final setorFiltrado = controller.setorFiltrado;

        return SlidingUpPanel(
          controller: panelController,
          minHeight: screenHeight * 0.26,
          maxHeight: screenHeight * 0.60,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          color: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: Row(
                    children: [
                      FilledButton.tonalIcon(
                        onPressed: abrirFiltroSetor,
                        icon: const Icon(Icons.tune_rounded, size: 18),
                        label: Text(
                          setorFiltrado == null ? 'Filtro: Todos os Setores' : 'Filtro: Setor ${setorFiltrado.sigla}',
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  color: Colors.transparent,
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
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
                      decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(10)),
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
    );
  }

  // floatingActionButton: FloatingActionButton.extended(
  //   onPressed = abrirFiltroSetor,
  //   label = const Text('Filtros por Setor'),
  //   icon = const Icon(Icons.tune_rounded, color: Colors.white),
  // ),

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
