import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'agenda_controller.dart';
import 'widgets/calendario_item/calendario_item.dart';
import 'widgets/filtro_setor_dialog/filtro_setor_dialog.dart';
import 'widgets/lembrete_item/header_lembrete.dart';
import 'widgets/lembrete_item/lembrete_item.dart';
import 'widgets/lembrete_item/nenhum_lembrete_container.dart';

class AgendaPage extends StatelessWidget {
  AgendaPage({super.key});

  final controller = Modular.get<AgendaController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 5,
          children: [_buildHeader(colorScheme), _buildCalendario(context), _buildListaLembretes(context)],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildHeader(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          Icon(Icons.calendar_month, color: colorScheme.primary),
          const SizedBox(width: 8),
          const Text('Agenda', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      ),
    );
  }

  Widget _buildCalendario(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Observer(
        builder: (_) {
          return CalendarioItem(
            setor: controller.setorFiltrado?.sigla,
            mes: controller.mes,
            selectedDate: controller.data,
            lembretesList: controller.lembretesFiltrados,
            calendarFormat: controller.calendarFormat,
            onMonthChanged: (novoMes) => controller.mes = novoMes,
            onDateSelected: (novaData) => controller.data = novaData,
            onFormatChanged: controller.alterarFormato,
          );
        },
      ),
    );
  }

  Widget _buildListaLembretes(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: Material(
          color: Theme.of(context).colorScheme.surface,
          child: Observer(
            builder: (_) {
              final data = controller.data;
              final lista = controller.lista;

              return Column(
                children: [
                  HeaderLembrete(data: data, quantidade: lista.length),
                  const SizedBox(height: 5),
                  Expanded(
                    child: lista.isEmpty
                        ? const NenhumLembreteContainer()
                        : ListView.separated(
                            padding: const EdgeInsets.all(16).copyWith(bottom: kFloatingActionButtonMargin + 80),
                            itemCount: lista.length,
                            separatorBuilder: (_, _) => const SizedBox(height: 12),
                            itemBuilder: (_, index) {
                              return LembreteItem(lembrete: lista[index]);
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Observer(
      builder: (_) {
        final temFiltroAtivo = controller.setorFiltrado != null;

        return FloatingActionButton.extended(
          onPressed: () => _abrirFiltroSetor(context),
          label: const Text('Filtros por Setor'),
          icon: Icon(temFiltroAtivo ? Icons.filter_alt : Icons.filter_alt_outlined, color: Colors.white),
        );
      },
    );
  }

  Future<void> _abrirFiltroSetor(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return FiltroSetorDialog(controller: controller);
      },
    );
  }
}
