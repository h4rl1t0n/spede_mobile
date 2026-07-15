import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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

class _AgendaPageState extends State<AgendaPage> {
  final controller = AgendaController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agenda'), centerTitle: true),
      body: SafeArea(
        child: Column(
          spacing: 10,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: .05), blurRadius: 15, offset: const Offset(0, 5)),
                ],
              ),
              child: Observer(
                builder: (context) {
                  final mes = controller.mes;
                  final data = controller.data;
                  final lembretesFiltrados = controller.lembretesFiltrados;

                  return CalendarioItem(
                    mes: mes,
                    selectedDate: data,
                    lembretesList: lembretesFiltrados,
                    onMonthChanged: (novoMes) {
                      controller.mes = novoMes;
                    },
                    onDateSelected: (novaData) {
                      controller.data = novaData;
                    },
                  );
                },
              ),
            ),

            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                child: Material(
                  color: Theme.of(context).colorScheme.surface,
                  child: Observer(
                    builder: (context) {
                      final data = controller.data;
                      final lista = controller.lista;
                      return Column(
                        children: [
                          HeaderLembrete(data: data, quantidade: lista.length),
                          SizedBox(height: 5),
                          Expanded(
                            child: Builder(
                              builder: (context) {
                                if (lista.isEmpty) {
                                  return const NenhumLembreteContainer();
                                }

                                return ListView.separated(
                                  padding: const EdgeInsets.all(16).copyWith(bottom: kFloatingActionButtonMargin + 60),
                                  itemCount: lista.length,
                                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                                  itemBuilder: (_, index) {
                                    return LembreteItem(lembrete: lista[index]);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Observer(
        builder: (context) {
          final setorFiltrado = controller.setorFiltrado;
          return FloatingActionButton.extended(
            onPressed: abrirFiltroSetor,
            label: Text('Filtros por Setor'),
            icon: Icon(setorFiltrado == null ? Icons.filter_alt_outlined : Icons.filter_alt, color: Colors.white),
          );
        },
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
}
