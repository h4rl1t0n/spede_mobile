import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Observer(
        builder: (context) {
          final mes = controller.mes;
          final data = controller.data;
          final listEventosPorDia = controller.listEventosPorDia;
          final setorFiltrado = controller.setorFiltrado;

          return Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month_rounded, color: colorScheme.primary, size: 28),
                    const SizedBox(width: 12),
                    const Text('Agenda', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),

                    const Spacer(),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        spacing: 6,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.tune_rounded, size: 16, color: colorScheme.onPrimaryContainer),
                          Text(
                            setorFiltrado == null ? 'Todos os Setores' : setorFiltrado.sigla,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: .05), blurRadius: 15, offset: const Offset(0, 5)),
                  ],
                ),
                child: Observer(
                  builder: (context) {
                    return CalendarioItem(
                      mes: mes,
                      selectedDate: data,
                      lembretesList: controller.listEventos,
                      calendarFormat: controller.calendarFormat,
                      onMonthChanged: (novoMes) async {
                        controller.mes = novoMes;
                        await controller.carregarEventos();
                      },
                      onDateSelected: (novaData) {
                        controller.data = novaData;
                      },
                      onFormatChanged: controller.alterarFormato,
                    );
                  },
                ),
              ),
              Flexible(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                  child: Material(
                    color: colorScheme.surface,
                    child: Column(
                      children: [
                        HeaderLembrete(data: data, quantidade: listEventosPorDia.length),
                        SizedBox(height: 5),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              if (listEventosPorDia.isEmpty) {
                                return const NenhumLembreteContainer();
                              }

                              return ListView.separated(
                                padding: const EdgeInsets.all(16).copyWith(bottom: kFloatingActionButtonMargin + 60),
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
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: abrirFiltroSetor,
        label: Text('Filtros por Setor'),
        icon: Icon(Icons.tune_rounded, color: Colors.white),
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
